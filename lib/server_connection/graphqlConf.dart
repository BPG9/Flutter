import "package:flutter/material.dart";
import "package:graphql_flutter/graphql_flutter.dart";
import 'package:museum_app/constants.dart';
import 'package:museum_app/database/moor_db.dart';
import 'package:museum_app/server_connection/query.dart';

class GraphQLConfiguration {
  static GraphQLConfiguration _gc;

  factory GraphQLConfiguration() {
    _gc ??= GraphQLConfiguration._internal();
    return _gc;
  }

  GraphQLConfiguration._internal();

  static HttpLink httpLink =
      //HttpLink(uri: 'https://countries.trevorblades.com/');
  HttpLink(uri: DB_ADDRESS);

  static AuthLink _authLink = AuthLink(
     getToken: () async {
       String token = await MuseumDatabase().usersDao.accessToken();
       return 'Bearer $token';
       },
   );

  static Link _link = _authLink.concat(httpLink);

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: _link,
      cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject),
    ),
  );

  GraphQLClient clientToQuery() {
    return GraphQLClient(
      cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject),
      link: httpLink,
    );
  }

  static Future<bool> isConnected(String token) async {
    var r = await GraphQLConfiguration().clientToQuery().query(QueryOptions(
        documentNode: gql(QueryBackend.userInfo(token))
    ));
    if (token != "" && (r.hasException || r.data == null))
      return Future.value(false);
    return Future.value(true);
  }
}
