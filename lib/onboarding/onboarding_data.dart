import 'package:flutter/material.dart';
import 'package:museum_app/constants.dart';

var pageList = [
  PageModel(
      imageUrl: "assets/images/onboard_1.png",
      title: "Herzlich Willkommen!",
      body: "Geschichte vernetzt im Hessischen Landesmuseum Darmstadt",
      extra: "Teil des Projekts MINTplus²: "
          "Systematischer und vernetzter Kompetenzaufbau in der "
          "Lehrerbildung im Umgang mit Digitalisierung und Heterogenität",
      number: 1,
      color: COLOR_HOME,
  ),
  PageModel(
      imageUrl: "assets/images/onboard_2.png",
      title: "App ins Museum!",
      body: "Mobil unterwegs im Landesmuseum:",
      extra: "Landesmuseum kennenlernen;Rundgänge anlegen und gehen;Museumsobjekte untersuchen",
      number: 2,
      color: COLOR_TOUR,
  ),
  PageModel(
      imageUrl: "assets/images/onboard_3.png",
      title: "Erstelle Dein Profil!",
      body: "Dein eigenes Profil im Landesmuseum:",
      extra: "Account verwalten;Favoriten sammeln;Statistiken abrufen",
      number: 3,
      color: COLOR_PROFILE,
  ),
];

List<List<Color>> gradients = [
  [Color(0xFF9708CC), Color(0xFF43CBFF)],
  [Color(0xFFE2859F), Color(0xFFFCCF31)],
  [Color(0xFF736EFE), Color(0xFF5EFCE8)],
];

class PageModel {
  var imageUrl;
  var title;
  var body;
  var number;
  String extra;
  Color color;
  PageModel({this.imageUrl, this.title, this.body, this.number, this.color, this.extra});
}