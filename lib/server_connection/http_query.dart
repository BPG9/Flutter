import 'package:flutter/cupertino.dart';
import 'package:museum_app/database/moor_db.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';
import 'graphqlConf.dart';

class HttpQuery {
  static void getReport(String tourId) async {
    String token = await MuseumDatabase().usersDao.checkRefresh();

    String url = "$SERVER_ADDRESS/file/report/?type=me&tour=$tourId";

    // url = "$SERVER_ADDRESS/file/questionpdf?type=user&id=$tourId&username=${u.username}";
    print(url);
    if (await canLaunch(url)) {
      await launch(
        url,
        forceWebView: true,
        headers: {"Authorization": "Bearer $token"},
      );
    } else {
      print("ERROR $url");
    }
  }

  static String imageURLProfile(String id) {
    return imageURL("ProfilePicture", id);
  }

  static String imageURLBadge(String id) {
    return imageURL("Badge", id);
  }

  static String imageURLPicture(String id) {
    return imageURL("Picture", id);
  }

  static String imageURL(String type, String id) {
    return "$SERVER_ADDRESS/file/download?type=$type&id=$id";
  }

  static Future<ImageProvider> networkImage(String url) async {
    //String token = await MuseumDatabase().accessToken();
    //if (!await GraphQLConfiguration.isConnected(token))
    //token = await MuseumDatabase().refreshAccess();
    String token = await MuseumDatabase().usersDao.checkRefresh();

    if (token == null || token == "") {
      print("Token Error");
      return Future.value(Image.asset("assets/images/empty_profile.png").image);
    }

    return Image.network(
      url,
      headers: {"Authorization": "Bearer $token"},
    ).image;
  }

  static Widget networkImageWidget(String url,
      {width = 50, height = 50, fit = BoxFit.cover}) {
    return FutureBuilder(
      future: networkImage(url),
      builder: (context, snap) {
        ImageProvider image = snap.data;

        if (image == null)
          return Container(
            width: width.toDouble(),
            height: height.toDouble(),
          );

        return Image(
          image: image,
          width: width.toDouble(),
          height: height.toDouble(),
          fit: fit,
        );
      },
    );
  }

  static Widget networkImageWidget2(String url,
      {width = 50, height = 50, fit = BoxFit.cover}) {
    return FutureBuilder(
      future: MuseumDatabase().usersDao.checkRefresh(),
      builder: (context, snap) {
        String token = snap.data ?? "";
        return FutureBuilder(
          future: GraphQLConfiguration.isConnected(token),
          builder: (context, snap) {
            bool connected = snap.hasData && snap.data;
            if (!connected || url.endsWith("&id=")) {
              print("Connection error");
              return Container(
                width: width.toDouble(),
                height: height.toDouble(),
              );
            }
            return Image.network(
              url,
              /*loadingBuilder: (context, b, c) => Image.asset(
                "assets/images/empty_profile.png",
                width: width.toDouble(),
                height: height.toDouble(),
              ),*/
              //GraphQLConfiguration().imageURLProfile("5e7e091dbef4a100e3735722"),
              headers: {"Authorization": "Bearer $token"},
              fit: fit,
              width: width.toDouble(),
              height: height.toDouble(),
            );
          },
        );
      },
    );
  }
}
