import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:museum_app/SizeConfig.dart';
import 'package:museum_app/constants.dart';
import 'package:museum_app/database/database.dart';

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
            children: list
                .map(
                  (img) => GestureDetector(
                    onTap: () { MuseumDatabase.get().updateImage(img); Navigator.pop(context); },
                    child: Container(
                      height: verSize(13, 27),
                      width: horSize(23, 16),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(img), fit: BoxFit.cover),
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(9),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
      actions: [
        FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            "Schließen",
            style: TextStyle(color: COLOR_PROFILE),
          ),
        ),
      ],
    );
  }
}
