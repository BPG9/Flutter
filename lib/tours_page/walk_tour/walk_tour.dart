import 'dart:io';

import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';
import 'package:museum_app/SizeConfig.dart';
import 'package:museum_app/constants.dart';
import 'package:museum_app/database/modelling.dart';
import 'package:museum_app/database/moor_db.dart';
import 'package:museum_app/graphql/graphqlConf.dart';
import 'package:museum_app/graphql/query.dart';
import 'package:museum_app/map/map_page.dart';
import 'package:museum_app/tours_page/walk_tour/walk_tour_content.dart';
import 'package:museum_app/tours_page/walk_tour/walk_tour_extras.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class TourWalker extends StatefulWidget {
  final TourWithStops tour;

  TourWalker({Key key, this.tour}) : super(key: key);

  @override
  _TourWalkerState createState() => _TourWalkerState();
}

class _TourWalkerState extends State<TourWalker> with TickerProviderStateMixin {
  int _currentItem = 0;
  BottomBarController bbc;

  //final double dragLength = verSize(60, 60); //420

  @override
  void dispose() {
    bbc?.dispose();
    super.dispose();
  }

  Widget _navigator(List<ActualStop> stops) {
    var topPad = MediaQuery.of(context).padding.top;

    int length = stops.length;
    Color colorNav = Colors.white;
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15, bottom: 9, top: topPad),
      height: verSize(10, 25) + topPad, //13,25
      decoration: BoxDecoration(
        color: COLOR_TOUR,
        border: Border(bottom: BorderSide(color: Colors.black, width: 1.5)),
      ),
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.center,
        //mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              //color: Colors.orange,
              alignment: Alignment.centerLeft,
              width: horSize(17, 10),
              child: _currentItem < length
                  ? Text(
                      "Station\n" +
                          (_currentItem + 1).toString() +
                          " / $length",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 17, color: colorNav),
                    )
                  : Icon(FontAwesomeIcons.crown, color: Colors.white)),
          Spacer(),
          Container(
            //color: Colors.red,
            width: horSize(50, 65),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.tour.name.text,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: TextStyle(
                      fontSize: 18,
                      color: colorNav,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "von " + widget.tour.author,
                  style: TextStyle(
                      fontSize: 15,
                      fontStyle: FontStyle.italic,
                      color: colorNav),
                ),
              ],
            ),
          ),
          Spacer(),
          Container(
            //color: Colors.orange,
            alignment: Alignment.centerRight,
            width: horSize(15, 10),
            child: FlatButton(
                shape: CircleBorder(),
                padding: EdgeInsets.all(size(12, 7)),
                child: Icon(Icons.map, size: 30, color: colorNav),
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MapPage()))),
          ),
        ],
      ),
    );
  }

  List<Widget> _previewStops(List<ActualStop> stops) {
    var length = stops.length;
    return List.generate(
      length,
      (index) => Container(
        margin: EdgeInsets.symmetric(vertical: 7),
        foregroundDecoration: BoxDecoration(
            color: index == _currentItem
                ? Colors.white.withOpacity(.35)
                : Colors.transparent),
        decoration: BoxDecoration(
          color: COLOR_TOUR,
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          child: FlatButton(
            onPressed: index == _currentItem || _currentItem == length
                ? null
                : () => setState(() {
                      _currentItem = index;
                      bbc.swap();
                    }),
            padding: EdgeInsets.all(0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: horSize(35, 30),
                  height: verSize(17, 20),
                  decoration: BoxDecoration(
                    /*image: DecorationImage(
                        image: AssetImage(stops[index].stop.images.isNotEmpty
                            ? stops[index].stop.images[0]
                            : "assets/images/profile_test.png"),
                        fit: BoxFit.cover),*/
                    border: Border(right: BorderSide(color: Colors.black)),
                  ),
                  child: stops[index].stop.id == customName
                      ? Image(image: AssetImage("assets/images/haupthalle_hlm_blue.png"), fit: BoxFit.cover,)
                      : QueryBackend.networkImageWidget(
                          QueryBackend.imageURLPicture(
                              stops[index].stop.images.isNotEmpty
                                  ? stops[index].stop.images[0]
                                  : ""),
                        ),
                ),
                Container(
                  //color: Colors.yellow,
                  alignment: Alignment.center,
                  width: horSize(45, 59),
                  padding: EdgeInsets.symmetric(horizontal: 2),
                  child: Text(
                    (index + 1).toString() +
                        " / $length\n" +
                        stops[index].stop.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _exitTour() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Achtung"),
        content: Text(
            "Wenn Du die Tour jetzt beendest, gehen ggf. Deine gesamten Antworten verloren."),
        actions: [
          FlatButton(
            onPressed: () {
              // clear the input
              for (var stop in widget.tour.stops)
                for (var extra in stop.extras)
                  if (extra.task != null) extra.task.reset();
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Text("Beenden", style: TextStyle(color: COLOR_TOUR)),
          ),
          FlatButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Tour fortsetzen", style: TextStyle(color: COLOR_TOUR)),
          ),
        ],
      ),
    );
  }

  void _toResults() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Achtung"),
        content: Text("Nachdem Du die Ergebnisse angeschaut hast, können Deine "
            "Antworten nicht mehr verändert werden.\nFortfahren?"),
        actions: [
          FlatButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Schließen", style: TextStyle(color: COLOR_TOUR)),
          ),
          FlatButton(
            onPressed: () {
              setState(() => _currentItem++);
              Navigator.pop(context);
            },
            child:
                Text("Zu den Ergebnissen", style: TextStyle(color: COLOR_TOUR)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double dragLength = verSize(68, 55);

    bbc?.dispose();
    bbc = BottomBarController(vsync: this, dragLength: dragLength);
    bbc.close();

    var bottomOff = MediaQuery.of(context).viewInsets.bottom;
    var stops = widget.tour.stops ?? <ActualStop>[];
    return WillPopScope(
      onWillPop: () {
        if (_currentItem == 0)
          _exitTour();
        else
          setState(() => _currentItem--);
        return Future.value(false);
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          extendBody: true,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: GestureDetector(
            onVerticalDragUpdate: bbc.onDrag,
            onVerticalDragEnd: bbc.onDragEnd,
            child: FloatingActionButton.extended(
              label: Text("Stationen",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              elevation: 1,
              // here: buttonColor
              backgroundColor: COLOR_TOUR,
              // here: textColor
              foregroundColor: Colors.white,
              onPressed: () => bbc.swap(),
            ),
          ),
          bottomNavigationBar: BottomExpandableAppBar(
            //bottomOffset: MediaQuery.of(context).viewInsets.bottom+10,
            controller: bbc,
            expandedHeight: dragLength,
            shape: AutomaticNotchedShape(
                RoundedRectangleBorder(), StadiumBorder(side: BorderSide())),
            //expandedBackColor: Colors.red,
            expandedDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.grey[100],
                border: Border.all(color: Colors.black, width: 1.5)),
            expandedBody: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: ListView(
                  padding:
                      EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 50),
                  children: _previewStops(stops)),
            ),
            bottomAppBarBody: Container(
              decoration: BoxDecoration(
                color: COLOR_TOUR,
                borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                border: Border.all(color: Colors.black, width: 1.5),
              ),
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  FlatButton(
                    onPressed: _exitTour, //{Navigator.pop(context);},
                    child: Row(children: [
                      Icon(Icons.flag, color: Colors.white),
                      Text(
                        "Beenden",
                        style: TextStyle(color: Colors.white),
                      )
                    ]),
                  ),
                  Spacer(flex: 2),
                  _continueButton(stops.length),
                ],
              ),
            ),
          ),
          backgroundColor: Colors.white,
          body: Column(
            children: [
              _navigator(stops),
              Expanded(
                child: Container(
                  alignment: Alignment.topCenter,
                  padding: EdgeInsets.all(0),
                  //height: verSize(83, 75),
                  child: ListView(
                    padding: EdgeInsets.all(0),
                    children: [
                      _currentItem < stops.length
                          ? TourWalkerContent(stops[_currentItem])
                          : _results(),
                      /*TourWalkerTasks(widget
                        .tour.tasks[widget.tour.stops[_currentItem].name]),*/
                      Container(
                          height: bottomOff == 0 ? verSize(12, 21) : bottomOff),
                      //15,21
                      //_content(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _continueButton(int length) {
    bool hasTasks = false, hasTextTask = false;
    for (ActualStop s in widget.tour.stops) {
      for (ActualExtra t in s.extras) {
        hasTasks |= (t.task != null && t.type != ExtraType.TASK_TEXT);
        hasTextTask |= (t.type == ExtraType.TASK_TEXT);
      }
    }

    Function onPressed;
    Widget child;
    // last page, no tasks to check
    if (_currentItem == length - 1 && !hasTasks) {
      // no information to upload / results to show in TXT
      if (!hasTextTask)
        onPressed = _exitTour;
      else
        onPressed = () async {
          await MuseumDatabase().uploadAnswers(widget.tour);
          finishTour();
        };
      child = Icon(Icons.check, color: Colors.white);
    }
    // last page
    else if (_currentItem == length - 1) {
      onPressed = _toResults;
      child = Row(
        children: [
          Text("Ergebnis", style: TextStyle(color: Colors.white)),
          Icon(Icons.arrow_forward, color: Colors.white),
        ],
      );
    }
    // on review page
    else if (_currentItem == length) {
      onPressed = () async {
        await MuseumDatabase().uploadAnswers(widget.tour);
        finishTour();
      };
      child = Icon(Icons.check, color: Colors.white);
    }
    // normal page
    else {
      onPressed = () => setState(() => _currentItem++);
      child = Row(
        children: [
          Text("Weiter", style: TextStyle(color: Colors.white)),
          Icon(Icons.arrow_forward, color: Colors.white),
        ],
      );
    }

    return FlatButton(
      onPressed: onPressed,
      child: child,
    );
  }

  void finishTour() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Tour Antworten speichern"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Möchtest Du Deine Antworten als TXT-Datei speichern?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: horSize(4, 2),
                        fontFamily: "Nunito",
                        fontWeight: FontWeight.w300,
                        fontStyle: FontStyle.italic,
                        color: Color(0xFF1A1A1A)),
                  ),
                ],
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 16),
              actions: [
                FlatButton(
                  child: Text("Ja", style: TextStyle(color: COLOR_TOUR)),
                  onPressed: () async {
                    GraphQLClient _client =
                        GraphQLConfiguration().clientToQuery();
                    User user = await MuseumDatabase().getUser();

                    QueryResult result = await _client.query(QueryOptions(
                      documentNode: gql(QueryBackend.exportResult(
                          user.accessToken,
                          widget.tour.onlineId,
                          user.username)),
                    ));

                    var s = result.data["exportAnswers"];
                    print(s);

                    // reset
                    for (var stop in widget.tour.stops)
                      for (var extra in stop.extras)
                        if (extra.task != null) extra.task.reset();
                    saveAndReturnTxt(s)
                        .then((file) => OpenFile.open(file.path));
                    //Navigator.pop(context);
                    //Navigator.pop(context);
                  },
                ),
                FlatButton(
                  child: Text("Nein", style: TextStyle(color: COLOR_TOUR)),
                  onPressed: () {
                    // reset
                    for (var stop in widget.tour.stops)
                      for (var extra in stop.extras)
                        if (extra.task != null) extra.task.reset();
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                ),
              ],
            ));
  }

  //save String to txt file and return file
  Future<File> saveAndReturnTxt(String text) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/results.txt');
    await file.writeAsString(text);
    //Directory tempDir = await getTemporaryDirectory();
    //File tempFile = File('${tempDir.path}/results_temp.txt');
    //ByteData bd = await rootBundle.load('${directory.path}/results.txt');
    //await tempFile.writeAsBytes(bd.buffer.asUint8List(), flush: true);
    return file;
  }

  Widget _results() {
    // only use stops having at least one task
    List<ActualStop> stops = widget.tour.stops
        .where((s) => s.extras.fold(false, (p, e) => p || e.task != null))
        .toList();
    return Column(
      children: <Widget>[
            StreamBuilder(
              stream: MuseumDatabase().watchUser(),
              builder: (context, snap) {
                String username = snap.data?.username ?? "Anon. User";
                return RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(color: Colors.black),
                    children: [
                      TextSpan(
                        text: "Aufgabenergebnisse\n",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: username +
                            ", " +
                            DateFormat("dd.MM.yyyy").format(DateTime.now()),
                        style: TextStyle(
                          fontSize: 20,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ] +
          stops.map((s) {
            int id = stops.indexOf(s);
            List<ActualExtra> tasks =
                s.extras.where((e) => e.task != null).toList();
            return Container(
              //margin: EdgeInsets.symmetric(vertical: 5),
              padding: EdgeInsets.only(left: 16, right: 16, top: 12),
              decoration: id == 0
                  ? null
                  : BoxDecoration(
                      border: Border(top: BorderSide(color: Colors.black))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                      Text(
                        "Station " + (id + 1).toString() + ": " + s.stop.name,
                        style: TextStyle(
                            fontSize: 20, decoration: TextDecoration.underline),
                      )
                    ] +
                    tasks.map((e) {
                      int id = tasks.indexOf(e) + 1;
                      return TourExtra(id, e, result: true);
                    }).toList(),
              ),
            );
          }).toList(),
    );
  }
}
