import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:museum_app/SizeConfig.dart';
import 'package:museum_app/home_page/home_museum.dart';
import 'package:museum_app/museum_tabs.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

var funcSizeHeightPortrait = 29;
var funcSizeWidthPortrait = 42;
var funcSizeHeightLandscape = 30;
var funcSizeWidthLandscape = 10;

var imageSizeHeightPortrait = 20;
var imageSizeWidthPortrait = 38;
var imageSizeHeightLandscape = 10;
var imageSizeWidthLandscape = 30;

enum InfoType { HOME, USAGE, TUTORIALS, ABOUT_MUSEUM, ABOUT_PROJECT }

class _HomeState extends State<Home> {
  InfoType _type = InfoType.HOME;

  void goBack() => setState(() => _type = InfoType.HOME);

  Widget _topInfo1() {
    return Container(
      height: verSize(30, 45),
      child: Center(
        child: Stack(
          children: [
            Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Column(children: <Widget>[
                  Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(bottom: 5.0, top: 15.0),
                      child: SafeArea(
                          bottom: false,
                          child: Text(
                            "Geschichte",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: horSize(13, 2),
                                fontFamily: "Nunito",
                                // fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ))),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      children: <Widget>[
                        Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(bottom: 5.0, top: 2.0),
                            child: SafeArea(
                                bottom: false,
                                child: Text(
                                  "Vernetzt",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: horSize(13, 2),
                                      fontFamily: "Chiller",
                                      // fontWeight: FontWeight.w700,
                                      color: Colors.white),
                                )))
                      ],
                    ),
                  )
                ]))
          ],
        ),
      ),
    );
  }

  Widget _firstRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        oneHomeCell(
            "Einführung zur App-Nutzung",
            "assets/images/Group_2304@3x.png",
            () => setState(() => this._type = InfoType.USAGE)),
        oneHomeCell("Methoden und Tutorials", 'assets/images/methods_tutor.png',
            () => setState(() => _type = InfoType.TUTORIALS)),
      ],
    );
  }

  Widget _secondRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        InkWell(
            child: Container(
                width: horSize(funcSizeWidthPortrait.toDouble(),
                    funcSizeWidthLandscape.toDouble()),
                height: verSize(funcSizeHeightPortrait.toDouble(),
                    funcSizeHeightLandscape.toDouble()),
                margin: EdgeInsets.only(left: 16.0, bottom: 16, right: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(17.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.8),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: Offset.fromDirection(pi / 2),
                    )
                  ],
                ),
                alignment: Alignment.center,
                child: SafeArea(
                    bottom: false,
                    child: Column(
                      children: <Widget>[
                        Container(
                            margin:
                                EdgeInsets.only(right: 5.0, left: 5.0, top: 10),
                            child: Icon(
                              Icons.info,
                              color: Colors.blue,
                              size: 100,
                            )),
                        Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(bottom: 10.0, top: 12.0),
                            child: SafeArea(
                                bottom: false,
                                child: Text(
                                  "Über das Landesmuseum",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: horSize(4.5, 2),
                                      fontFamily: "Nunito",
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF1A1A1A)),
                                )))
                      ],
                    ))),
            onTap: () {
              setState(() => _type = InfoType.ABOUT_MUSEUM);
            }),
        InkWell(
            child: Container(
                width: horSize(funcSizeWidthPortrait.toDouble(),
                    funcSizeWidthLandscape.toDouble()),
                height: verSize(funcSizeHeightPortrait.toDouble(),
                    funcSizeHeightLandscape.toDouble()),
                margin: EdgeInsets.only(right: 16.0, bottom: 16, left: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(17.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.8),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: Offset.fromDirection(pi / 2),
                    )
                  ],
                ),
                alignment: Alignment.center,
                child: SafeArea(
                    bottom: false,
                    child: Column(
                      children: <Widget>[
                        Container(
                            margin:
                                EdgeInsets.only(right: 5.0, left: 5.0, top: 10),
                            child: Image.asset(
                                'assets/images/undraw_new_ideas_jdea@3x.png',
                                width: horSize(
                                    35, imageSizeWidthLandscape.toDouble()),
                                height: verSize(
                                    15, imageSizeHeightLandscape.toDouble()))),
                        Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(
                              //bottom: 10.0,
                              top: 5.0,
                              right: 5.0,
                              left: 5.0,
                            ),
                            child: SafeArea(
                                bottom: false,
                                child: Text(
                                  "Über das Projekt Geschichte vernetzt",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: horSize(4.5, 2),
                                      fontFamily: "Nunito",
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF1A1A1A)),
                                )))
                      ],
                    ))),
            onTap: () {
              setState(() => _type = InfoType.ABOUT_PROJECT);
            }),
      ],
    );
  }

  Widget _homePage() {
    return MuseumTabs.single(
      Container(
        height: verSize(30, 45),
        child: Center(
          child: Container(
              margin: EdgeInsets.only(right: 5.0, left: 5.0),
              child: Image.asset(
                'assets/images/HomePage.png',
                width: horSize(80, 50),
                height: verSize(25, 50),
              )),
        ),
      ),
      Container(
        //height: SizeConfig.safeBlockVertical * 100,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.white, width: 2),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
        ),
        child: Container(
          padding: EdgeInsets.only(top: 10),
          child: Stack(
            children: [
              Wrap(
                direction: Axis.horizontal,
                spacing: 15,
                runSpacing: 15,
                children: [
                  oneHomeCell(
                    "Einführung zur App-Nutzung",
                    "assets/images/Group_2304@3x.png",
                    () => setState(() => this._type = InfoType.USAGE),
                  ),
                  oneHomeCell(
                    "Methoden und Tutorials",
                    'assets/images/methods_tutor.png',
                    () => setState(() => _type = InfoType.TUTORIALS),
                  ),
                  oneHomeCell(
                    "Über das Landesmuseum",
                    "assets/images/Group_2304@3x.png",
                    () => setState(() => _type = InfoType.ABOUT_MUSEUM),
                  ),
                  oneHomeCell(
                    "Über das Projekt Geschichte vernetzt",
                    'assets/images/undraw_new_ideas_jdea@3x.png',
                    () => setState(() => _type = InfoType.ABOUT_PROJECT),
                    textSize: 4.2,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      showMap: this._type == InfoType.HOME,
    );
  }

  Widget _usage() {
    return MuseumTabs.single(
      Stack(children: [
        Container(
          height: verSize(30, 45),
          child: Center(
            child: Container(
                margin: EdgeInsets.only(right: 5.0, left: 5.0),
                child: Image.asset('assets/images/HomePage.png',
                    width: horSize(80, 50), height: verSize(25, 50))),
          ),
        ),
        Positioned(
            left: horSize(2, 2, left: true),
            top: verSize(1, 1),
            child: Container(
              width: horSize(25, 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () => setState(() => _type = InfoType.HOME),
                    icon: Icon(Icons.arrow_back),
                    iconSize: 30,
                    color: Colors.white,
                  ),
                ],
              ),
            )),
      ]),
      Column(
        children: <Widget>[
          Container(height: verSize(3, 2)),
          Text(
            "Einführung zur App-Nutzung",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(height: verSize(1, 2)),
          usageRow(
            "assets/images/Group_2363@3x.png",
            COLOR_HOME,
            "Im ",
            "Home",
            "-Bereich gibt es Informationen zur App-Bedienung, dem Museum und dem Projekt \"Geschichte vernetzt\". Methoden und Tutorials für den Museumsbesuch stehen auch bereit.",
            Icons.home,
          ),
          usageRow(
            "assets/images/Group_2319@3x.png",
            COLOR_TOUR,
            "Unter ",
            "Tour",
            " gehen kannst Du viele verschiedene Touren durch das Museum abrufen und herunterladen.",
            Icons.flag,
          ),
          usageRow(
            "assets/images/Group_2366@3x.png",
            COLOR_ADD,
            "Unter ",
            "Neues Projekt",
            " kannst Du eigene Touren erstellen und auf gespeicherte Museumsobjekte zugreifen.",
            Icons.add,
          ),
          usageRow(
            "assets/images/Group_2317@3x.png",
            COLOR_PROFILE,
            "Unter Deinem ",
            "Profil",
            " kannst Du Favoriten speichern, Statistiken abrufen und Erfolge einsehen.",
            Icons.person_outline,
          ),
          border(
              GestureDetector(
                onTap: () => print("Video Erklär Tour"),
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: horSize(23, 23),
                      child: Icon(Icons.video_library,
                          color: Colors.red, size: size(60, 74)),
                    ),
                    Container(
                      width: horSize(57, 60),
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: horSize(5, 2),
                            fontFamily: "Nunito",
                            fontWeight: FontWeight.w700,
                          ),
                          children: [
                            TextSpan(text: "Noch Fragen?\nSchau Dir ein "),
                            TextSpan(
                              text: "Erklärvideo",
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(text: " zur App-Bedienung an!")
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              margin: EdgeInsets.only(left: 16.0, right: 16),
              padding: EdgeInsets.all(15))
        ],
      ),
    );
  }

  Widget _methods() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            width: horSize(100, 60),
            margin: EdgeInsets.only(top: 6, bottom: 6, left: 16, right: 16),
            child: Text(
              "Methoden",
              style: TextStyle(
                fontSize: horSize(8, 2),
                fontFamily: "Nunito",
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => listeKreative().then((file) => OpenFile.open(file.path)),
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: horSize(23, 23),
                  child: Icon(Icons.picture_as_pdf,
                      color: Colors.red, size: size(45, 60)),
                ),
                Container(
                  //width: horSize(57, 60),
                  child: Text(
                    "Liste kreativer Schreibaufgaben",
                    style: TextStyle(
                      fontSize: horSize(4, 2),
                      fontFamily: "Nunito",
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(height: verSize(2, 1)),
          GestureDetector(
            onTap: () => handreichung().then((file) => OpenFile.open(file.path)),
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(

                  width: horSize(23, 23),
                  child: Icon(Icons.picture_as_pdf,
                      color: Colors.red, size: size(45, 60)),
                ),
                Container(
                  width: horSize(65, 60),
                  child: Text(
                    "Fragenkatalog an kulturgeschichtliche Ausstellungen",
                    style: TextStyle(
                      fontSize: horSize(4, 2),
                      fontFamily: "Nunito",
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(height: verSize(2, 1)),
          GestureDetector(
            onTap: () => abExample().then((file) {
              OpenFile.open(file.path);
            }),
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: horSize(23, 23),
                  child: Icon(Icons.picture_as_pdf,
                      color: Colors.red, size: size(45, 60)),
                ),
                Container(
                  width: horSize(65, 60),
                  child: Text(
                    "Exemplarische Herangehensweise an ein Ausstellungsobjekt",
                    style: TextStyle(
                      fontSize: horSize(4, 2),
                      fontFamily: "Nunito",
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      margin: EdgeInsets.only(left: 16.0, right: 16, top: 6, bottom: 15),
    );
  }

  Widget _tutorials() {
    return MuseumTabs.single(
      Stack(children: [
        Container(
          height: verSize(30, 45),
          child: Center(
            child: Container(
                margin: EdgeInsets.only(right: 5.0, left: 5.0),
                child: Image.asset(
                  'assets/images/HomePage.png',
                  width: horSize(80, 50),
                  height: verSize(25, 50),
                )),
          ),
        ),
        Positioned(
            left: horSize(2, 2, left: true),
            top: verSize(1, 1),
            child: Container(
              width: horSize(25, 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () => setState(() => _type = InfoType.HOME),
                    icon: Icon(Icons.arrow_back),
                    iconSize: 30,
                    color: Colors.white,
                  ),
                ],
              ),
            )),
      ]),
      Column(
        children: <Widget>[
          _methods(),
          Container(
            width: horSize(100, 60),
            margin: EdgeInsets.only(top: 6, bottom: 6, left: 32, right: 32),
            child: Text(
              "Videotutorials",
              style: TextStyle(
                fontSize: horSize(8, 2),
                fontFamily: "Nunito",
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Container(
            child: GestureDetector(
              onTap: () => _launchURL(
                  'https://www.youtube.com/watch?v=JE8jIzSoWH4&list=PLaZEE9an0D5K3h8ayP-PMW2RgPdWJCQhR&index=8'),
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: horSize(23, 23),
                    child: Icon(Icons.video_library,
                        color: Colors.red, size: size(45, 60)),
                  ),
                  Container(
                    width: horSize(57, 60),
                    child: Text(
                      "Die Zeit in der Kunst - Video der Schirn Kunsthalle",
                      style: TextStyle(
                        fontSize: horSize(4, 2),
                        fontFamily: "Nunito",
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  )
                ],
              ),
            ),
            margin: EdgeInsets.only(left: 16.0, right: 16, top: 6, bottom: 6),
          ),
          Container(
            child: GestureDetector(
              onTap: () => _launchURL(
                  'https://www.youtube.com/watch?v=vUdxGbWSKzA&list=PLaZEE9an0D5K3h8ayP-PMW2RgPdWJCQhR&index=3'),
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: horSize(23, 23),
                    child: Icon(Icons.video_library,
                        color: Colors.red, size: size(45, 60)),
                  ),
                  Container(
                    width: horSize(57, 60),
                    child: Text(
                      "Kunst und Wissenschaft - Video der Schirn Kunsthalle",
                      style: TextStyle(
                        fontSize: horSize(4, 2),
                        fontFamily: "Nunito",
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  )
                ],
              ),
            ),
            margin: EdgeInsets.only(left: 16.0, right: 16, top: 6, bottom: 6),
          ),
        ],
      ),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<File> listeKreative() async {
    Directory tempDir = await getTemporaryDirectory();
    File tempFile = File('${tempDir.path}/liste_kreative.pdf');
    ByteData bd = await rootBundle
        .load('assets/pdfs/Liste_kreativer_Schreibaufgaben.pdf');
    await tempFile.writeAsBytes(bd.buffer.asUint8List(), flush: true);
    return tempFile;
  }

  Future<File> abExample() async {
    Directory tempDir = await getTemporaryDirectory();
    File tempFile = File('${tempDir.path}/ab_example.pdf');
    ByteData bd = await rootBundle.load(
        'assets/pdfs/AB_Exemplarische-Herangehensweise-an-ein-Ausstellungsobjekt.pdf');
    await tempFile.writeAsBytes(bd.buffer.asUint8List(), flush: true);
    return tempFile;
  }

  Future<File> handreichung() async {
    Directory tempDir = await getTemporaryDirectory();
    File tempFile = File('${tempDir.path}/handreichung.pdf');
    ByteData bd = await rootBundle
        .load('assets/pdfs/Handreichung_Schule-und-Museum_2011.pdf');
    await tempFile.writeAsBytes(bd.buffer.asUint8List(), flush: true);
    return tempFile;
  }

  Widget _aboutProjectText() {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 16, right: 16, top: 5, bottom: 5),
          child: Row(
            children: <Widget>[
              Container(
                width: horSize(55, 60),
                child: Text(
                  "Über das Projekt",
                  style: TextStyle(
                    fontSize: horSize(7, 2),
                    fontFamily: "Nunito",
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(right: 5.0, left: 5.0),
                  child: Image.asset(
                    'assets/images/Group_2336@3x.png',
                    width: horSize(30, 50),
                    height: verSize(10, 50),
                  )),
            ],
          ),
        ),
        Container(
          width: horSize(80, 60),
          margin: EdgeInsets.only(left: 16, right: 16, top: 5, bottom: 15),
          child: Text(
            "Teil des Projekts „MINTplus²: Systematischer und vernetzter Kompetenzaufbau in der Lehrerbildung im Umgang mit Digitalisierung und Heterogenität",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: horSize(3, 2),
              fontFamily: "Nunito",
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Container(
          width: horSize(100, 60),
          margin: EdgeInsets.only(left: 16, right: 16, top: 5),
          child: Text(
            "Geschichte vernetzt – Vergangenes interdisziplinär erforschen und vermitteln“ ist ein Modul der TU Darmstadt, welches Technik und Naturwissenschaft in ihrer historischen Dimension betrachtet. Es wird in der Zeit von Oktober 2019 bis Juni 2022 eigens für das Lehramtsstudium an der TU Darmstadt entwickelt.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: horSize(5, 2),
              fontFamily: "Nunito",
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(left: 16.0, right: 16.0),
                alignment: Alignment.center,
                child: SafeArea(
                  bottom: false,
                  child: Image.asset(
                    'assets/images/photo_2020-01-19.jpeg',
                    width: horSize(22, 30),
                    height: verSize(10, 10),
                  ),
                )),
            Container(
                margin: EdgeInsets.only(left: 16.0, right: 16.0),
                alignment: Alignment.center,
                child: SafeArea(
                  bottom: false,
                  child: Image.asset(
                    'assets/images/Logo_MINTplus_182x0.jpg',
                    width: horSize(22, 30),
                    height: verSize(10, 20),
                  ),
                )),
            Container(
                margin: EdgeInsets.only(left: 16.0, right: 16.0),
                alignment: Alignment.center,
                child: SafeArea(
                  bottom: false,
                  child: Image.asset(
                    'assets/images/serveimage.png',
                    width: horSize(22, 30),
                    height: verSize(10, 20),
                  ),
                )),
          ],
        ),
        Container(
          width: horSize(100, 60),
          margin: EdgeInsets.only(left: 16, right: 16, top: 5, bottom: 15),
          child: Text(
            "In Kooperation mit dem Hessischen Landesmuseum Darmstadt werden historische Objekte Ausgangspunkt forschenden Lernens, für deren Analyse sowohl natur- als auch geisteswissenschaftliche Kompetenzen benötigt werden. Ziel der Studierenden ist es, interdisziplinäre Rundgangkonzepte zu entwickeln und diese mithilfe der App auch einem breiteren Publikum zur Verfügung zu stellen. Damit soll dazu angeregt werden, fächerübergreifenden Unterricht in Schule und Universität zu etablieren.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: horSize(5, 2),
              fontFamily: "Nunito",
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }

  Widget _aboutProject() {
    return MuseumTabs.single(
      Stack(children: [
        Container(
          height: verSize(30, 45),
          child: Center(
            child: Container(
              margin: EdgeInsets.only(right: 5.0, left: 5.0),
              child: Image.asset(
                'assets/images/HomePage.png',
                width: horSize(80, 50),
                height: verSize(25, 50),
              ),
            ),
          ),
        ),
        Positioned(
            left: horSize(2, 2, left: true),
            top: verSize(1, 1),
            child: Container(
              width: horSize(25, 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () => setState(() => _type = InfoType.HOME),
                    icon: Icon(Icons.arrow_back),
                    iconSize: 30,
                    color: Colors.white,
                  ),
                ],
              ),
            )),
      ]),
      Column(
        children: <Widget>[
          _aboutProjectText(),
          border(
              GestureDetector(
                onTap: () => _launchURL(
                    "mailto:mrahimmasoumi@gmail.com?subject=Museum App"),
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: horSize(80, 60),
                      child: Text(
                        "Allen an der App-Entwicklung beteiligten Studierenden sei ein herzlicher Dank ausgesprochen: Mohammadrahim Masoumi, Robert Cieslinski, Shayan Davari Fard, Patrick Dzubba, Madline Fischer, Christina Heiser, Alexander Schilling, Simeon T. Schmitt.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: horSize(5, 2),
                          fontFamily: "Nunito",
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              margin: EdgeInsets.only(left: 16.0, right: 16, bottom: 7),
              padding: EdgeInsets.all(15)),
          Text("Projektleitung: Miriam Grabarits"),
          Container(height: verSize(1, 1)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var content;
    switch (_type) {
      case InfoType.USAGE:
        content = _usage();
        break;
      case InfoType.TUTORIALS:
        content = _tutorials();
        break;
      case InfoType.ABOUT_MUSEUM:
        return HomeMuseum(goBack: goBack);
      case InfoType.ABOUT_PROJECT:
        content = _aboutProject();
        break;
      default:
        debugPrint("init from home");
        content = _homePage();
    }
    return WillPopScope(
      onWillPop: () {
        if (_type == InfoType.HOME) return Future.value(true);
        if (_type != InfoType.ABOUT_MUSEUM)
          setState(() => _type = InfoType.HOME);
        return Future.value(false);
      },
      child: content,
    );
  }
}

Widget border(Widget w,
    {width,
    borderColor = COLOR_HOME,
    height,
    margin,
    padding = const EdgeInsets.all(8)}) {
  return Container(
    width: width,
    height: height,
    padding: padding,
    margin: margin,
    decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: borderColor, width: 1.5),
        borderRadius: BorderRadius.all(Radius.circular(18.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.8),
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset.fromDirection(pi / 2),
          )
        ]),
    child: w,
  );
}

Widget oneHomeCell(String text, String image, funct, {double textSize = 4.5}) {
  return InkWell(
    child: Container(
        width: horSize(funcSizeWidthPortrait.toDouble(),
            funcSizeWidthLandscape.toDouble()),
        height: verSize(funcSizeHeightPortrait.toDouble(),
            funcSizeHeightLandscape.toDouble()),
        //margin: EdgeInsets.only(left: 16.0, top: 16.0, bottom: 16, right: 5),
        padding: EdgeInsets.only(right: 5.0, left: 5.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(17.0)),
          border: Border.all(color: COLOR_HOME),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.8),
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset.fromDirection(pi / 2),
            )
          ],
        ),
        alignment: Alignment.center,
        child: SafeArea(
            bottom: false,
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Image.asset(
                    image,
                    width: horSize(35, imageSizeWidthLandscape.toDouble()),
                    height: verSize(17, imageSizeHeightLandscape.toDouble()),
                  ),
                ),
                Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(bottom: 10.0, top: 5.0),
                    child: SafeArea(
                        bottom: false,
                        child: Text(
                          text,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: horSize(textSize, 2),
                              fontFamily: "Nunito",
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF1A1A1A)),
                        )))
              ],
            ))),
    onTap: funct,
  );
}

Widget usageRow(String image, color, String text1, String text2, String text3,
    IconData icon) {
  return Container(
      width: horSize(100, 15),
      height: verSize(26, 13),
      margin: EdgeInsets.only(left: 16.0, right: 16),
      alignment: Alignment.center,
      child: SafeArea(
          bottom: false,
          child: Row(
            children: <Widget>[
              Container(
                height: verSize(20, 4),
                width: horSize(25, 4),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(image),
                  ),
                ),
              ),
              Container(
                  alignment: Alignment.center,
                  height: verSize(28, 4),
                  width: horSize(50, 4),
                  margin: EdgeInsets.only(left: 5, right: 5),
                  child: SafeArea(
                    bottom: false,
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: horSize(4, 2),
                          fontFamily: "Nunito",
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1A1A1A),
                        ),
                        children: [
                          TextSpan(text: text1),
                          TextSpan(
                            text: text2,
                            style: TextStyle(
                              color: color,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(text: text3)
                        ],
                      ),
                    ),
                  )),
              Container(
                  alignment: Alignment.center,
                  height: verSize(10, 4),
                  width: horSize(10, 4),
                  margin: EdgeInsets.only(left: 5),
                  child: SafeArea(
                      bottom: false,
                      child: Icon(
                        icon,
                        color: color,
                        size: 30,
                      ))),
            ],
          )));
}
