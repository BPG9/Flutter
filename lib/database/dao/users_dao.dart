import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';
import 'package:moor/moor.dart';
import 'package:museum_app/server_connection/graphqlConf.dart';
import 'package:museum_app/server_connection/mutations.dart';
import 'package:mutex/mutex.dart';
import 'package:rxdart/rxdart.dart';

import '../modelling.dart';
import '../moor_db.dart';

part 'users_dao.g.dart';

@UseDao(tables: [Users, Tours])
class UsersDao extends DatabaseAccessor<MuseumDatabase> with _$UsersDaoMixin {
  final Mutex _mutex;

  UsersDao(MuseumDatabase db)
      : _mutex = Mutex(),
        super(db);

  Stream<User> watchUser() => select(users).watchSingle();

  Future<User> getUser() => select(users).getSingle();

  Future<bool> updateImage(String imgPath) async {
    initUser();

    String token = await MuseumDatabase().usersDao.accessToken();
    GraphQLClient _client = GraphQLConfiguration().clientToQuery();
    QueryResult result = await _client.mutate(MutationOptions(
      documentNode: gql(MutationBackend.chooseProfilePicture(imgPath, token)),
    ));

    bool b = result.data.data["chooseProfilePicture"]["ok"]["boolean"];
    if (b) {
      update(users).write(UsersCompanion(imgPath: Value(imgPath)));
    } else
      print(result.data.data);

    return b;
  }

  Future updateOnboard(bool b) async {
    await initUser();
    return update(users).write(UsersCompanion(onboardEnd: Value(b)));
  }

  Future setUser(UsersCompanion uc) {
    customStatement("DELETE FROM users");
    return into(users).insert(uc);
  }

  Future initUser() async {
    await customStatement(
        "INSERT INTO users (username, imgPath, onboardEnd, producer) SELECT '', 'assets/images/empty_profile.png', false, false WHERE NOT EXISTS (SELECT * FROM users)");
  }

  Future<bool> updateUsername(String name, String access) async {
    initUser();

    GraphQLClient _client = GraphQLConfiguration().clientToQuery();
    print(name);
    QueryResult result = await _client.mutate(MutationOptions(
      documentNode: gql(MutationBackend.changeUsername(access, name.trim())),
      update: (cache, result) => cache,
      onError: (e) => print("ERROR_changeUS " + e.toString()),
    ));

    if (result.hasException || result.data == null) return false;

    print(result.data);
    bool b = result.data['changeUsername']["ok"]["boolean"];
    if (b) {
      String refresh = result.data["changeUsername"]["refreshToken"];

      String oldName = await select(users).map((u) => u.username).getSingle();
      await batch((batch) {
        // update refreshToken
        batch.update(
          users,
          UsersCompanion(username: Value(name), refreshToken: Value(refresh)),
        );
        // update local TourAuthors
        batch.update(
          tours,
          ToursCompanion(author: Value(name)),
          where: (t) => t.author.equals(oldName),
        );
      });
      refreshAccess();
      //MuseumDatabase().refreshToken();
    } else
      print(result.data.data);
    return b;
  }

  Future<String> checkRefresh() async {
    String token = "";
    await _mutex.acquire();
    try {
      token = await accessToken();
      if (token != null &&
          token != "" &&
          !await GraphQLConfiguration.isConnected(token))
        token = await refreshAccess();
    } finally {
      _mutex.release();
    }
    return Future.value(token);
  }

  Future<String> refreshAccess() async {
    GraphQLClient _client = GraphQLConfiguration().clientToQuery();
    String refresh = await select(users).map((u) => u.refreshToken).getSingle();
    if (refresh == "") return Future.value("");

    QueryResult result = await _client.mutate(MutationOptions(
      documentNode: gql(MutationBackend.refresh(refresh)),
    ));

    if (result.hasException)
      print("EXC_refresh: " + result.exception.toString());
    else if (result.loading)
      print("LOADING");
    else {
      String newToken = result.data['refresh'].data["newToken"];
      update(users).write(UsersCompanion(accessToken: Value(newToken)));
      print("NEW TOKEN ${DateFormat("hh:mm:ss").format(DateTime.now())}");
      db.downloadStops();
      return Future.value(newToken);
    }
    return Future.value("");
  }

  Future<bool> onboardEnd() {
    return select(users).map((u) => u.onboardEnd).getSingle();
  }

  Future<String> accessToken() {
    return select(users).map((u) => u.accessToken).getSingle();
  }

  Future<bool> setProducer(String token, String code) async {
    print("Promotion-Code: $code");

    GraphQLClient _client = GraphQLConfiguration().clientToQuery();
    QueryResult result = await _client.mutate(MutationOptions(
        documentNode: gql(MutationBackend.promote(token, code)),
        update: (cache, result) => cache));
    if (result.hasException) {
      print("EXC_promote: " + result.exception.toString());
      return false;
    }
    bool b = result.data['promoteUser']["ok"]["boolean"];
    if (b)
      update(users).write(UsersCompanion(producer: Value(true)));
    return b;
  }

  Future addFavStop(String id) async {
    var stopIds = await select(users).map((u) => u.favStops).getSingle();
    stopIds.add(id);

    //String accessToken = await this.accessToken();
    //if (!await GraphQLConfiguration.isConnected(accessToken))
    //  accessToken = await refreshAccess();
    String token = await checkRefresh();

    GraphQLClient _client = GraphQLConfiguration().clientToQuery();
    QueryResult result = await _client.mutate(MutationOptions(
      documentNode: gql(MutationBackend.addFavStop(token, id)),
      onError: (e) => print("ERROR_addFavStop: " + e.toString()),
    ));

    if (result.data["addFavouriteObject"].data["ok"]["boolean"])
      update(users).write(UsersCompanion(favStops: Value(stopIds)));
  }

  Future removeFavStop(String id) async {
    var stopIds = await select(users).map((u) => u.favStops).getSingle();
    if (!stopIds.contains(id)) return;
    stopIds.remove(id);

//    String accessToken = await this.accessToken();
//    if (!await GraphQLConfiguration.isConnected(accessToken))
//      accessToken = await refreshAccess();
    String token = await checkRefresh();

    GraphQLClient _client = GraphQLConfiguration().clientToQuery();
    QueryResult result = await _client.mutate(MutationOptions(
      documentNode: gql(MutationBackend.removeFavStop(token, id)),
      onError: (e) => print("ERROR_removeFavStop: " + e.toString()),
    ));

    if (result.data["removeFavouriteObject"].data["ok"]["boolean"])
      update(users).write(UsersCompanion(favStops: Value(stopIds)));
  }

  Future<bool> isFavStop(String id) async {
    var stopIds = await select(users).map((u) => u.favStops).getSingle();

    return stopIds.where((fav) => fav == id).isNotEmpty;
  }

  Future<List<Stop>> getFavStops() async {
    var stopIds = await select(users).map((u) => u.favStops).getSingle();

    var query = select(db.stops)..where((s) => s.id.isIn(stopIds));
    return query.get();
  }

  Future addFavTour(String id) async {
    var tourIds = await select(users).map((u) => u.favTours).getSingle();
    tourIds.add(id);

//    String accessToken = await this.accessToken();
//    if (!await GraphQLConfiguration.isConnected(accessToken))
//      accessToken = await refreshAccess();
    String token = await checkRefresh();

    GraphQLClient _client = GraphQLConfiguration().clientToQuery();
    QueryResult result = await _client.mutate(MutationOptions(
      documentNode: gql(MutationBackend.addFavTour(token, id)),
      onError: (e) => print("ERROR_addFavTour: " + e.toString()),
    ));

    if (result.data["addFavouriteTour"].data["ok"]["boolean"])
      update(users).write(UsersCompanion(favTours: Value(tourIds)));
  }

  Future removeFavTour(String id) async {
    var tourIds = await select(users).map((u) => u.favTours).getSingle();
    if (!tourIds.contains(id)) return;
    tourIds.remove(id);

//    String accessToken = await this.accessToken();
//    if (!await GraphQLConfiguration.isConnected(accessToken))
//      accessToken = await refreshAccess();
    String token = await checkRefresh();

    GraphQLClient _client = GraphQLConfiguration().clientToQuery();
    QueryResult result = await _client.mutate(MutationOptions(
      documentNode: gql(MutationBackend.removeFavTour(token, id)),
      onError: (e) => print("ERROR_addFavTour: " + e.toString()),
    ));

    if (result.data["removeFavouriteTour"].data["ok"]["boolean"])
      update(users).write(UsersCompanion(favTours: Value(tourIds)));
  }

  Future<bool> isFavTour(String id) async {
    var tourIds = await select(users).map((u) => u.favTours).getSingle();

    return tourIds.where((fav) => fav == id).isNotEmpty;
  }

  @deprecated
  Stream<List<TourWithStops>> watchFavTours() {
    var tourIds = select(users).map((u) => u.favTours).watchSingle();

    //tourIds.forEach((list) => list.forEach((s) async => await joinAndDownloadTour(s, searchId: false)));

    var tours = db.getTourStops();

    return Rx.combineLatest2(
        tourIds,
        tours,
        (List<String> ids, List<TourWithStops> tours) =>
            tours.where((t) => ids.contains(t.onlineId)).toList());
  }
}
