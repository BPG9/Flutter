import 'package:flutter/material.dart';
import 'package:museum_app/database/database.dart';
import 'package:museum_app/route_generator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage('assets/images/haupthalle_hlm_blue.png'), context);
    precacheImage(
        AssetImage("assets/images/orientierungsplan_high.png"), context);

    return FutureBuilder(
        future: MuseumDatabase.get().onboardEnd(),
        builder: (context, snap) {
          if (!snap.hasData) {
            MuseumDatabase.get().initUser();
            return Center(child: CircularProgressIndicator());
          }

          var onboardEnd = snap.data ?? true;
          String start = onboardEnd ? "/" : "/onboard";

          return MaterialApp(
            debugShowCheckedModeBanner: true,
            locale: Locale('de'),
            title: 'Museum App',
            theme: ThemeData(
              buttonTheme: ButtonThemeData(minWidth: 5),
              primarySwatch: Colors.lightBlue,
            ),
            //home: Onboarding(),
            //home: Home(),
            initialRoute: start,
            onGenerateRoute: RouteGenerator.generateRoute,
          );
        });
  }
}
