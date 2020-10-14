import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:museum_app/constants.dart';
import 'package:museum_app/database/moor_db.dart';
import 'package:museum_app/museum_tabs.dart';
import 'package:museum_app/server_connection/query.dart';
import 'package:museum_app/tours_page/tours_widgets.dart';

import '../util.dart';

class Tours extends StatefulWidget {
  Tours({Key key}) : super(key: key);

  @override
  _ToursState createState() => _ToursState();
}

class _ToursState extends State<Tours> {
  TextEditingController _ctrlSearch = TextEditingController();
  TextEditingController _ctrlCode = TextEditingController();

  Widget _topInfo() {
    return Center(
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/product_tour_text.png')),
            ),
          ),
          /*Positioned(
            left: SizeConfig.blockSizeHorizontal * 2,
            top: SizeConfig.blockSizeVertical * 2,
            child: FlatButton(
              padding: EdgeInsets.all(3),
              shape: CircleBorder(),
              child: Icon(
                Icons.map,
                color: Colors.white,
                size: 40,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MapPage()));
              },
            ),
          ),*/
        ],
      ),
    );
  }

  Widget _allTours() {
    return Column(children: <Widget>[
      Container(
        margin: EdgeInsets.only(left: 16, right: 16, bottom: 16),
        padding: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(30),
        ),
        child: TextField(
          controller: _ctrlSearch,
          onSubmitted: (s) {
            setState(() {});
          },
          decoration: InputDecoration(
            icon: Icon(Icons.search),
            border: InputBorder.none,
            labelText: "Tour suchen...",
          ),
        ),
      ),
      DownloadColumn(
        QueryBackend.featured,
        search: _ctrlSearch.text,
        color: COLOR_TOUR,
      ),
    ]);
  }

  Widget _code() {
    return Column(
      children: [
        Text(
          "Tour beitreten?\nCode eingeben!",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: COLOR_TOUR, fontWeight: FontWeight.bold, fontSize: 25),
        ),
        border(
          TextField(
            controller: _ctrlCode,
            onSubmitted: (s) async {
              bool ok = await MuseumDatabase().joinAndDownloadTour(s);
              String cont = ok
                  ? "Tour heruntergeladen!"
                  : "Tour konnte nicht gefunden werden...";
              Scaffold.of(context).showSnackBar(SnackBar(content: Text(cont)));
            },
            decoration: InputDecoration(
                icon: Icon(Icons.keyboard), border: InputBorder.none),
          ),
          margin: EdgeInsets.symmetric(horizontal: 24, vertical: 17),
          padding: EdgeInsets.symmetric(horizontal: 7),
          borderColor: COLOR_TOUR,
        ),
        Text(
          "... oder einen QR-Code scannen!",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: COLOR_TOUR, fontWeight: FontWeight.bold, fontSize: 25),
        ),
        GestureDetector(
          onTap: () {
            Scaffold.of(context).showSnackBar(SnackBar(content: Text("Not yet implemented")));
            print("QR not implemented");
          },
          child: border(
            Icon(FontAwesomeIcons.qrcode, size: 50),
            borderColor: COLOR_TOUR,
            margin: EdgeInsets.only(top: 17),
          ),
        ),
      ],
    );
  }
  final GlobalKey _qrKey = GlobalKey(debugLabel: "QR");

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: MuseumDatabase().usersDao.accessToken(),
      builder: (context, snap) {
        String token = snap.data ?? "";
        if (!snap.hasData || token == "")
          return MuseumTabs.single(
            _topInfo(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 80),
              child: Text(
                "Du musst dich anmelden, um auf die angebotenen Touren zugreifen zu können.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 17),
              ),
            ),
            showMap: true,
          );
        return MuseumTabs(
          _topInfo(),
          {
            // All (online) tours
            "Alle": _allTours(), //_bottomInfo((_) => (tour) => true),
            // Only the local/downloaded ones
            "Downloads": TourList.downloaded(),
            // Add a tour via a code
            "Code": _code(),
          },
          color: COLOR_TOUR,
          showMap: true,
        );
      },
    );
  }
}
