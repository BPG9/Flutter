import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:museum_app/SizeConfig.dart';
import 'package:museum_app/constants.dart';
import 'package:museum_app/database/moor_db.dart';
import 'package:museum_app/graphql/query.dart';
import 'package:museum_app/login_page/login_page.dart';
import 'package:museum_app/museum_tabs.dart';
import 'package:museum_app/profile_page/profile_widgets.dart';
import 'package:museum_app/tours_page/tours_widgets.dart';

class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  /// Returns the widget to be displayed at the top.
  ///
  /// Uses the information provided by [user].
  Widget _topInfo(User user) {
    Widget label = Container();
    //TODO label sometimes a bit to low -> why?
    if (user.producer)
      label = Positioned(
        top: verSize(16.5, 20, top: true),
        left: verSize(20, 19) + 35,
        child: Text(
          "Ersteller-Status",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: size(20, 24),
          ),
        ),
      );

    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // profile picture
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2),
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: ClipOval(
                child: user.imgPath == ""
                    ? Image.asset(
                        "assets/images/empty_profile.png",
                        height: verSize(20, 19),
                        width: verSize(20, 19),
                      )
                    : QueryBackend.networkImageWidget(
                        QueryBackend.imageURLProfile(user.imgPath),
                        height: verSize(20, 19),
                        width: verSize(20, 19),
                      ),
              ),
            ),
            // username
            Expanded(
              child: Text(
                user.username,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: size(25, 30),
                ),
              ),
            ),
          ],
        ),
        label
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return StreamBuilder(
      stream: MuseumDatabase().watchUser(),
      initialData: User(accessToken: "foo", username: "...", imgPath: "", producer: false),
      builder: (context, snap) {
        User user = snap.data;
        // if no user is currently logged in, show the login-screen
        if (!snap.hasData || user.accessToken?.trim() == "")
          return LogIn(skippable: false);
        // create the tab layout
        return MuseumTabs(
          _topInfo(user),
          {
            "Favoriten": FavWidget(),
            "Meine Touren": DownloadColumn(
              QueryBackend.created,
              notFoundText: "\n\nDu hast noch keine Touren erstellt.",
              showSearchId: true,
              deleteTour: true,
            ),
            "Erfolge": BadgeWidget(),
          },
          color: COLOR_PROFILE,
        );
      },
    );
  }
}
