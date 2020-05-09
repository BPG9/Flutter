import 'dart:io';
import 'dart:math';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:museum_app/SizeConfig.dart';
import 'package:museum_app/museum_tabs.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';

class HomeMuseum extends StatefulWidget {
  final void Function() goBack;

  HomeMuseum({this.goBack, Key key}) : super(key: key);

  @override
  _HomeMuseumState createState() => _HomeMuseumState();
}

enum PageType { HOME_MUSEUM, HISTORY, OPENING_PRICE, EVENTS, DIRECTION }

var funcSizeHeightPortrait = 29;
var funcSizeWidthPortrait = 42;
var funcSizeHeightLandscape = 30;
var funcSizeWidthLandscape = 10;

var imageSizeHeightPortrait = 20;
var imageSizeWidthPortrait = 38;
var imageSizeHeightLandscape = 10;
var imageSizeWidthLandscape = 30;

class _HomeMuseumState extends State<HomeMuseum> {
  PageType _type = PageType.HOME_MUSEUM;

  Widget _homePageMuseum() {
    return Container(
      //height: SizeConfig.safeBlockVertical * 100,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.white, width: 2),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
      ),
      child: Container(
          child: Stack(children: [
        Column(children: [
          _firstRow(),
          _secondRow(),
        ] //next row should be here
            ),
      ])),
    );
  }

  Widget _aboutMuseum() {
    return MuseumTabs.single(
        Stack(children: [
          Container(
            height: verSize(30, 45),
            child: Center(
              child: Container(
                  margin: EdgeInsets.only(right: 5.0, left: 5.0),
                  child: Image.asset('assets/images/HomePage.png',
                      width:
                          SizeConfig.orientationDevice == Orientation.portrait
                              ? SizeConfig.safeBlockHorizontal * 80
                              : SizeConfig.safeBlockHorizontal * 50,
                      height:
                          SizeConfig.orientationDevice == Orientation.portrait
                              ? SizeConfig.safeBlockVertical * 25
                              : SizeConfig.safeBlockVertical * 50)),
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
                      onPressed: () => setState(() {
                        widget.goBack();
                      }),
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
            _homePageMuseum(),
          ],
        ),
        );
  }

  Widget _firstRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        InkWell(
            child: Container(
                width: SizeConfig.orientationDevice == Orientation.portrait
                    ? SizeConfig.safeBlockHorizontal * funcSizeWidthPortrait
                    : SizeConfig.safeBlockHorizontal * funcSizeWidthLandscape,
                height: SizeConfig.orientationDevice == Orientation.portrait
                    ? SizeConfig.safeBlockVertical * funcSizeHeightPortrait
                    : SizeConfig.safeBlockVertical * funcSizeHeightLandscape,
                margin: EdgeInsets.only(
                    left: 16.0, top: 16.0, bottom: 16, right: 5),
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
                                'assets/images/Mask_Group_2@3x.png',
                                width: SizeConfig.orientationDevice ==
                                        Orientation.portrait
                                    ? SizeConfig.safeBlockHorizontal * 35
                                    : SizeConfig.safeBlockHorizontal *
                                        imageSizeWidthLandscape,
                                height: SizeConfig.orientationDevice ==
                                        Orientation.portrait
                                    ? SizeConfig.safeBlockVertical * 17
                                    : SizeConfig.safeBlockVertical *
                                        imageSizeHeightLandscape)),
                        Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(
                              //bottom: 10.0,
                              top: 13.0,
                              left: 5,
                              right: 5,
                            ),
                            child: SafeArea(
                                bottom: false,
                                child: Text(
                                  "Geschichte des Museums",
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
              setState(() => _type = PageType.HISTORY);
            }),
        InkWell(
            child: Container(
                width: SizeConfig.orientationDevice == Orientation.portrait
                    ? SizeConfig.safeBlockHorizontal * funcSizeWidthPortrait
                    : SizeConfig.safeBlockHorizontal * funcSizeWidthLandscape,
                height: SizeConfig.orientationDevice == Orientation.portrait
                    ? SizeConfig.safeBlockVertical * funcSizeHeightPortrait
                    : SizeConfig.safeBlockVertical * funcSizeHeightLandscape,
                margin: EdgeInsets.only(
                    right: 16.0, top: 16.0, bottom: 16, left: 5),
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
                                'assets/images/undraw_time_management_30iu@3x.png',
                                width: SizeConfig.orientationDevice ==
                                        Orientation.portrait
                                    ? SizeConfig.safeBlockHorizontal * 35
                                    : SizeConfig.safeBlockHorizontal *
                                        imageSizeWidthLandscape,
                                height: SizeConfig.orientationDevice ==
                                        Orientation.portrait
                                    ? SizeConfig.safeBlockVertical * 17
                                    : SizeConfig.safeBlockVertical *
                                        imageSizeHeightLandscape)),
                        Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(
                              //bottom: 10.0,
                              top: 13.0,
                              left: 5,
                              right: 5,
                            ),
                            child: SafeArea(
                                bottom: false,
                                child: Text(
                                  "Öffnungszeiten und Preise",
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
              setState(() => _type = PageType.OPENING_PRICE);
            }),
      ],
    );
  }

  Widget _secondRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        InkWell(
            child: Container(
                width: SizeConfig.orientationDevice == Orientation.portrait
                    ? SizeConfig.safeBlockHorizontal * funcSizeWidthPortrait
                    : SizeConfig.safeBlockHorizontal * funcSizeWidthLandscape,
                height: SizeConfig.orientationDevice == Orientation.portrait
                    ? SizeConfig.safeBlockVertical * funcSizeHeightPortrait
                    : SizeConfig.safeBlockVertical * funcSizeHeightLandscape,
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
                            child: Image.asset(
                                'assets/images/undraw_schedule_pnbk@3x.png',
                                width: SizeConfig.orientationDevice ==
                                        Orientation.portrait
                                    ? SizeConfig.safeBlockHorizontal * 35
                                    : SizeConfig.safeBlockHorizontal *
                                        imageSizeWidthLandscape,
                                height: SizeConfig.orientationDevice ==
                                        Orientation.portrait
                                    ? SizeConfig.safeBlockVertical * 15
                                    : SizeConfig.safeBlockVertical *
                                        imageSizeHeightLandscape)),
                        Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(
                              bottom: 10.0,
                              top: 15.0,
                              left: 5,
                              right: 5,
                            ),
                            child: SafeArea(
                                bottom: false,
                                child: Text(
                                  "Veranstaltungen und Führungen",
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
              setState(() => _type = PageType.EVENTS);
            }),
        InkWell(
            child: Container(
                width: SizeConfig.orientationDevice == Orientation.portrait
                    ? SizeConfig.safeBlockHorizontal * funcSizeWidthPortrait
                    : SizeConfig.safeBlockHorizontal * funcSizeWidthLandscape,
                height: SizeConfig.orientationDevice == Orientation.portrait
                    ? SizeConfig.safeBlockVertical * funcSizeHeightPortrait
                    : SizeConfig.safeBlockVertical * funcSizeHeightLandscape,
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
                                'assets/images/Group_2346@3x.png',
                                width: SizeConfig.orientationDevice ==
                                        Orientation.portrait
                                    ? SizeConfig.safeBlockHorizontal * 35
                                    : SizeConfig.safeBlockHorizontal *
                                        imageSizeWidthLandscape,
                                height: SizeConfig.orientationDevice ==
                                        Orientation.portrait
                                    ? SizeConfig.safeBlockVertical * 15
                                    : SizeConfig.safeBlockVertical *
                                        imageSizeHeightLandscape)),
                        Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(
                                bottom: 10.0, top: 15.0, left: 5, right: 5),
                            child: SafeArea(
                                bottom: false,
                                child: Text(
                                  "Anfahrt, ÖPNV und Lageplan",
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
              setState(() => _type = PageType.DIRECTION);
            }),
      ],
    );
  }

  Widget _directions() {
    return MuseumTabs.single(
        Stack(children: [
          Container(
            height: verSize(30, 45),
            child: Center(
              child: Container(
                  margin: EdgeInsets.only(right: 5.0, left: 5.0),
                  child: Image.asset('assets/images/HomePage.png',
                      width:
                          SizeConfig.orientationDevice == Orientation.portrait
                              ? SizeConfig.safeBlockHorizontal * 80
                              : SizeConfig.safeBlockHorizontal * 50,
                      height:
                          SizeConfig.orientationDevice == Orientation.portrait
                              ? SizeConfig.safeBlockVertical * 25
                              : SizeConfig.safeBlockVertical * 50)),
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
                      onPressed: () =>
                          setState(() => _type = PageType.HOME_MUSEUM),
                      icon: Icon(Icons.arrow_back),
                      iconSize: 30,
                      color: Colors.white,
                    ),
                  ],
                ),
              )),
        ]),
        Container(
          child: Column(
            children: <Widget>[
              Container(
                width: horSize(100, 60),
                margin:
                    EdgeInsets.only(top: 6, bottom: 15, left: 16, right: 16),
                child: Text(
                  "Anfahrt, ÖPNV und Lageplan",
                  style: TextStyle(
                    fontSize:
                        SizeConfig.orientationDevice == Orientation.portrait
                            ? SizeConfig.safeBlockHorizontal * 6
                            : SizeConfig.safeBlockHorizontal * 2,
                    fontFamily: "Nunito",
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => _launchURL(
                    "https://www.google.com/maps/place/Friedenspl.+1,+64283+Darmstadt/@49.874924,8.6511593,17z/data=!3m1!4b1!4m5!3m4!1s0x47bd7063ed9d890f:0x645fb337233bdf41!8m2!3d49.874924!4d8.653348"),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: horSize(23, 23),
                      child: Icon(Icons.place,
                          color: COLOR_HOME, size: size(40, 35)),
                    ),
                    Container(
                      width: horSize(57, 60),
                      margin: EdgeInsets.only(top: 15, bottom: 4, right: 4),
                      child: Text.rich(
                        TextSpan(
                            text: "Hessisches Landesmuseum Darmstadt\n",
                            style: TextStyle(
                              fontSize: SizeConfig.orientationDevice ==
                                      Orientation.portrait
                                  ? SizeConfig.safeBlockHorizontal * 4
                                  : SizeConfig.safeBlockHorizontal * 2,
                              fontFamily: "Nunito",
                              fontWeight: FontWeight.w700,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Friedensplatz 1 \n64283 Darmstadt',
                                style: TextStyle(
                                  fontSize: SizeConfig.orientationDevice ==
                                          Orientation.portrait
                                      ? SizeConfig.safeBlockHorizontal * 4
                                      : SizeConfig.safeBlockHorizontal * 2,
                                  color: COLOR_HOME,
                                  fontFamily: "Nunito",
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ]),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => print("Bus stations?"),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: horSize(23, 23),
                      child: Icon(Icons.directions_bus,
                          color: COLOR_HOME, size: size(40, 35)),
                    ),
                    Container(
                      width: horSize(57, 60),
                      margin: EdgeInsets.only(top: 15, bottom: 4, right: 4),
                      child: Text.rich(
                        TextSpan(
                          text:
                              "Haltestellen: Schloss, Luisenplatz oder Willy-Brandt-Platz erreichbar mit Straßenbahn- und Buslinien des ÖPNV",
                          style: TextStyle(
                            fontSize: SizeConfig.orientationDevice ==
                                    Orientation.portrait
                                ? SizeConfig.safeBlockHorizontal * 4
                                : SizeConfig.safeBlockHorizontal * 2,
                            fontFamily: "Nunito",
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => print("parking?"),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: horSize(23, 23),
                      child: Icon(Icons.local_parking,
                          color: COLOR_HOME, size: size(40, 35)),
                    ),
                    Container(
                      width: horSize(57, 60),
                      margin: EdgeInsets.only(top: 15, bottom: 4, right: 4),
                      child: Text.rich(
                        TextSpan(
                          text:
                              "Parken: In den Q-Park-Schlossgaragen. Busse können zum Ein- und Aussteigen vor dem Haupteingang des Museums halten.",
                          style: TextStyle(
                            fontSize: SizeConfig.orientationDevice ==
                                    Orientation.portrait
                                ? SizeConfig.safeBlockHorizontal * 4
                                : SizeConfig.safeBlockHorizontal * 2,
                            fontFamily: "Nunito",
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => print("barrierfrei?"),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: horSize(23, 23),
                      child: Icon(Icons.accessible,
                          color: COLOR_HOME, size: size(40, 35)),
                    ),
                    Container(
                      width: horSize(57, 60),
                      margin: EdgeInsets.only(top: 15, bottom: 4, right: 4),
                      child: Text.rich(
                        TextSpan(
                          text:
                              "Der Eingang für Rollstuhl-Fahrer*innen befindet sich auf der Westseite (zwischen Messel- und Kargelbau). Im Haus gibt es Fahrstühle und entsprechende Sanitär-einrichtungen. Der Eintritt für Rollstuhlfahrer*innen ist frei.",
                          style: TextStyle(
                            fontSize: SizeConfig.orientationDevice ==
                                    Orientation.portrait
                                ? SizeConfig.safeBlockHorizontal * 4
                                : SizeConfig.safeBlockHorizontal * 2,
                            fontFamily: "Nunito",
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          margin: EdgeInsets.only(left: 16.0, right: 16, top: 6, bottom: 15),
        ),
        );
  }

  Future<File> listeKreative() async {
    Directory tempDir = await getTemporaryDirectory();
    File tempFile = File('${tempDir.path}/liste_kreative.pdf');
    ByteData bd = await rootBundle
        .load('assets/pdfs/Liste_kreativer_Schreibaufgaben.pdf');
    await tempFile.writeAsBytes(bd.buffer.asUint8List(), flush: true);
    return tempFile;
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget _openingNprice() {
    return MuseumTabs.single(
        Stack(children: [
          Container(
            height: verSize(30, 45),
            child: Center(
              child: Container(
                  margin: EdgeInsets.only(right: 5.0, left: 5.0),
                  child: Image.asset('assets/images/HomePage.png',
                      width:
                          SizeConfig.orientationDevice == Orientation.portrait
                              ? SizeConfig.safeBlockHorizontal * 80
                              : SizeConfig.safeBlockHorizontal * 50,
                      height:
                          SizeConfig.orientationDevice == Orientation.portrait
                              ? SizeConfig.safeBlockVertical * 25
                              : SizeConfig.safeBlockVertical * 50)),
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
                      onPressed: () =>
                          setState(() => _type = PageType.HOME_MUSEUM),
                      icon: Icon(Icons.arrow_back),
                      iconSize: 30,
                      color: Colors.white,
                    ),
                  ],
                ),
              )),
        ]),
        Container(
          child: Column(
            children: <Widget>[
              Container(
                width: horSize(100, 60),
                margin:
                    EdgeInsets.only(top: 6, bottom: 15, left: 16, right: 16),
                child: Text(
                  "Öffnungszeiten und Preise",
                  style: TextStyle(
                    fontSize:
                        SizeConfig.orientationDevice == Orientation.portrait
                            ? SizeConfig.safeBlockHorizontal * 6
                            : SizeConfig.safeBlockHorizontal * 2,
                    fontFamily: "Nunito",
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => print("Opening hours"),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: horSize(15, 23),
                      child: Icon(Icons.access_time,
                          color: COLOR_HOME, size: size(40, 35)),
                    ),
                    Container(
                      width: horSize(57, 60),
                      margin: EdgeInsets.only(bottom: 4, right: 4),
                      child: Text.rich(
                        TextSpan(
                          text: "Öffnungszeiten:",
                          style: TextStyle(
                            fontSize: SizeConfig.orientationDevice ==
                                    Orientation.portrait
                                ? SizeConfig.safeBlockHorizontal * 5
                                : SizeConfig.safeBlockHorizontal * 2,
                            fontFamily: "Nunito",
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15, bottom: 10),
                child: Table(
                  border: TableBorder.all(
                    color: Colors.black,
                    width: 1,
                  ),
                  children: [
                    TableRow(children: [
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Center(
                          child: Container(
                            margin: EdgeInsets.only(
                                top: 7, bottom: 7, left: 4, right: 4),
                            child: Text(
                              'Montag',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Center(
                          child: Container(
                            margin: EdgeInsets.only(
                                top: 7, bottom: 7, left: 4, right: 4),
                            child: Text(
                              'geschlossen',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ]),
                    TableRow(children: [
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Center(
                          child: Container(
                            margin: EdgeInsets.only(
                                top: 7, bottom: 7, left: 4, right: 4),
                            child: Text(
                              'Dienstag, Donnerstag und Freitag',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Center(
                            child: Container(
                              margin: EdgeInsets.only(
                                  top: 7, bottom: 7, left: 4, right: 4),
                              child: Text(
                                '10:00 bis 18:00 Uhr',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )),
                    ]),
                    TableRow(children: [
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Center(
                          child: Container(
                            margin: EdgeInsets.only(
                                top: 7, bottom: 7, left: 4, right: 4),
                            child: Text(
                              'Mittwoch',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Center(
                          child: Container(
                            margin: EdgeInsets.only(
                                top: 7, bottom: 7, left: 4, right: 4),
                            child: Text(
                              '10:00 bis 20:00 Uhr',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ]),
                    TableRow(children: [
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Center(
                          child: Container(
                            margin: EdgeInsets.only(
                                top: 7, bottom: 7, left: 4, right: 4),
                            child: Text(
                              'Samstag, Sonn- und Feiertage',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Center(
                            child: Container(
                              margin: EdgeInsets.only(
                                  top: 7, bottom: 7, left: 4, right: 4),
                              child: Text(
                                '11:00 bis 17:00 Uhr',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )),
                    ]),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 15),
                child:
                    Text("Karfreitag, Heiligabend und Silvester geschlossen"),
              ),
              GestureDetector(
                onTap: () => print("Price"),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: horSize(15, 23),
                      child: Icon(Icons.euro_symbol,
                          color: COLOR_HOME, size: size(40, 35)),
                    ),
                    Container(
                      width: horSize(57, 60),
                      margin: EdgeInsets.only(bottom: 4, right: 4),
                      child: Text.rich(
                        TextSpan(
                          text: "Preise:",
                          style: TextStyle(
                            fontSize: SizeConfig.orientationDevice ==
                                    Orientation.portrait
                                ? SizeConfig.safeBlockHorizontal * 5
                                : SizeConfig.safeBlockHorizontal * 2,
                            fontFamily: "Nunito",
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => print("Price 1"),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: horSize(30, 23),
                      margin: EdgeInsets.only(bottom: 10, right: 4),
                      child: Icon(Icons.person,
                          color: COLOR_HOME, size: size(30, 35)),
                    ),
                    Container(
                      width: horSize(57, 60),
                      margin: EdgeInsets.only(bottom: 10, right: 4),
                      child: Text.rich(
                        TextSpan(
                          text: "Erwachsene  : 6 Euro \n… ermäßigt  : 4 Euro",
                          style: TextStyle(
                            fontSize: SizeConfig.orientationDevice ==
                                    Orientation.portrait
                                ? SizeConfig.safeBlockHorizontal * 4
                                : SizeConfig.safeBlockHorizontal * 2,
                            fontFamily: "Nunito",
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => print("Price 2"),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: horSize(30, 23),
                      margin: EdgeInsets.only(bottom: 10, right: 4),
                      child: Icon(Icons.face,
                          color: COLOR_HOME, size: size(30, 35)),
                    ),
                    Container(
                      width: horSize(57, 60),
                      margin: EdgeInsets.only(bottom: 10, right: 4),
                      child: Text.rich(
                        TextSpan(
                          text:
                              "Kinder und Jugendliche bis 18 Jahre haben freien Eintritt",
                          style: TextStyle(
                            fontSize: SizeConfig.orientationDevice ==
                                    Orientation.portrait
                                ? SizeConfig.safeBlockHorizontal * 4
                                : SizeConfig.safeBlockHorizontal * 2,
                            fontFamily: "Nunito",
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => print("Price 2"),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: horSize(30, 23),
                      margin: EdgeInsets.only(bottom: 10, right: 4),
                      child: Icon(Icons.credit_card,
                          color: COLOR_HOME, size: size(30, 35)),
                    ),
                    Container(
                      width: horSize(57, 60),
                      margin: EdgeInsets.only(bottom: 10, right: 4),
                      child: Text.rich(
                        TextSpan(
                          text:
                              "akzeptiert werden  : artCard, GEOcard, Familienkarte Hessen",
                          style: TextStyle(
                            fontSize: SizeConfig.orientationDevice ==
                                    Orientation.portrait
                                ? SizeConfig.safeBlockHorizontal * 4
                                : SizeConfig.safeBlockHorizontal * 2,
                            fontFamily: "Nunito",
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          margin: EdgeInsets.only(left: 16.0, right: 16, top: 6, bottom: 15),
        ),
        );
  }

  Widget _events() {
    return MuseumTabs.single(
        Stack(children: [
          Container(
            height: verSize(30, 45),
            child: Center(
              child: Container(
                  margin: EdgeInsets.only(right: 5.0, left: 5.0),
                  child: Image.asset('assets/images/HomePage.png',
                      width:
                          SizeConfig.orientationDevice == Orientation.portrait
                              ? SizeConfig.safeBlockHorizontal * 80
                              : SizeConfig.safeBlockHorizontal * 50,
                      height:
                          SizeConfig.orientationDevice == Orientation.portrait
                              ? SizeConfig.safeBlockVertical * 25
                              : SizeConfig.safeBlockVertical * 50)),
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
                      onPressed: () =>
                          setState(() => _type = PageType.HOME_MUSEUM),
                      icon: Icon(Icons.arrow_back),
                      iconSize: 30,
                      color: Colors.white,
                    ),
                  ],
                ),
              )),
        ]),
        Container(
          child: Column(
            children: <Widget>[
              Container(
                width: horSize(85, 60),
                margin:
                    EdgeInsets.only(top: 6, bottom: 15, left: 16, right: 16),
                child: Text(
                  "Veranstaltungen und Führungen",
                  style: TextStyle(
                    fontSize:
                        SizeConfig.orientationDevice == Orientation.portrait
                            ? SizeConfig.safeBlockHorizontal * 6
                            : SizeConfig.safeBlockHorizontal * 2,
                    fontFamily: "Nunito",
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () =>
                    _launchURL("https://www.hlmd.de/kalender/kalender.html"),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 15, bottom: 4, right: 4),
                      width: horSize(23, 23),
                      child: Icon(Icons.today,
                          color: COLOR_HOME, size: size(40, 35)),
                    ),
                    Container(
                      width: horSize(57, 60),
                      margin: EdgeInsets.only(top: 15, bottom: 4, right: 4),
                      child: Text.rich(
                        TextSpan(
                            text:
                                "Veranstaltungskalender des Hessischen Landesmuseums\n",
                            style: TextStyle(
                              fontSize: SizeConfig.orientationDevice ==
                                      Orientation.portrait
                                  ? SizeConfig.safeBlockHorizontal * 5
                                  : SizeConfig.safeBlockHorizontal * 2,
                              fontFamily: "Nunito",
                              fontWeight: FontWeight.w700,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text:
                                    'https://www.hlmd.de/kalender/kalender.html',
                                style: TextStyle(
                                  fontSize: SizeConfig.orientationDevice ==
                                          Orientation.portrait
                                      ? SizeConfig.safeBlockHorizontal * 4
                                      : SizeConfig.safeBlockHorizontal * 2,
                                  color: COLOR_HOME,
                                  fontFamily: "Nunito",
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ]),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 4, right: 4),
                    width: horSize(23, 23),
                  ),
                  Container(
                      margin: EdgeInsets.only(bottom: 4, right: 4),
                      width: horSize(57, 23),
                      child: Text(
                          "Hier sind auch öffentliche Führungen durch Wissenschaftler*innen des Hauses zu finden!"))
                ],
              ),
              GestureDetector(
                onTap: () => print("Deals?"),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: horSize(23, 23),
                      child: Icon(Icons.outlined_flag,
                          color: COLOR_HOME, size: size(40, 35)),
                    ),
                    Container(
                      width: horSize(57, 60),
                      margin: EdgeInsets.only(top: 15, bottom: 4, right: 4),
                      child: Text.rich(
                        TextSpan(
                          text: "Führungsangebote",
                          style: TextStyle(
                            fontSize: SizeConfig.orientationDevice ==
                                    Orientation.portrait
                                ? SizeConfig.safeBlockHorizontal * 5
                                : SizeConfig.safeBlockHorizontal * 2,
                            fontFamily: "Nunito",
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15, bottom: 10),
                child: Table(
                  columnWidths: {
                    0: FractionColumnWidth(.7),
                    1: FractionColumnWidth(.3)
                  },
                  border: TableBorder.all(
                    color: Colors.black,
                    width: 1,
                  ),
                  children: [
                    TableRow(children: [
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Center(
                          child: Container(
                            margin: EdgeInsets.only(
                                top: 7, bottom: 7, left: 4, right: 4),
                            child: Text(
                              'Highlight-Führung durch das HLMD - Ausgewählte Objekte aller Sammlungsbereiche',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Center(
                          child: Container(
                            margin: EdgeInsets.only(
                                top: 7, bottom: 7, left: 4, right: 4),
                            child: Text(
                              '90 Min',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ]),
                    TableRow(children: [
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Center(
                          child: Container(
                            margin: EdgeInsets.only(
                                top: 7, bottom: 7, left: 4, right: 4),
                            child: Text.rich(
                              TextSpan(
                                  text:
                                      "Themenführung Kunst, Kultur- und Naturgeschichte\n",
                                  style: TextStyle(
                                    fontSize: SizeConfig.orientationDevice ==
                                            Orientation.portrait
                                        ? SizeConfig.safeBlockHorizontal * 4
                                        : SizeConfig.safeBlockHorizontal * 2,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text:
                                          'Mögliche Themen: Vor- und Frühgeschichte, Gemäldegalerie, Jugendstil, Kunst nach 1945, Zoologie, Erd- und Lebensgeschichte, Die Museumsarchitektur Alfred Messels, Grube Messel',
                                      style: TextStyle(
                                        fontSize: SizeConfig
                                                    .orientationDevice ==
                                                Orientation.portrait
                                            ? SizeConfig.safeBlockHorizontal * 3
                                            : SizeConfig.safeBlockHorizontal *
                                                2,
                                      ),
                                    ),
                                  ]),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Center(
                            child: Container(
                              margin: EdgeInsets.only(
                                  top: 7, bottom: 7, left: 4, right: 4),
                              child: Text(
                                '60 Min',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )),
                    ]),
                    TableRow(children: [
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Center(
                          child: Container(
                            margin: EdgeInsets.only(
                                top: 7, bottom: 7, left: 4, right: 4),
                            child: Text.rich(
                              TextSpan(
                                  text:
                                      "Themenführung für Kinder zur Kunst-, Kultur- oder Naturgeschichte\n",
                                  style: TextStyle(
                                    fontSize: SizeConfig.orientationDevice ==
                                            Orientation.portrait
                                        ? SizeConfig.safeBlockHorizontal * 4
                                        : SizeConfig.safeBlockHorizontal * 2,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text:
                                          'Speziell auf die Zielgruppe zugeschnitten und methodisch aufbereitet',
                                      style: TextStyle(
                                        fontSize: SizeConfig
                                                    .orientationDevice ==
                                                Orientation.portrait
                                            ? SizeConfig.safeBlockHorizontal * 3
                                            : SizeConfig.safeBlockHorizontal *
                                                2,
                                      ),
                                    ),
                                  ]),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Center(
                            child: Container(
                              margin: EdgeInsets.only(
                                  top: 7, bottom: 7, left: 4, right: 4),
                              child: Text(
                                ' max. 60 Min',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )),
                    ]),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => print("more info"),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: horSize(23, 23),
                      margin: EdgeInsets.only(top: 15, bottom: 4, right: 4),
                      child: Icon(Icons.euro_symbol,
                          color: COLOR_HOME, size: size(40, 35)),
                    ),
                    Container(
                      width: horSize(57, 60),
                      margin: EdgeInsets.only(top: 15, bottom: 4, right: 4),
                      child: Text.rich(
                        TextSpan(
                          text: "Preise und weitere Informationen",
                          style: TextStyle(
                            fontSize: SizeConfig.orientationDevice ==
                                    Orientation.portrait
                                ? SizeConfig.safeBlockHorizontal * 5
                                : SizeConfig.safeBlockHorizontal * 2,
                            fontFamily: "Nunito",
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => print("Price"),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: horSize(23, 23),
                      height: horSize(9, 23),
                      margin: EdgeInsets.only(top: 15),
                      child:
                          Image.asset("assets/images/60Euro+Eintritt@3x.png"),
                    ),
                    Container(
                      width: horSize(57, 60),
                      margin: EdgeInsets.only(bottom: 6, right: 4, top: 10),
                      child: Text.rich(
                        TextSpan(
                          text:
                              "pro Führung und Gruppe, zzgl. Eintritt für Erwachsene/Ermäßgte",
                          style: TextStyle(
                            fontSize: SizeConfig.orientationDevice ==
                                    Orientation.portrait
                                ? SizeConfig.safeBlockHorizontal * 4
                                : SizeConfig.safeBlockHorizontal * 2,
                            fontFamily: "Nunito",
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => print("Price"),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: horSize(23, 23),
                      height: horSize(9, 23),
                      margin: EdgeInsets.only(top: 15),
                      child:
                          Image.asset("assets/images/70Euro+Eintritt@3x.png"),
                    ),
                    Container(
                      width: horSize(57, 60),
                      margin: EdgeInsets.only(bottom: 6, right: 4, top: 15),
                      child: Text.rich(
                        TextSpan(
                          text: "für eine fremdsprachige Führung Erwachsener",
                          style: TextStyle(
                            fontSize: SizeConfig.orientationDevice ==
                                    Orientation.portrait
                                ? SizeConfig.safeBlockHorizontal * 4
                                : SizeConfig.safeBlockHorizontal * 2,
                            fontFamily: "Nunito",
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => print("more info"),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: horSize(23, 23),
                      margin: EdgeInsets.only(top: 15, bottom: 4, right: 4),
                      child: Icon(Icons.info_outline,
                          color: COLOR_HOME, size: size(40, 35)),
                    ),
                    Container(
                      width: horSize(57, 60),
                      margin: EdgeInsets.only(top: 15, bottom: 4, right: 4),
                      child: Text.rich(
                        TextSpan(
                          text: "Weitere Informationen",
                          style: TextStyle(
                            fontSize: SizeConfig.orientationDevice ==
                                    Orientation.portrait
                                ? SizeConfig.safeBlockHorizontal * 5
                                : SizeConfig.safeBlockHorizontal * 2,
                            fontFamily: "Nunito",
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: horSize(70, 60),
                margin: EdgeInsets.only(left: 16, right: 16, top: 15),
                child: Text(
                  "Ermäßigter Gruppeneintritt ab einer Gruppengröße von 10 Personen",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize:
                        SizeConfig.orientationDevice == Orientation.portrait
                            ? SizeConfig.safeBlockHorizontal * 4
                            : SizeConfig.safeBlockHorizontal * 2,
                    fontFamily: "Nunito",
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                width: horSize(70, 60),
                margin: EdgeInsets.only(left: 16, right: 16, top: 15),
                child: Text(
                  "Maximale Gruppengröße: 25 Personen",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize:
                        SizeConfig.orientationDevice == Orientation.portrait
                            ? SizeConfig.safeBlockHorizontal * 4
                            : SizeConfig.safeBlockHorizontal * 2,
                    fontFamily: "Nunito",
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                width: horSize(70, 60),
                margin: EdgeInsets.only(left: 16, right: 16, top: 15),
                child: Text(
                  "Anmeldung mindestens drei Wochen im Voraus",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize:
                        SizeConfig.orientationDevice == Orientation.portrait
                            ? SizeConfig.safeBlockHorizontal * 4
                            : SizeConfig.safeBlockHorizontal * 2,
                    fontFamily: "Nunito",
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                width: horSize(70, 60),
                margin: EdgeInsets.only(left: 16, right: 16, top: 15),
                child: Text(
                  "Freie Gruppenbesuche ab 10 Personen ohne gebuchte Führungen sind möglich, Fremdführungen sind jedoch nicht gestattet",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize:
                        SizeConfig.orientationDevice == Orientation.portrait
                            ? SizeConfig.safeBlockHorizontal * 4
                            : SizeConfig.safeBlockHorizontal * 2,
                    fontFamily: "Nunito",
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              border(
                  GestureDetector(
                    onTap: () => print("phone, mail"),
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: horSize(70, 60),
                          child: Text.rich(
                            TextSpan(
                                text:
                                    "Anmeldung und Beratung\n06151 1657-111 \n\nDienstag 10.00 - 12.00 Uhr \nMittwoch 14.00 - 16.00 Uhr\nFreitag 10.00 - 12.00 Uhr\n",
                                style: TextStyle(
                                  fontSize: SizeConfig.orientationDevice ==
                                          Orientation.portrait
                                      ? SizeConfig.safeBlockHorizontal * 4
                                      : SizeConfig.safeBlockHorizontal * 2,
                                  fontFamily: "Nunito",
                                  fontWeight: FontWeight.w700,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'vermittlung@hlmd.de',
                                    style: TextStyle(
                                      fontSize: SizeConfig.orientationDevice ==
                                              Orientation.portrait
                                          ? SizeConfig.safeBlockHorizontal * 4
                                          : SizeConfig.safeBlockHorizontal * 2,
                                      color: COLOR_HOME,
                                      fontFamily: "Nunito",
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ]),
                          ),
                        )
                      ],
                    ),
                  ),
                  margin: EdgeInsets.only(left: 16.0, right: 16, top: 15),
                  padding: EdgeInsets.all(15))
            ],
          ),
          margin: EdgeInsets.only(left: 16.0, right: 16, top: 6, bottom: 15),
        ),
        );
  }

  Widget _museumHistoryPage() {
    return MuseumTabs.single(
        Stack(children: [
          Container(
            height: verSize(30, 45),
            child: Center(
              child: Container(
                  margin: EdgeInsets.only(right: 5.0, left: 5.0),
                  child: Image.asset('assets/images/HomePage.png',
                      width:
                          SizeConfig.orientationDevice == Orientation.portrait
                              ? SizeConfig.safeBlockHorizontal * 80
                              : SizeConfig.safeBlockHorizontal * 50,
                      height:
                          SizeConfig.orientationDevice == Orientation.portrait
                              ? SizeConfig.safeBlockVertical * 25
                              : SizeConfig.safeBlockVertical * 50)),
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
                      onPressed: () =>
                          setState(() => _type = PageType.HOME_MUSEUM),
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
            Container(
              width: horSize(100, 60),
              margin: EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
              child: Text(
                "Galerie",
                style: TextStyle(
                  fontSize: SizeConfig.orientationDevice == Orientation.portrait
                      ? SizeConfig.safeBlockHorizontal * 6
                      : SizeConfig.safeBlockHorizontal * 2,
                  fontFamily: "Nunito",
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            _carousel(),
            Container(
              width: horSize(100, 60),
              margin: EdgeInsets.only(top: 6, left: 16, right: 16),
              child: Text(
                "Sammlungsgeschichte",
                style: TextStyle(
                  fontSize: SizeConfig.orientationDevice == Orientation.portrait
                      ? SizeConfig.safeBlockHorizontal * 6
                      : SizeConfig.safeBlockHorizontal * 2,
                  fontFamily: "Nunito",
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => _firstText())),
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: horSize(80, 60),
                    margin:
                        EdgeInsets.only(right: 16, left: 16, top: 5, bottom: 5),
                    child: Text.rich(
                      TextSpan(
                          text:
                              "Ende des 18. Jahrhunderts vererbte Landgräfin Karoline ihrem Sohn Ludwig X. (1753–1830, ab 1806 Großherzog Ludewig I.) ihre Sammlung von Naturalien und physikalischen Instrumenten, die den Grundstock für die ...",
                          style: TextStyle(
                            fontSize: SizeConfig.orientationDevice ==
                                    Orientation.portrait
                                ? SizeConfig.safeBlockHorizontal * 4
                                : SizeConfig.safeBlockHorizontal * 2,
                            fontFamily: "Nunito",
                            fontWeight: FontWeight.w700,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'weiterlesen',
                              style: TextStyle(
                                fontSize: SizeConfig.orientationDevice ==
                                        Orientation.portrait
                                    ? SizeConfig.safeBlockHorizontal * 4
                                    : SizeConfig.safeBlockHorizontal * 2,
                                color: COLOR_HOME,
                                fontFamily: "Nunito",
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ]),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: horSize(100, 60),
              margin: EdgeInsets.only(top: 15, left: 16, right: 16),
              child: Text(
                "Der Museumsbau Alfred Messels",
                style: TextStyle(
                  fontSize: SizeConfig.orientationDevice == Orientation.portrait
                      ? SizeConfig.safeBlockHorizontal * 6
                      : SizeConfig.safeBlockHorizontal * 2,
                  fontFamily: "Nunito",
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => _secondText())),
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: horSize(80, 60),
                    margin:
                        EdgeInsets.only(right: 16, left: 16, top: 5, bottom: 5),
                    child: Text.rich(
                      TextSpan(
                          text:
                              "1817 wurde die Sammlung vom alten Residenzschloss in das neue Schloss verlegt. Ihr weiteres Wachstum machte jedoch einen Neubau notwendig, der 1897 auf Veranlassung von Großherzog Ernst Ludwig in Angriff genommen wurde. Architekt war  ...",
                          style: TextStyle(
                            fontSize: SizeConfig.orientationDevice ==
                                    Orientation.portrait
                                ? SizeConfig.safeBlockHorizontal * 4
                                : SizeConfig.safeBlockHorizontal * 2,
                            fontFamily: "Nunito",
                            fontWeight: FontWeight.w700,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'weiterlesen',
                              style: TextStyle(
                                fontSize: SizeConfig.orientationDevice ==
                                        Orientation.portrait
                                    ? SizeConfig.safeBlockHorizontal * 4
                                    : SizeConfig.safeBlockHorizontal * 2,
                                color: COLOR_HOME,
                                fontFamily: "Nunito",
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ]),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: horSize(100, 60),
              margin: EdgeInsets.only(top: 15, left: 16, right: 16),
              child: Text(
                "Erweiterung und Sanierung des Messelbaus nach dem 2. Weltkrieg",
                style: TextStyle(
                  fontSize: SizeConfig.orientationDevice == Orientation.portrait
                      ? SizeConfig.safeBlockHorizontal * 6
                      : SizeConfig.safeBlockHorizontal * 2,
                  fontFamily: "Nunito",
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => _thirdText())),
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: horSize(80, 60),
                    margin:
                        EdgeInsets.only(right: 16, left: 16, top: 5, bottom: 5),
                    child: Text.rich(
                      TextSpan(
                          text:
                              "In den Jahren nach dem Zweiten Weltkrieg wurde der Messelbau wiederhergestellt, 1955 konnte das HLMD seine Türen schließlich wieder öffnen. Seitdem erfuhren die Sammlungen wesentliche Erweiterungen. Eine umfangreiche ...",
                          style: TextStyle(
                            fontSize: SizeConfig.orientationDevice ==
                                    Orientation.portrait
                                ? SizeConfig.safeBlockHorizontal * 4
                                : SizeConfig.safeBlockHorizontal * 2,
                            fontFamily: "Nunito",
                            fontWeight: FontWeight.w700,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'weiterlesen',
                              style: TextStyle(
                                fontSize: SizeConfig.orientationDevice ==
                                        Orientation.portrait
                                    ? SizeConfig.safeBlockHorizontal * 4
                                    : SizeConfig.safeBlockHorizontal * 2,
                                color: COLOR_HOME,
                                fontFamily: "Nunito",
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ]),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: horSize(100, 60),
              margin: EdgeInsets.only(top: 15, left: 16, right: 16),
              child: Text(
                "Grundinstandsetzung und Sanierung 2007 bis 2014",
                style: TextStyle(
                  fontSize: SizeConfig.orientationDevice == Orientation.portrait
                      ? SizeConfig.safeBlockHorizontal * 6
                      : SizeConfig.safeBlockHorizontal * 2,
                  fontFamily: "Nunito",
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => _forthText())),
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: horSize(80, 60),
                    margin: EdgeInsets.only(
                        right: 16, left: 16, top: 5, bottom: 15),
                    child: Text.rich(
                      TextSpan(
                          text:
                              "Ende 2007 wurde das HLMD für die Öffentlichkeit geschlossen und umfassend saniert. Die Umbau- und Sanierungsmaßnahmen umfassten die vollständige Erneuerung der  ...",
                          style: TextStyle(
                            fontSize: SizeConfig.orientationDevice ==
                                    Orientation.portrait
                                ? SizeConfig.safeBlockHorizontal * 4
                                : SizeConfig.safeBlockHorizontal * 2,
                            fontFamily: "Nunito",
                            fontWeight: FontWeight.w700,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'weiterlesen',
                              style: TextStyle(
                                fontSize: SizeConfig.orientationDevice ==
                                        Orientation.portrait
                                    ? SizeConfig.safeBlockHorizontal * 4
                                    : SizeConfig.safeBlockHorizontal * 2,
                                color: COLOR_HOME,
                                fontFamily: "Nunito",
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ]),
                    ),
                  ),
                ],
              ),
            ),
            border(
                GestureDetector(
                  onTap: () => _launchURL("https://www.hlmd.de/"),
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: horSize(80, 60),
                        child: Text.rich(
                          TextSpan(
                              text:
                                  "Mehr Informationen zu den einzelnen Sammlungsbereichen auf der ",
                              style: TextStyle(
                                fontSize: SizeConfig.orientationDevice ==
                                        Orientation.portrait
                                    ? SizeConfig.safeBlockHorizontal * 4
                                    : SizeConfig.safeBlockHorizontal * 2,
                                fontFamily: "Nunito",
                                fontWeight: FontWeight.w700,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text:
                                      'Webseite des Hessischen Landesmuseums Darmstadt',
                                  style: TextStyle(
                                    fontSize: SizeConfig.orientationDevice ==
                                            Orientation.portrait
                                        ? SizeConfig.safeBlockHorizontal * 4
                                        : SizeConfig.safeBlockHorizontal * 2,
                                    color: COLOR_HOME,
                                    fontFamily: "Nunito",
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ]),
                        ),
                      ),
                    ],
                  ),
                ),
                margin: EdgeInsets.only(left: 16.0, right: 16, top: 15),
                padding: EdgeInsets.all(15))
          ],
        ),
        );
  }

  Widget _firstText() {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: COLOR_HOME,
          title: Text("Geschichte", style: TextStyle(color: Colors.white)),
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: ListView(children: [
          Container(
            width: horSize(100, 60),
            margin: EdgeInsets.only(top: 15, left: 16, right: 16),
            child: Text(
              "Sammlungsgeschichte",
              style: TextStyle(
                fontSize: SizeConfig.orientationDevice == Orientation.portrait
                    ? SizeConfig.safeBlockHorizontal * 6
                    : SizeConfig.safeBlockHorizontal * 2,
                fontFamily: "Nunito",
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Container(
            width: horSize(100, 60),
            margin: EdgeInsets.only(top: 6, bottom: 5, left: 16, right: 16),
            child: Text(
              "1817 wurde die Sammlung vom alten Residenzschloss in das neue Schloss verlegt. Ihr weiteres Wachstum machte jedoch einen Neubau notwendig, der 1897 auf Veranlassung von Großherzog Ernst Ludwig in Angriff genommen wurde. Architekt war der durch den Bau des Warenhauses Wertheim in Berlin bekannt gewordene gebürtige Darmstädter Alfred Messel. Für den Darmstädter Bau stellte sich ihm die Aufgabe, vier Abteilungen – Zoologie, Geologie, Galerie und Kulturgeschichte – mit unterschiedlichsten Sammlungen unter einem Dach zu vereinen. Nach außen hin sollte das Gebäude zudem mit der Stilsprache und den Proportionen des Schlosses harmonieren und als städtebaulichen Akzent einen Turm erhalten. Messel löste seine Aufgabe, indem er in einem hochaufragenden Nordflügel die drei Sammlungen Zoologie, Geologie und Galerie übereinander anordnete, quasi als eigene Museen von der zentralen Halle und einem repräsentativen Treppenhaus erschlossen, und einen niedrigeren Südbereich um offene Höfe gruppiert für die Kulturgeschichte davor anordnete. In genauer Kenntnis des in den Jahrzehnten davor entstandenen Bautyps Museum und in enger Absprache mit den jeweiligen Leitern der Abteilungen gab Messel jeder Sammlung eine spezifische architektonische Fassung mit optimalen Ausstellungsmöglichkeiten und stilistisch zu den Objekten passend. Dabei wurden selbst die Gitter der Lüftungsanlage, die Türklinken und die Vitrinen von ihm selbst entworfen, so dass das Museum sich als ein Gesamtkunstwerk darbot. Entsprechend wurde es nach seiner Vollendung und Eröffnung 1906 in der Öffentlichkeit, den Medien und der Fachwelt gefeiert. Während des Nationalsozialismus erlitten besonders die Graphische Sammlung und der Bestand an deutschen Gemälden des Expressionismus empfindliche Einbußen, die auch nach 1945 nur zum Teil kompensiert werden konnten. 1944 wurde das Gebäude teilweise zerstört. Die wichtigsten Objekte der Sammlungen waren jedoch ausgelagert und sind damit gerettet worden.",
              style: TextStyle(
                fontSize: SizeConfig.orientationDevice == Orientation.portrait
                    ? SizeConfig.safeBlockHorizontal * 5
                    : SizeConfig.safeBlockHorizontal * 2,
                fontFamily: "Nunito",
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ]));
  }

  Widget _secondText() {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: COLOR_HOME,
          title: Text("Geschichte", style: TextStyle(color: Colors.white)),
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: ListView(children: [
          Container(
            width: horSize(100, 60),
            margin: EdgeInsets.only(top: 15, left: 16, right: 16),
            child: Text(
              "Der Museumsbau Alfred Messels",
              style: TextStyle(
                fontSize: SizeConfig.orientationDevice == Orientation.portrait
                    ? SizeConfig.safeBlockHorizontal * 6
                    : SizeConfig.safeBlockHorizontal * 2,
                fontFamily: "Nunito",
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Container(
            width: horSize(100, 60),
            margin: EdgeInsets.only(top: 6, bottom: 5, left: 16, right: 16),
            child: Text(
              "Ende des 18. Jahrhunderts vererbte Landgräfin Karoline ihrem Sohn Ludwig X. (1753–1830, ab 1806 Großherzog Ludewig I.) ihre Sammlung von Naturalien und physikalischen Instrumenten, die den Grundstock für die naturwissenschaftlichen Sammlungen des heutigen HLMD bildete. Während seiner Regierungszeit (1790–1830) fügte Ludewig I. wichtige Bestände hinzu: Glasgemälde, altdeutsche Altäre, niederländische Gemälde des 17. Jahrhunderts, Kupferstiche und naturgeschichtliche Objekte wie den Nachlass Johann Heinrich Mercks, der viele Säugetierfossilien beinhaltet. 1802 erwarb Ludewig I. das gesamte druckgraphische Werk Albrecht Dürers und Rembrandts. 1805 vererbte ihm der Kölner Sammler Baron von Hüpsch seine hochbedeutende Kunst- und Naturaliensammlung, darunter Elfenbeinarbeiten und Gemälde des Mittelalters sowie wertvolle Mineralien und Fossilien. 52 Gemälde des 17. und 18. Jahrhunderts wurden im Jahr 1808 von dem Baseler Kaufmann Nikolaus Reber angekauft, etwas später kam die 81 Gemälde umfassende Sammlung des Grafen Truchseß von Waldburg hinzu sowie 1450 Handzeichnungen aller bedeutenden europäischen Schulen aus der Sammlung E. F. J. von Dalberg. Im Jahr 1820 übergab Ludewig I. seine Kunst- und Naturaliensammlung in Form einer Stiftung in das Eigentum des Staates. Damit machte er die Sammlung, die seit dem 17. Jahrhundert von den Landgrafen Hessen-Darmstadts kontinuierlich aufgebaut worden war, der Öffentlichkeit zugänglich.",
              style: TextStyle(
                fontSize: SizeConfig.orientationDevice == Orientation.portrait
                    ? SizeConfig.safeBlockHorizontal * 5
                    : SizeConfig.safeBlockHorizontal * 2,
                fontFamily: "Nunito",
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ]));
  }

  Widget _thirdText() {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: COLOR_HOME,
          title: Text("Geschichte", style: TextStyle(color: Colors.white)),
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: ListView(children: [
          Container(
            width: horSize(100, 60),
            margin: EdgeInsets.only(top: 15, left: 16, right: 16),
            child: Text(
              "Erweiterung und Sanierung des Messelbaus nach dem 2. Weltkrieg",
              style: TextStyle(
                fontSize: SizeConfig.orientationDevice == Orientation.portrait
                    ? SizeConfig.safeBlockHorizontal * 6
                    : SizeConfig.safeBlockHorizontal * 2,
                fontFamily: "Nunito",
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Container(
            width: horSize(100, 60),
            margin: EdgeInsets.only(top: 6, bottom: 5, left: 16, right: 16),
            child: Text(
              "In den Jahren nach dem Zweiten Weltkrieg wurde der Messelbau wiederhergestellt, 1955 konnte das HLMD seine Türen schließlich wieder öffnen. Seitdem erfuhren die Sammlungen wesentliche Erweiterungen. Eine umfangreiche Korallen- und Molluskensammlung gelangte in die zoologische Abteilung, die umfangreiche Jugendstil-Kollektion des Amsterdamer Juweliers Karel A. Citroen konnte erworben werden und 1966 begannen die planmäßigen Grabungen in der Grube Messel, deren Fossilien einen Schwerpunkt der geologisch-paläontologischen Abteilung bilden. Ebenso gab der Darmstädter Industrielle Karl Ströher seine umfangreiche Sammlung von Werken der Pop Art und den größten Werkkomplex von Joseph Beuys als Leihgabe an das HLMD. 1980 wurde der Erweiterungsbau nach Entwürfen des Architekten Reinhold Kargel begonnen und 1984 für die Kunst des 20. Jahrhunderts eingeweiht. Heute befindet sich hier die Gemäldegalerie vom Mittelalter bis 1945. Die Kunst nach 1945 sowie der sieben Räume umfassende »Block Beuys«, der 1989 vom Land Hessen angekauft wurde, befinden sich im Messelbau. Gegenüber dem »Block Beuys« wird der »Wald der Skulpturen« gezeigt – 40 Skulpturen, die der Genfer Sammler Simon Spierer dem HLMD 2004 schenkte. In den 1990er Jahren wurde die Erd- und Lebensgeschichte mit der Präsentation der Funde aus der Grube Messel grundlegend erneuert. Der Bereich der Hominidenforschung und der Erwerb von Messelfossilien aus der Sammlung Behnke bilden neue Schwerpunkte.",
              style: TextStyle(
                fontSize: SizeConfig.orientationDevice == Orientation.portrait
                    ? SizeConfig.safeBlockHorizontal * 5
                    : SizeConfig.safeBlockHorizontal * 2,
                fontFamily: "Nunito",
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ]));
  }

  Widget _forthText() {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: COLOR_HOME,
          title: Text("Geschichte", style: TextStyle(color: Colors.white)),
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: ListView(children: [
          Container(
            width: horSize(100, 60),
            margin: EdgeInsets.only(top: 15, left: 16, right: 16),
            child: Text(
              "Grundinstandsetzung und Sanierung 2007 bis 2014",
              style: TextStyle(
                fontSize: SizeConfig.orientationDevice == Orientation.portrait
                    ? SizeConfig.safeBlockHorizontal * 6
                    : SizeConfig.safeBlockHorizontal * 2,
                fontFamily: "Nunito",
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Container(
            width: horSize(100, 60),
            margin: EdgeInsets.only(top: 6, bottom: 5, left: 16, right: 16),
            child: Text(
              "Ende 2007 wurde das HLMD für die Öffentlichkeit geschlossen und umfassend saniert. Die Umbau- und Sanierungsmaßnahmen umfassten die vollständige Erneuerung der Haustechnik und Dächer sowie die Ertüchtigung von Fundamenten, Kanälen und Decken bis hin zum Einbau moderner Brandschutz- und Sicherheitstechnik. Dem Baudenkmal entsprechend wurde so viel der originalen Architektur von Alfred Messel wie möglich wieder sichtbar gemacht, einschließlich der Sichtachsen und Durchgänge. Inhaltlich wurde versucht, die von Alfred Messel vorgegebene Struktur des Hauses durch die Anordnung der Sammlungen weitgehend aufzugreifen und weiterzuführen.  So entstanden die archäologischen und kunsthandwerklichen Raumspangen rechts und links der Haupthalle von neuem, verblieben die zoologischen und geologischen Sammlungen sowie die Graphische Sammlung an ihrem historischen Platz. Die moderne Kunst befindet sich mit dem »Block Beuys«, der Sammlung Spierer und dem gegenüberliegenden, von Karl Ströher gestifteten Flügel auf einer Etage vereint. Die Gemäldegalerie wird in ihrer vollständigen Form vom 13. bis zum 20. Jahrhundert zusammenhängend im Erweiterungsbau von Reinhold Kargel gezeigt. Im Untergeschoss sind in neuen Ausstellungsräumen der internationale Jugendstil, die Vor- und Frühgeschichte, die japanische Kunst sowie die ägyptische und griechische Sammlung untergebracht. Mit moderner Ausstellungsgestaltung, einem reichhaltigen Informationsangebot und abwechslungsreichen Inszenierungen der Objekte erschließt sich dem Besucher eine Vielzahl von Sammlungen. Durch die Sanierung ist das HLMD technisch, infrastrukturell und inhaltlich für das 21. Jahrhundert gerüstet.",
              style: TextStyle(
                fontSize: SizeConfig.orientationDevice == Orientation.portrait
                    ? SizeConfig.safeBlockHorizontal * 5
                    : SizeConfig.safeBlockHorizontal * 2,
                fontFamily: "Nunito",
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ]));
  }

  Widget _carousel() {
    return SizedBox(
        width: horSize(92, 60),
        height: 250.0,
        child: Carousel(
          images: [
            ExactAssetImage(
                "assets/images/Postkarte_Darmstadt_Museums_WEbseite.jpg"),
            ExactAssetImage("assets/images/hlmd-Waffensaal-historisch.jpg"),
            ExactAssetImage("assets/images/hlmd-Kapelle-1906.jpg"),
            ExactAssetImage("assets/images/hlmd-Geologie-1906_Mastodon.jpg"),
            ExactAssetImage("assets/images/hlmd-Foyer-historisch__2_.jpg"),
            ExactAssetImage("assets/images/hlmd-Foyer-historisch.jpeg"),
            ExactAssetImage("assets/images/hlmd-Foyer-1960.jpg"),
            ExactAssetImage("assets/images/hlmd-Foyer-1906.jpeg"),
            ExactAssetImage(
                "assets/images/hlmd-Fertig_gestellter_Bau-_Aussenansicht-_nach_1902.jpeg"),
            ExactAssetImage("assets/images/hlmd-Barocksaal_1906.jpeg"),
          ],
          dotSize: 4.0,
          dotSpacing: 15.0,
          dotColor: Colors.white,
          indicatorBgPadding: 5.0,
          dotBgColor: Colors.white38.withOpacity(0.5),
          borderRadius: true,
          autoplay: false,
        ));
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var content;
    switch (_type) {
      case PageType.HISTORY:
        content = _museumHistoryPage();
        break;
      case PageType.OPENING_PRICE:
        content = _openingNprice();
        break;
      case PageType.EVENTS:
        content = _events();
        break;
      case PageType.DIRECTION:
        content = _directions();
        break;
      default:
        debugPrint("AAAAAA");
        content = _aboutMuseum();
    }
    return WillPopScope(
      onWillPop: () {
        if (_type == PageType.HOME_MUSEUM)
          widget.goBack();
        setState(() => _type = PageType.HOME_MUSEUM);
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
