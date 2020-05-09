import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:museum_app/SizeConfig.dart';
import 'package:museum_app/constants.dart';
import 'package:museum_app/database/moor_db.dart';
import 'package:museum_app/graphql/mutations.dart';
import 'package:museum_app/graphql/query.dart';

import 'graphql/graphqlConf.dart';

class ImageDialog extends StatefulWidget {
  ImageDialog({Key key}) : super(key: key);

  @override
  _ImageDialogState createState() => _ImageDialogState();
}

class _ImageDialogState extends State<ImageDialog> {
  List<String> list = [
    "assets/images/profile_test.png",
    "assets/images/profile_test2.png",
    'assets/images/haupthalle_hlm_blue.png',
    "assets/images/profile_test.png",
    "assets/images/profile_test2.png",
    'assets/images/haupthalle_hlm_blue.png',
    "assets/images/profile_test.png",
    "assets/images/profile_test2.png",
    'assets/images/haupthalle_hlm_blue.png',
    "assets/images/profile_test.png",
    "assets/images/profile_test2.png",
    'assets/images/haupthalle_hlm_blue.png',
  ];
  List<String> _list = List<String>();

  @override
  void initState() {
    _initList();
    super.initState();
  }

  _initList() async {
    String token = await MuseumDatabase().accessToken();
    GraphQLClient _client = GraphQLConfiguration().clientToQuery();
    QueryResult result = await _client.query(QueryOptions(
      documentNode: gql(QueryBackend.availProfile(token)),
      //onError: (e) => print("ERROR_auth: " + e.toString()),
    ));
    _list.clear();
    for (var s in result.data.data["availableProfilePictures"]) {
      _list.add(s.toString());
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return AlertDialog(
      contentPadding: EdgeInsets.only(left: 11, right: 11, top: 10),
      title: Text("Profilbild aussuchen"),
      content: Container(
        height: verSize(43, 43),
        child: SingleChildScrollView(
          child: Wrap(
            spacing: 4,
            runSpacing: 6,
            children: _list
                .map(
                  (img) => GestureDetector(
                    onTap: () async {
                      String token = await MuseumDatabase().accessToken();
                      GraphQLClient _client = GraphQLConfiguration().clientToQuery();
                      QueryResult result = await _client.mutate(MutationOptions(
                        documentNode: gql(MutationBackend.chooseProfilePicture(img, token)),
                      ));

                      if (result.data.data["chooseProfilePicture"]["ok"]["boolean"] == true){
                        MuseumDatabase().updateImage(img);
                        Navigator.pop(context);
                      }
                    },
                    child: QueryBackend.netWorkImage(
                      QueryBackend.imageURLProfile(img),
                      height: verSize(13, 27),
                      width: horSize(23, 16),
                    ),
                    /*child: Container(
                      height: verSize(13, 27),
                      width: horSize(23, 16),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(img), fit: BoxFit.cover),
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(9),
                      ),
                    ),*/
                  ),
                )
                .toList(),
          ),
        ),
      ),
      actions: [
        FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Schließen", style: TextStyle(color: COLOR_PROFILE)),
        ),
      ],
    );
  }
}
