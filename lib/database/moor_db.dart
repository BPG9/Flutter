import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:moor/moor.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:museum_app/constants.dart';
import 'package:museum_app/graphql/graphqlConf.dart';
import 'package:museum_app/graphql/mutations.dart';
import 'package:museum_app/graphql/query.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';

import 'modelling.dart';

part 'moor_db.g.dart';

String customName = "Individuell";

class Users extends Table {
  BoolColumn get producer => boolean()();

  TextColumn get accessToken =>
      text().withDefault(const Constant("")).named("accessToken")();

  TextColumn get refreshToken =>
      text().withDefault(const Constant("")).named("refreshToken")();

  TextColumn get username =>
      text().withLength(min: MIN_USERNAME, max: MAX_USERNAME)();

  TextColumn get imgPath => text().named("imgPath")();

  TextColumn get favStops => text()
      .withDefault(const Constant(""))
      .map(StringListConverter())
      .named("favStops")();

  TextColumn get favTours => text()
      .withDefault(const Constant(""))
      .map(StringListConverter())
      .named("favTours")();

  BoolColumn get onboardEnd =>
      boolean().withDefault(const Constant(false)).named("onboardEnd")();

  @override
  Set<Column> get primaryKey => {username};
}

class Badges extends Table {
  TextColumn get name => text()();

  RealColumn get current => real().withDefault(const Constant(0.0))();

  RealColumn get toGet => real()();

  IntColumn get color =>
      integer().withDefault(const Constant(0)).map(ColorConverter())();

  TextColumn get imgPath => text()();

  @override
  Set<Column> get primaryKey => {name};
}

class Tours extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get onlineId => text()();

  TextColumn get name =>
      text().withLength(min: MIN_TOURNAME, max: MAX_TOURNAME)();

  TextColumn get author =>
      text().withLength(min: MIN_USERNAME, max: MAX_USERNAME)();

  RealColumn get difficulty => real()();

  DateTimeColumn get creationTime => dateTime()();

  TextColumn get desc => text()();

  @override
  Set<Column> get primaryKey => {id};
}

class Stops extends Table {
  TextColumn get id => text()();

  //IMAGES
  TextColumn get images => text().map(StringListConverter())();

  TextColumn get name => text()();

  TextColumn get descr => text()();

  TextColumn get time => text().nullable()();

  TextColumn get creator => text().nullable()();

  TextColumn get division =>
      text().customConstraint("REFERENCES divisions(name)").nullable()();

  TextColumn get artType => text().nullable()();

  TextColumn get material => text().nullable()();

  TextColumn get size => text().nullable()();

  TextColumn get location => text().nullable()();

  TextColumn get interContext => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class TourStops extends Table {
  IntColumn get id => integer()();

  IntColumn get id_tour => integer().customConstraint("REFERENCES tours(id)")();

  TextColumn get id_stop => text().customConstraint("REFERENCES stops(id)")();
}

class Divisions extends Table {
  TextColumn get name => text()();

  IntColumn get color =>
      integer().withDefault(const Constant(0xFFFFFFFF)).map(ColorConverter())();

  @override
  Set<Column> get primaryKey => {name};
}

class Extras extends Table {
  // the extra's position on a certain page
  IntColumn get pos_extra => integer()();

  // the stop's position in the tour
  IntColumn get pos_stop => integer()();

  IntColumn get id_tour => integer().customConstraint("REFERENCES tours(id)")();

  TextColumn get id_stop => text().customConstraint("REFERENCES stops(id)")();

  TextColumn get textInfo => text()();

  IntColumn get type => integer().map(TaskTypeConverter()).nullable()();

  TextColumn get answerOpt => text().map(StringListConverter()).nullable()();

  TextColumn get answerCor => text().map(IntListConverter()).nullable()();

  @override
  Set<Column> get primaryKey => {pos_stop, pos_extra, id_tour, id_stop};
}

class StopFeatures extends Table {
  IntColumn get id => integer().customConstraint("REFERENCES tourStops(id)")();

  IntColumn get id_tour => integer().customConstraint("REFERENCES tours(id)")();

  TextColumn get id_stop => text().customConstraint("REFERENCES stops(id)")();

  BoolColumn get showImages => boolean().withDefault(const Constant(true))();

  BoolColumn get showText => boolean().withDefault(const Constant(true))();

  BoolColumn get showDetails => boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {id, id_tour, id_stop};
}

class ColorConverter extends TypeConverter<Color, int> {
  const ColorConverter();

  @override
  Color mapToDart(int fromDb) {
    return Color(fromDb);
  }

  @override
  int mapToSql(Color value) {
    return value.value;
  }
}

class StringListConverter extends TypeConverter<List<String>, String> {
  const StringListConverter();

  @override
  List<String> mapToDart(String fromDb) {
    if (fromDb != null && fromDb.isEmpty) return List<String>();
    return fromDb?.split(";");
  }

  @override
  String mapToSql(List<String> value) {
    return value?.join(";");
  }
}

class IntListConverter extends TypeConverter<List<int>, String> {
  const IntListConverter();

  @override
  List<int> mapToDart(String fromDb) {
    if (fromDb != null && fromDb.isEmpty) return List<int>();
    if (fromDb == null) return null;
    return fromDb.split(";").map((s) {
      var v = int.tryParse(s);
      return v ?? 0;
    }).toList();
  }

  @override
  String mapToSql(List<int> value) {
    return value?.join(";");
  }
}

class TaskTypeConverter extends TypeConverter<ExtraType, int> {
  const TaskTypeConverter();

  @override
  ExtraType mapToDart(int fromDb) {
    if (fromDb == null) return null;
    var values = ExtraType.values;
    if (0 <= fromDb && fromDb < values.length) return values[fromDb];
    print("NOT FOUND");
    return ExtraType.TEXT;
  }

  @override
  int mapToSql(ExtraType value) {
    if (value == null) return null;
    return value.index;
  }
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return VmDatabase(file);
  });
}

// this annotation tells moor to prepare a database class that uses both of the
// tables we just defined. We'll see how to use that database class in a moment.
@UseMoor(tables: [
  Users,
  Badges,
  Stops,
  Divisions,
  Tours,
  TourStops,
  Extras,
  StopFeatures
])
class MuseumDatabase extends _$MuseumDatabase {
  static MuseumDatabase _db;

  //static String customID = "Custom";

  factory MuseumDatabase() {
    _db ??= MuseumDatabase._create();
    return _db;
  }

  MuseumDatabase._create() : super(_openConnection());

  @override
  int get schemaVersion => 5;

  Stream<User> watchUser() => select(users).watchSingle();

  Future<User> getUser() => select(users).getSingle();

  Future setUser(UsersCompanion uc) {
    customStatement("DELETE FROM users");
    return into(users).insert(uc);
  }

  Future updateUsername(String name, String refresh) async {
    await initUser();
    String oldName = await select(users).map((u) => u.username).getSingle();
    await batch((batch) {
      batch.update(users,
          UsersCompanion(username: Value(name), refreshToken: Value(refresh)));
      batch.update(tours, ToursCompanion(author: Value(name)),
          where: ($ToursTable t) => t.author.equals(oldName));
    });
    refreshAccess();
  }

  Future setProducer() {
    return update(users).write(UsersCompanion(producer: Value(true)));
  }

  Future updateImage(String imgPath) async {
    await initUser();
    return update(users).write(UsersCompanion(imgPath: Value(imgPath)));
  }

  Future<bool> downloadStops({access = ""}) async {
    String accessToken = await this.accessToken();
    if (accessToken == "") accessToken = access;

    GraphQLClient _client = GraphQLConfiguration().clientToQuery();
    QueryResult result = await _client.query(QueryOptions(
      documentNode: gql(QueryBackend.allObjects(accessToken)),
    ));
    if (result.hasException) {
      print(result.exception.toString());
      return Future.value(false);
    }
    if (result.loading) return Future.value(false);
    var d = result.data;
    if (d?.data == null) return Future.value(false);
    if (d is LazyCacheMap) {
      var listStops = <StopsCompanion>[];
      List list = d.data["allObjects"];
      for (var object in list) {
        List<String> images = List<String>();
        for (var e in object["picture"]) images.add(e["id"]);
        var comp = StopsCompanion.insert(
          id: object['objectId'],
          images: images,
          name: object['title'],
          descr: object['description'],
          time: Value(object['year']),
          creator: Value(object['creator']),
          division: Value(object['subCategory']),
          artType: Value(object['artType']),
          material: Value(object['material']),
          size: Value(object['size_']),
          location: Value(object['location']),
          interContext:
              Value(object['interdisciplinaryContext']), //.join("\n"),
        ); //.createCompanion(true);
        listStops.add(comp);
      }
      batch((batch) =>
          batch.insertAll(stops, listStops, mode: InsertMode.insertOrReplace));
    }

    return Future.value(true);
  }

  Future<bool> downloadBadges({access = ""}) async {
    String token = await accessToken();
    if (token == "") token = access;

    GraphQLClient _client = GraphQLConfiguration().clientToQuery();
    QueryResult result = await _client.query(QueryOptions(
      documentNode: gql(QueryBackend.allBadges(token)),
    ));
    if (result.hasException) {
      print(result.exception.toString());
      return Future.value(false);
    }
    if (result.loading) return Future.value(false);
    var d = result.data;
    if (d?.data == null) return Future.value(false);
    if (d is LazyCacheMap) {
      var listBadges = <BadgesCompanion>[];
      List list = d.data["availableBadges"];
      for (var object in list) {
        print(object);
        var comp = BadgesCompanion.insert(
          name: object["name"],
          color: Value(Color(0xFFFF0000)),
          toGet: object["cost"].toDouble(),
          imgPath: object["id"],
        ); //.createCompanion(true);
        listBadges.add(comp);
      }
      batch((batch) => batch.insertAll(badges, listBadges,
          mode: InsertMode.insertOrReplace));
    }

    return Future.value(true);
  }

  Future updateOnboard(bool b) async {
    await initUser();
    return update(users).write(UsersCompanion(onboardEnd: Value(b)));
  }

  Future<bool> onboardEnd() {
    return select(users).map((u) => u.onboardEnd).getSingle();
  }

  Future<String> accessToken() {
    return select(users).map((u) => u.accessToken).getSingle();
  }

  Future init() async {
    await initUser();
    await setDivisions();
    User u = await select(users).getSingle();

    //print(u);
    /* Caused issues: Logged in although skipped, tried download, ...*/
    if (await GraphQLConfiguration.isConnected(u.accessToken)) {
      if (await refreshAccess() != "") {
        await downloadStops();
        await downloadBadges();
      }
    }
  }

  Future initUser() async {
    await customStatement(
        "INSERT INTO users (username, imgPath, onboardEnd, producer) SELECT '', 'assets/images/empty_profile.png', false, false WHERE NOT EXISTS (SELECT * FROM users)");
  }

  Future addFavStop(String id) async {
    var stopIds = await select(users).map((u) => u.favStops).getSingle();
    stopIds.add(id);

    String accessToken = await this.accessToken();
    if (!await GraphQLConfiguration.isConnected(accessToken))
      accessToken = await refreshAccess();

    GraphQLClient _client = GraphQLConfiguration().clientToQuery();
    QueryResult result = await _client.mutate(MutationOptions(
      documentNode: gql(MutationBackend.addFavStop(accessToken, id)),
      onError: (e) => print("ERROR_addFavStop: " + e.toString()),
    ));

    if (result.data["addFavouriteObject"].data["ok"]["boolean"])
      update(users).write(UsersCompanion(favStops: Value(stopIds)));
  }

  Future removeFavStop(String id) async {
    var stopIds = await select(users).map((u) => u.favStops).getSingle();
    stopIds.remove(id);

    String accessToken = await this.accessToken();
    if (!await GraphQLConfiguration.isConnected(accessToken))
      accessToken = await refreshAccess();

    GraphQLClient _client = GraphQLConfiguration().clientToQuery();
    QueryResult result = await _client.mutate(MutationOptions(
      documentNode: gql(MutationBackend.removeFavStop(accessToken, id)),
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

    var query = select(stops)..where((s) => s.id.isIn(stopIds));
    return query.get();
  }

  Future addFavTour(String id) async {
    var tourIds = await select(users).map((u) => u.favTours).getSingle();
    tourIds.add(id);

    String accessToken = await this.accessToken();
    if (!await GraphQLConfiguration.isConnected(accessToken))
      accessToken = await refreshAccess();

    GraphQLClient _client = GraphQLConfiguration().clientToQuery();
    QueryResult result = await _client.mutate(MutationOptions(
      documentNode: gql(MutationBackend.addFavTour(accessToken, id)),
      onError: (e) => print("ERROR_addFavTour: " + e.toString()),
    ));

    if (result.data["addFavouriteTour"].data["ok"]["boolean"])
      update(users).write(UsersCompanion(favTours: Value(tourIds)));
  }

  Future removeFavTour(String id) async {
    var tourIds = await select(users).map((u) => u.favTours).getSingle();
    tourIds.remove(id);

    String accessToken = await this.accessToken();
    if (!await GraphQLConfiguration.isConnected(accessToken))
      accessToken = await refreshAccess();

    GraphQLClient _client = GraphQLConfiguration().clientToQuery();
    QueryResult result = await _client.mutate(MutationOptions(
      documentNode: gql(MutationBackend.removeFavTour(accessToken, id)),
      onError: (e) => print("ERROR_addFavTour: " + e.toString()),
    ));

    if (result.data["removeFavouriteTour"].data["ok"]["boolean"])
      update(users).write(UsersCompanion(favTours: Value(tourIds)));
  }

  Future<bool> isFavTour(String id) async {
    var tourIds = await select(users).map((u) => u.favTours).getSingle();

    return tourIds.where((fav) => fav == id).isNotEmpty;
  }

  Stream<List<TourWithStops>> watchFavTours() {
    var tourIds = select(users).map((u) => u.favTours).watchSingle();

    //tourIds.forEach((list) => list.forEach((s) async => await joinAndDownloadTour(s, searchId: false)));

    var tours = getTourStops();

    return Rx.combineLatest2(
        tourIds,
        tours,
        (List<String> ids, List<TourWithStops> tours) =>
            tours.where((t) => ids.contains(t.onlineId)).toList());
  }

  Future<bool> logIn(String username, String password) async {
    GraphQLClient _client = GraphQLConfiguration().clientToQuery();
    QueryResult result = await _client.mutate(MutationOptions(
      documentNode: gql(MutationBackend.auth(password, username)),
      onError: (e) => print("ERROR_auth: " + e.clientException.toString()),
    ));

    var map = (result?.data ?? {})['auth'] ?? {};
    if (map['ok'] == true) {
      print("LOGIN");
      String access = map['accessToken'];
      String refresh = map['refreshToken'];

      downloadStops(access: access);
      downloadBadges(access: access);

      result = await _client.query(QueryOptions(
        documentNode: gql(QueryBackend.userInfo(access)),
      ));
      // badge, profile picture, producer
      //print("ME "+result.data.data.toString());
      var me = result.data["me"][0];
      var process = json.decode(me["badgeProgress"]);
      print(process);
      if (process is Map) {
        for (var e in process.entries) {
          (update(badges)..where((b) => b.name.equals(e.key)))
              .write(BadgesCompanion(current: Value(e.value.toDouble())));
        }
      }
      String profilePic = (me["profilePicture"] ?? {"id": ""})["id"].toString();
      bool producer = me["producer"] as bool;

      // Favourite Stops
      result = await _client.query(QueryOptions(
        documentNode: gql(QueryBackend.favStops(access)),
      ));
      List<String> favStops = List<String>();
      for (var m in result.data["favouriteObjects"] ?? [])
        favStops.add(m.data["objectId"].toString());
      print("FAVSTOPS" + favStops.toString());

      // Favourite Tours
      result = await _client.query(QueryOptions(
        documentNode: gql(QueryBackend.favTours(access)),
      ));
      List<String> favTours = List<String>();
      for (var m in result.data["favouriteTours"] ?? [])
        favTours.add(m.data["id"].toString());
      print("FAVTOURS" + favTours.toString());

      var u = UsersCompanion(
        accessToken: Value(access),
        refreshToken: Value(refresh),
        username: Value(username),
        favStops: Value(favStops),
        favTours: Value(favTours),
        imgPath: Value(profilePic),
        producer: Value(producer),
      );
      await update(users).write(u);

      //await downloadStops();
      return Future.value(true);
    }
    return Future.value(false);
  }

  Future logOut() {
    delete(tourStops);
    //customStatement("DELETE FROM tourStops");
    customStatement("DELETE FROM tours");
    update(badges).write(BadgesCompanion(current: Value(0)));

    return update(users).write(User(
        producer: false,
        refreshToken: "",
        accessToken: "",
        username: "",
        imgPath: "",
        onboardEnd: null,
        favStops: <String>[],
        favTours: <String>[]));
  }

  Future uploadAnswers(TourWithStops tour) async {
    GraphQLClient _client = GraphQLConfiguration().clientToQuery();
    String token = await accessToken();
    if (!await GraphQLConfiguration.isConnected(token))
      token = await refreshAccess();
    if (token == "") {
      print("EXIT AAA");
      return;
    }

    //print(result.data.data);
    int totalId = 0;
    for (int stopInd = 0; stopInd < tour.stops.length; stopInd++) {
      ActualStop stop = tour.stops[stopInd];
      totalId++;
      for (int extrInd = 0; extrInd < stop.extras.length; extrInd++) {
        totalId++;
        ActualExtra extra = stop.extras[extrInd];
        switch (extra.type) {
          case ExtraType.TASK_TEXT:
            QueryResult result = await _client.query(QueryOptions(
              documentNode:
                  gql(QueryBackend.questionId(token, tour.onlineId, totalId)),
            ));
            String questionId;
            try {
              questionId =
                  result.data["questionId"][0]; // GET_ID(tour_id, totalId)
            } catch (e) {
              continue;
            }
            String answer = extra.task.entries
                .map((e) => e.valA.text + ": " + e.valB.text)
                .join("; ");

            result = await _client.mutate(MutationOptions(
              documentNode:
                  gql(MutationBackend.uploadAnswer(token, answer, questionId)),
              onError: (e) =>
                  print("ERROR_uplAnsw: " + e.clientException.toString()),
            ));
            print("UPL_ANSW: [$answer] " +
                result.data["createAnswer"]["ok"]["boolean"].toString());
            break;
          case ExtraType.TASK_SINGLE:
          case ExtraType.TASK_MULTI:
            QueryResult result = await _client.query(QueryOptions(
              documentNode:
                  gql(QueryBackend.questionId(token, tour.onlineId, totalId)),
            ));
            String questionId;
            try {
              questionId =
                  result.data["questionId"][0]; // GET_ID(tour_id, totalId)
            } catch (e) {
              print("$totalId:   $stopInd, $extrInd");
              print(result.data.data);
              continue;
            }

            List<int> answer = List<int>();
            if (extra.type == ExtraType.TASK_MULTI) {
              for (int i = 0; i < extra.task.entries.length; i++) {
                if (extra.task.entries[i].valB == true) {
                  answer.add(i);
                }
              }
            } else if (extra.task.selected != null)
              answer.add(extra.task.selected);
            print(answer.toString());

            result = await _client.mutate(MutationOptions(
              documentNode: gql(
                  MutationBackend.uploadMCAnswer(token, answer, questionId)),
              onError: (e) =>
                  print("ERROR_uplAnsw_MC: " + e.clientException.toString()),
            ));
            if (result.hasException) continue;
            print(questionId);
            print(result.data.data);

            print("UPL_ANSW_MC: " +
                answer.toString() +
                result.data["createMcAnswer"]["ok"]["boolean"].toString());
            break;
          default:
        }
      }
    }
  }

  void clear() {
    customStatement("DELETE FROM users");
    //customStatement("DELETE FROM tourStops");
    customStatement("DELETE FROM stops");
    customStatement("DELETE FROM tours");
    customStatement("DELETE FROM badges");
    customStatement("DELETE FROM divisions");
  }

  Stream<StopFeature> getStopFeature(int num, String stop_id, int tour_id) {
    final query = select(stopFeatures)
      ..where((f) => f.id.equals(num))
      ..where((f) => f.id_stop.equals(stop_id))
      ..where((f) => f.id_tour.equals(tour_id));

    return query.watchSingle();
  }

  Future<void> updateStopFeatures(String stop_id, int tour_id,
      {images, text, details}) {
    if (stop_id != customName)
      update(stopFeatures).replace(
        StopFeaturesCompanion.insert(
          id_stop: stop_id,
          id_tour: tour_id,
          showImages: images,
          showText: text,
          showDetails: details,
          //id: null,
        ), //.createCompanion(true),
      );
  }

  Future addExtra(
      ActualExtra e, int pos_stop, int pos_extra, int tour_id, String stop_id) {
    if (e.task != null) {
      var list = e.task.correct.toList();

      return into(extras).insert(
          ExtrasCompanion.insert(
              pos_extra: pos_extra,
              pos_stop: pos_stop,
              id_tour: tour_id,
              id_stop: stop_id,
              textInfo: e.textInfo.text,
              type: Value(e.type),
              answerOpt: Value(
                  e.task.entries.map((e) => e.valA.text as String).toList()),
              answerCor: Value(list)),
          mode: InsertMode.insertOrReplace);
    }
    return into(extras).insert(
        ExtrasCompanion.insert(
            pos_extra: pos_extra,
            pos_stop: pos_stop,
            id_tour: tour_id,
            id_stop: stop_id,
            type: Value(e.type),
            textInfo: e.textInfo.text),
        mode: InsertMode.insertOrReplace);
  }

  Stream<ActualStop> getActualStop(int pos_stop, int tour_id, String stop_id) {
    final stop = select(stops)..where((s) => s.id.equals(stop_id));

    final feature = getStopFeature(pos_stop, stop_id, tour_id);

    return CombineLatestStream.combine3(
        stop.watchSingle(),
        feature,
        getExtras(pos_stop, tour_id, stop_id),
        (Stop s, StopFeature f, List<ActualExtra> l) => ActualStop(s, f, l));
  }

  Stream<List<ActualExtra>> getExtras(
      int pos_stop, int tour_id, String stop_id) {
    final query = select(extras)
      ..where((t) => t.pos_stop.equals(pos_stop))
      //..where((t) => t.pos_extra.equals(pos_extra))
      ..where((t) => t.id_tour.equals(tour_id))
      ..where((t) => t.id_stop.equals(stop_id));

    return query.watch().map((rows) => rows
        .map((e) => ActualExtra(e.type,
            text: e.textInfo, sel: e.answerOpt, correct: e.answerCor?.toSet()))
        .toList());
  }

  Stream<Tour> getDBTour(TourWithStops t) {
    var query = select(tours)
      ..where((tour) => tour.name.equals(t.name.text))
      ..where((tour) => tour.author.equals(t.author))
      ..where((tour) => tour.creationTime.equals(t.creationTime));

    return query.watchSingle();
  }

  Future<void> removeTour(int id) async {
    await batch((batch) {
      batch.deleteWhere(tours, (t) => t.id.equals(id));
      batch.deleteWhere(tourStops, (t) => t.id_tour.equals(id));
      batch.deleteWhere(extras, (t) => t.id_tour.equals(id));
      batch.deleteWhere(stopFeatures, (t) => t.id_tour.equals(id));
    });
  }

  Stream<List<Badge>> getBadges() => select(badges).watch();

  Future<int> addBadge(BadgesCompanion bc) {
    return into(badges).insert(bc);
  }

  Stream<List<Division>> getDivisions() => select(divisions).watch();

  Stream<List<Tour>> getTours() => select(tours).watch();

  Stream<List<TourWithStops>> getTourStops() {
    final tour_ids = select(tours, distinct: true).map((t) => t.id).watch();

    var t = tour_ids.map((list) => list.map((id) => getTour(id)).toList());

    return SwitchLatestStream(t.map((list) => CombineLatestStream.list(list)));
  }

  Stream<TourWithStops> getTour(int tour_id) {
    final tour = select(tours)..where((t) => t.id.equals(tour_id));

    final stop_ids = (select(tourStops, distinct: true)
          ..where((ts) => ts.id_tour.equals(tour_id)))
        .map((t) => Tuple(t.id, t.id_stop))
        .watch();

    var l2 = stop_ids.map((list) => list
        .map((stop_id) => getActualStop(stop_id.valA, tour_id, stop_id.valB))
        .toList());

    var res = CombineLatestStream.combine2(tour.watchSingle(), l2,
        (Tour t, List<Stream<ActualStop>> a) {
      Stream<List<ActualStop>> s = CombineLatestStream.list(a);
      return s.map((list) => TourWithStops(t, list.sublist(0)));
    });

    return SwitchLatestStream(res);
  }

  Stream<List<Stop>> watchStops() => select(stops).watch();

  Future<List<Stop>> getStops() => select(stops).get();

  Stream<List<Stop>> stopSearch(String text) {
    if (text.isEmpty) return Stream.value(List<Stop>());

    List<String> input = text.toLowerCase().split(RegExp(",|;|&"));

    var query = select(stops)..where((s) => s.name.equals(customName).not());

    for (var part in input) {
      part = part.trim();
      // search for name
      if (part.startsWith(RegExp("div:?"))) {
        part = part.replaceAll(RegExp("div:?"), "").trim();
        query.where((s) => s.division.lower().like("%" + part + "%"));
      }
      // search for division
      if (part.startsWith(RegExp("nam:?"))) {
        part = part.replaceAll(RegExp("nam:?"), "").trim();
        query.where((s) => s.name.lower().like("%" + part + "%"));
      }
      // search for object's creator
      else if (part.startsWith(RegExp("cre:?"))) {
        part = part.replaceAll(RegExp("cre:?"), "").trim();
        query.where((s) => s.creator.lower().like("%" + part + "%"));
      }
      // search for object's art type
      else if (part.startsWith(RegExp("art:?"))) {
        part = part.replaceAll(RegExp("art:?"), "").trim();
        query.where((s) => s.artType.lower().like("%" + part + "%"));
      }
      // search for object's material
      else if (part.startsWith(RegExp("mat:?"))) {
        part = part.replaceAll(RegExp("mat:?"), "").trim();
        query.where((s) => s.material.lower().like("%" + part + "%"));
      }
      // search for object's inv number
      else if (part.startsWith(RegExp("inv:?"))) {
        part = part.replaceAll(RegExp("inv:?"), "").trim();
        query.where((s) => s.id.lower().like(part + "%"));
      }
      // search in the object's name and division
      else
        query.where((s) =>
            s.name.lower().like("%" + part + "%") |
            s.division.lower().like("%" + part + "%"));
    }

    return query.watch();
  }

  Stream<List<Extra>> getExtrasId(int id_tour, String id_stop) {
    final contentQuery = select(extras)
      //.join([innerJoin(stops, stops.id.equalsExp(tourStops.id_stop))])
      ..where((e) => e.id_tour.equals(id_tour))
      ..where((e) => e.id_stop.equals(id_stop));

    return contentQuery.watch();
  }

  Stream<List<Stop>> getStopsId(int id) {
    final contentQuery = select(tourStops)
        .join([innerJoin(stops, stops.id.equalsExp(tourStops.id_stop))])
          ..where(tourStops.id_tour.equals(id));

    final contentStream = contentQuery
        .watch()
        .map((rows) => rows.map((row) => row.readTable(stops)).toList());

    return contentStream;
  }

  Stream<ActualStop> watchCustomStop() {
    final query = select(stops)..where((stop) => stop.name.equals(customName));
    return query.watchSingle().map((stop) => ActualStop(
        stop,
        StopFeature(
            id: null,
            id_tour: null,
            id_stop: stop.id,
            showImages: false,
            showText: true,
            showDetails: false),
        <ActualExtra>[]));
  }

  Future<Stop> getCustomStop() {
    final query = select(stops)..where((stop) => stop.name.equals(customName));
    return query.getSingle();
  }

  Future<bool> tourToServer(int tourId) async {
    final t =
        await (select(tours)..where((t) => t.id.equals(tourId))).getSingle();

    final contentQuery = select(tourStops)
        .join([innerJoin(stops, stops.id.equalsExp(tourStops.id_stop))])
          ..where(tourStops.id_tour.equals(tourId));
    final tS = await contentQuery.map((row) => row.readTable(stops)).get();

    final f = await (select(stopFeatures)
          ..where((f) => f.id_tour.equals(tourId)))
        .get();
    final e =
        await (select(extras)..where((e) => e.id_tour.equals(tourId))).get();

    List<Object> lst = <Object>[t];
    for (var s in tS) {
      lst.add([s, f.where((fe) => fe.id_stop == s.id).toList()[0]]);
      lst.addAll(e.where((ex) => ex.id_stop == s.id).toList());
    }

    String s = lst.fold("", (prev, e) {
      if (e is Tour) return prev + e.toString();
      if (e is List)
        return prev + "[" + e[0].name + ", " + e[1].toString() + "]";
      if (e is Extra) return prev + e.textInfo;
      return prev;
    });
    print(s);

    return _listToServer(lst);
  }

  Future<bool> _listToServer(List<Object> lst) async {
    String token = await accessToken();
    if (!await GraphQLConfiguration.isConnected(token))
      token = await refreshAccess();
    if (token == "") return Future.value(false);

    GraphQLClient _client = GraphQLConfiguration().clientToQuery();
    var tourId;
    for (var o in lst) {
      String mutation;
      if (o is Tour) {
        var id = o.author.substring(0, min(3, o.author.length)) +
            o.name.substring(0, min(4, o.name.length)) +
            (o.name.length + o.difficulty).toString() +
            o.id.toString();
        mutation = MutationBackend.createTour(
            token, o.name, o.desc, o.difficulty.toInt(), id);
      } else if (tourId == null) {
        continue;
      } else if (o is List &&
          o.length == 2 &&
          o[0] is Stop &&
          o[1] is StopFeature) {
        mutation = MutationBackend.createObjectCheckpoint(token, o[0].id,
            tourId, o[1].showDetails, o[1].showImages, o[1].showText);
      } else if (o is Extra) {
        switch (o.type) {
          case ExtraType.TASK_TEXT:
            mutation = MutationBackend.createTextTask(
                token, o.id_stop, tourId, o.textInfo, o.answerOpt.join(";"));
            break;
          case ExtraType.TASK_SINGLE:
            String labels = "[\"" + o.answerOpt.join("\", \"") + "\"]";
            var cor = o.answerCor;
            if (cor.isEmpty) cor.add(-1);
            mutation = MutationBackend.createMCTask(token, o.id_stop, tourId,
                cor.toString(), 1, labels, o.textInfo);
            break;
          case ExtraType.TASK_MULTI:
            String labels = "[\"" + o.answerOpt.join("\", \"") + "\"]";
            var cor = o.answerCor;
            if (cor.isEmpty) cor.add(-1);
            mutation = MutationBackend.createMCTask(token, o.id_stop, tourId,
                cor.toString(), o.answerOpt.length, labels, o.textInfo);
            break;
          case ExtraType.IMAGE:
            String img = await (select(stops)
                  ..where((s) => s.id.equals(o.id_stop)))
                .map((s) => s.images[0])
                .getSingle();
            mutation = MutationBackend.createImageExtra(token, tourId, img);
            break;
          case ExtraType.TEXT:
            mutation =
                MutationBackend.createTextExtra(token, o.textInfo, tourId);
            break;
        }
      } else
        continue;

      QueryResult result = await _client.mutate(MutationOptions(
        documentNode: gql(mutation),
        onError: (e) {
          print("ERROR: " + e.toString());
          print("MUT: " + mutation);
        },
      ));

      if (result.hasException) {
        print("EXC: " + result.exception.toString());
        return Future.value(false);
      } else if (result.loading)
        print("Loading");
      else if (o is Tour) {
        var d = result.data['createTour'];
        if (d is LazyCacheMap) {
          print("DATA: " + d.data.toString());
          tourId = result.data['createTour'].data["tour"]["id"];
          (update(tours)..where((t) => t.id.equals(o.id)))
              .write(ToursCompanion(onlineId: Value(tourId)));
        }
      }
    }

    await _client.mutate(MutationOptions(
      documentNode: gql(MutationBackend.joinTour(token, tourId)),
      onError: (e) => print("ERROR: " + e.toString()),
    ));

    return Future.value(true);
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
      print("NEW TOKEN");
      downloadStops();
      return Future.value(newToken);
    }
    return Future.value("");
  }

  Future<bool> joinAndDownloadTour(String id, {bool searchId = true}) async {
    String token = await accessToken();

    if (!await GraphQLConfiguration.isConnected(
        token)) if (await refreshAccess() == "") return Future.value(false);

    GraphQLClient _client = GraphQLConfiguration().clientToQuery();

    String tourId = id;
    if (searchId) {
      QueryResult result = await _client.query(QueryOptions(
        documentNode: gql(QueryBackend.tourSearchId(token, id)),
      ));
      if (result.data["tourSearchId"] is List &&
          result.data["tourSearchId"].length > 0)
        tourId = result.data["tourSearchId"][0];
      else {
        return Future.value(false);
      }
      print("TOUR FOUND: $tourId");
    }
    print(tourId);
    var l =
        await (select(tours)..where((t) => t.onlineId.equals(tourId))).get();
    if (l.isNotEmpty) return Future.value(true);

    // Join the tour
    await _client.mutate(MutationOptions(
      documentNode: gql(MutationBackend.joinTour(token, tourId)),
      onError: (e) => print("ERROR: " + e.toString()),
    ));

    // get the tour infos
    QueryResult tourRes = await _client.query(QueryOptions(
      documentNode: gql(QueryBackend.getTour(token, tourId)),
    ));

    //print(result.data['tour'][0].data);
    List<Map> list = <Map>[tourRes.data['tour'][0].data];

    QueryResult checkRes = await _client.query(QueryOptions(
      documentNode: gql(QueryBackend.checkpointTour(token, tourId)),
    ));

    List<Object> checkList = checkRes.data.data['checkpointsTour'];
    checkList
        .sort((m1, m2) => (m1 as Map)["index"].compareTo((m2 as Map)["index"]));
    //print("CHECKS: "+checkList.toString());
    checkList.forEach((o) {
      if (o is Map) list.add(o);
    });

    return _listToLocal(list);
  }

  Future<bool> _listToLocal(List<Map> list) async {
    TourWithStops tour;

    for (var m in list) {
      if (m.containsKey("searchId")) {
        // TOUR
        String author = "";
        var own = m["owner"];
        if (own is Map && own.containsKey("username")) author = own["username"];
        Tour t = Tour(
            id: -1,
            onlineId: m["id"],
            name: m["name"],
            author: author,
            difficulty: m["difficulty"].toDouble(),
            creationTime: DateTime.parse(m["creation"]),
            desc: m["description"]);
        tour = TourWithStops(t, <ActualStop>[]);
      } else if (m.containsKey("index") && tour != null) {
        print(m);
        if (m.containsKey("museumObject")) {
          // STOP
          String id = "";
          var obj = m["museumObject"];
          if (obj is Map && obj.containsKey("objectId")) id = obj["objectId"];
          var feat = StopFeature(
              id_stop: id,
              showImages: m["showPicture"],
              showText: m["showText"],
              showDetails: m["showDetails"]);
          Stop s = await (select(stops)..where((st) => st.id.equals(id)))
              .getSingle();
          tour.stops.add(ActualStop(s, feat, <ActualExtra>[]));
        } else if (tour.stops.isEmpty)
          continue;
        else if (m.containsKey("question") && !m.containsKey("maxChoices")) {
          // TEXT TASK
          List<String> strngs = <String>[];
          if (m["text"] is String) strngs = m["text"].toString().split(",");
          tour.stops.last.extras.add(ActualExtra(ExtraType.TASK_TEXT,
              text: m["question"], sel: strngs));
        } else if (m.containsKey("maxChoices")) {
          // MC TASK
          List<String> strngs = <String>[];
          for (var s in m["possibleAnswers"]) strngs.add(s.toString());

          var type = m["maxChoices"] == 1
              ? ExtraType.TASK_SINGLE
              : ExtraType.TASK_MULTI;

          Set<int> correct = <int>{};
          for (var i in m["correctAnswers"]) correct.add(i as int);

          print("STRNGS: " + strngs.toString());
          print("CORRECT: " + correct.toString());

          tour.stops.last.extras.add(ActualExtra(type,
              text: m["question"], sel: strngs, correct: correct));
        } else if (m.containsKey("picture")) {
          // IMG EXTRA
          tour.stops.last.extras.add(ActualExtra(ExtraType.IMAGE));
        } else if (m.containsKey("text")) {
          // TEXT EXTRA
          print(m["text"]);
          tour.stops.last.extras
              .add(ActualExtra(ExtraType.TEXT, text: m["text"]));
        }
      }
    }

    print("AAA");
    if (tour == null || tour.stops.isEmpty) return Future.value(false);

    print(tour.id.toString() + tour.name.text + tour.author + tour.descr.text);
    for (var s in tour.stops) {
      print(s.stop.name);
      print("EXTRA[" +
          s.extras.fold("", (prev, e) {
            String t = e.task != null ? e.task.correct.toString() : "";
            return prev + e.type.toString() + " " + e.textInfo.text + "$t, ";
          }) +
          "]");
    }

    return writeTourStops(tour);
  }

  Future<bool> writeTourStops(TourWithStops entry,
      {bool upload = false, bool review = false}) {
    return transaction(() async {
      final tour = entry.createToursCompanion(true);

      var id = await into(tours).insert(tour, mode: InsertMode.insertOrReplace);

      await (delete(tourStops)..where((e) => e.id_tour.equals(id))).go();

      await batch((batch) {
        batch.insertAll(
            tourStops,
            entry.stops
                .where((s) => s.stop != null)
                .map((s) => TourStopsCompanion.insert(
                    id: entry.stops.indexOf(s),
                    id_tour: id,
                    id_stop: s.stop.id))
                .toList(),
            mode: InsertMode.insertOrReplace);
        batch.insertAll(
            stopFeatures,
            entry.stops
                .where((s) => s.features != null)
                .map((s) => s.features.copyWith(
                    id: entry.stops.indexOf(s),
                    id_tour: id)) //.createCompanion(true))
                .toList(),
            mode: InsertMode.insertOrReplace);
      });

      for (var stop in entry.stops) {
        for (var extra in stop.extras) {
          addExtra(extra, entry.stops.indexOf(stop), stop.extras.indexOf(extra),
              id, stop.stop.id);
        }
      }

      if (upload) return tourToServer(id);
      return Future.value(true);
    });
  }

  Future<void> setDivisions() async {
    await batch((batch) {
      batch.insertAll(
          divisions,
          [
            DivisionsCompanion.insert(
              name: "Archäologie/Vor- und Frühgeschichte",
              color: Value(Color(0xFFD4642B)),
            ),
            DivisionsCompanion.insert(
              name: "Archäologie/Ägyptische Sammlung",
              color: Value(Color(0xFFAF3A27)),
            ),
            DivisionsCompanion.insert(
              name: "Archäologie/Griechische Antike",
              color: Value(Color(0xFFAF3A27)),
            ),
            DivisionsCompanion.insert(
              name: "Archäologie/Römische Antike",
              color: Value(Color(0xFFAF3A27)),
            ),
            DivisionsCompanion.insert(
              name: "Archäologie/Vor- und Frühgeschichte",
              color: Value(Color(0xFFD4642B)),
            ),
            DivisionsCompanion.insert(
              name: "Erd- und Lebensgeschichte",
              color: Value(Color(0xFF72A6A0)),
            ),
            DivisionsCompanion.insert(
              name: "Gemäldegalerie/Kunst 13. bis 16. Jahrhundert",
              color: Value(Color(0xFF824328)),
            ),
            DivisionsCompanion.insert(
              name: "Gemäldegalerie/Kunst 16. bis 18. Jahrhundert",
              color: Value(Color(0xFF824328)),
            ),
            DivisionsCompanion.insert(
              name: "Gemäldegalerie/Kunst 19. bis Mitte 20. Jahrhundert",
              color: Value(Color(0xFF824328)),
            ),
            DivisionsCompanion.insert(
              name: "Graphische Sammlung",
              color: Value(Color(0xFF632655)),
            ),
            DivisionsCompanion.insert(
              name: "Kunst des Mittelalters/Kirchliche Schatzkammer",
              color: Value(Color(0xFF954A77)),
            ),
            DivisionsCompanion.insert(
              name: "Kunst des Mittelalters/Romanischer Gang",
              color: Value(Color(0xFF954A77)),
            ),
            DivisionsCompanion.insert(
              name: "Kunst des Mittelalters/Waffensaal",
              color: Value(Color(0xFF632655)),
            ),
            DivisionsCompanion.insert(
              name:
                  "Kunsthandwerk (16. bis frühes 20. Jahrhundert)/Fürstliche Schatzkammer",
              color: Value(Color(0xFF632655)),
            ),
            DivisionsCompanion.insert(
              name:
                  "Kunsthandwerk (16. bis frühes 20. Jahrhundert)/Kunst des Jugendstils",
              color: Value(Color(0xFF632655)),
            ),
            DivisionsCompanion.insert(
              name: "Kunsthandwerk/Fürstliche Schatzkammer",
              color: Value(Color(0xFF632655)),
            ),
            DivisionsCompanion.insert(
              name: "Kunsthandwerk/Jugendstilschmuck",
              color: Value(Color(0xFF632655)),
            ),
            DivisionsCompanion.insert(
              name: "Kunsthandwerk/Kostümsammlung Hüpsch",
              color: Value(Color(0xFF632655)),
            ),
            DivisionsCompanion.insert(
              name: "Kunsthandwerk/Kunst des Jugendstils",
              color: Value(Color(0xFF632655)),
            ),
            DivisionsCompanion.insert(
              name: "Zoologie",
              color: Value(Color(0xFF869731)),
            ),
          ],
          mode: InsertMode.insertOrReplace);
    });
  }
}
