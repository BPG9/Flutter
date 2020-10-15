import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:museum_app/SizeConfig.dart';
import 'package:museum_app/constants.dart';
import 'package:museum_app/database/moor_db.dart';
import 'package:museum_app/server_connection/http_query.dart';

class ImageDialog extends StatefulWidget {
  ImageDialog({Key key}) : super(key: key);

  @override
  _ImageDialogState createState() => _ImageDialogState();
}

class _ImageDialogState extends State<ImageDialog> {

  Widget _clickableIcon(String img) {
    return GestureDetector(
      onTap: () async {
        if (await MuseumDatabase().usersDao.updateImage(img))
          Navigator.pop(context);
        else
          Scaffold.of(context)
              .showSnackBar(SnackBar(content: Text("Ein Fehler trat auf.")));
      },
      child: HttpQuery.networkImageWidget(
        HttpQuery.imageURLProfile(img),
        height: verSize(13, 27),
        width: horSize(23, 16),
        fit: BoxFit.contain,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return AlertDialog(
      contentPadding: EdgeInsets.only(left: 11, right: 11, top: 10),
      title: Text("Profilbild aussuchen"),
      content: Container(
        height: verSize(43, 43),
        child: FutureBuilder(
          future: MuseumDatabase().usersDao.getMyImages(),
          builder: (context, snap) {
            if (snap.hasError || !snap.hasData || snap.data.isEmpty)
              return Text("Es konnten keine Profilbilder abgerufen werden.");
            List<String> list = snap?.data;
            return SingleChildScrollView(
              child: Wrap(
                spacing: 4,
                runSpacing: 6,
                children: list.map((img) => _clickableIcon(img)).toList(),
              ),
            );
          },
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
