import 'package:flutter/material.dart';
import 'package:museum_app/SizeConfig.dart';
import 'package:museum_app/database/moor_db.dart';

class EnterMuseum extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Material(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/haupthalle_hlm_enter.png"),
            fit: BoxFit.fitHeight,
          ),
        ),
        child: Center(
          child: Container(
            margin: EdgeInsets.only(top: verSize(26, 5)),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              //border: Border.all(color: Colors.black),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.53),
                  offset: Offset(0, 2.8),
                  spreadRadius: 1.8,
                  blurRadius: 1,
                )
              ],
            ),
            child: FlatButton(
              shape: CircleBorder(),
              //color: Colors.white,
              child: Padding(
                padding: EdgeInsets.all(3),
                child: Icon(Icons.play_arrow, size: 68),
              ),
              onPressed: () {
                print("ASDF");
                nextScreen(context);
              },
            ),
          ),
        ),
      ),
    );
  }

  void nextScreen(context) async {
    final User user = await MuseumDatabase().getUser();
    final bool onboardEnd = user.onboardEnd;
    if (user.refreshToken != null && user.refreshToken != "")
      MuseumDatabase().refreshAccess();
    Navigator.pushNamed(context, onboardEnd ? "/home" : "/onboard");
  }

}
