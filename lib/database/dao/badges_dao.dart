import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:moor/moor.dart';
import 'package:museum_app/server_connection/graphqlConf.dart';
import 'package:museum_app/server_connection/graphql_nodes.dart';

import '../moor_db.dart';

part 'badges_dao.g.dart';

@UseDao(tables: [Badges])
class BadgesDao extends DatabaseAccessor<MuseumDatabase> with _$BadgesDaoMixin {
  BadgesDao(MuseumDatabase db) : super(db);

  Stream<List<Badge>> watchBadges() => select(badges).watch();

  Future setBadgeValue(String id, double value) {
    (update(badges)..where((b) => b.id.equals(id))).write(BadgesCompanion(
      current: Value(value),
    ));
  }

  Future addBadgeValue(String id, double value) async {
    Badge b = await (select(badges)..where((b) => b.id.equals(id))).getSingle();

    (update(badges)..where((b) => b.id.equals(id)))
        .write(b.copyWith(current: b.current + value).toCompanion(true));
  }

  Future<bool> downloadBadges({access = ""}) async {
    String token = await db.usersDao.accessToken();
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
        String name = object["name"];
        Color c = Colors.red;
        if (name.toLowerCase().contains("bronze")) {
          c = Color(0xFFCD8032);
          name = name.replaceAll("bronze", "");
        } else if (name.toLowerCase().contains("silber")) {
          c = Color(0xFFC0C0C0);
          name = name.replaceAll("silber", "");
        } else if (name.toLowerCase().contains("gold")) {
          c = Color(0xFFFED700);
          name = name.replaceAll("gold", "");
        }

        var comp = BadgesCompanion.insert(
          name: name.trim(),
          color: Value(c),
          toGet: object["cost"].toDouble(),
          id: object["id"],
        ); //.createCompanion(true);
        listBadges.add(comp);
      }
      batch((batch) => batch.insertAll(badges, listBadges,
          mode: InsertMode.insertOrReplace));
    }

    return Future.value(true);
  }
}
