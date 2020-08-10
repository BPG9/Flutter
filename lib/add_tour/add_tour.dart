import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:museum_app/SizeConfig.dart';
import 'package:museum_app/database/modelling.dart';
import 'package:museum_app/database/moor_db.dart';
import 'package:museum_app/museum_tabs.dart';

import '../constants.dart';
import '../util.dart';
import 'create_tour.dart';

class AddTour extends StatefulWidget {
  AddTour({Key key}) : super(key: key);

  @override
  _AddTourState createState() => _AddTourState();
}

enum AddType { CHOOSE, CREATE, EDIT }

class _AddTourState extends State<AddTour> {
  AddType _type = AddType.CHOOSE;
  TourWithStops _tour;

  void goBack() => setState(() => _type = AddType.CHOOSE);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return StreamBuilder(
        stream: MuseumDatabase().watchUser(),
        builder: (context, snap) {
          User u = snap.data;
          if (u == null) return Container();
          String name = u.username;

          switch (_type) {
            case AddType.CREATE:
              return CreateTour(goBack, _tour);
            /*
              return StreamBuilder(
                stream: MuseumDatabase().watchCustomStop(),
                builder: (context, snap) {
                  ActualStop stop = snap.data ?? ActualStop.custom();
                  if (_tour == null || _tour.author != name) {
                    _tour = TourWithStops.empty(name);
                    _tour.stops.add(stop);
                  }
                  return CreateTour(goBack, _tour);
                },
              );*/
            case AddType.EDIT:
              return StreamBuilder(
                stream: MuseumDatabase().getTourStops(),
                builder: (context, snap) {
                  var tours = snap.data ?? List<TourWithStops>();
                  tours = tours.where((t) => t.author == name).toList();
                  return _editList(tours);
                },
              );
            default:
              return MuseumTabs.single(
                Center(
                  child: Container(
                    height: verSize(25, 40),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            "assets/images/undraw_detailed_analysis_flipped.png"),
                      ),
                    ),
                  ),
                ),
                u.producer
                    ? _chooseState()
                    : Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 80),
                        child: Text(
                          "Du musst einen Erstellercode über die Einstellungen eingeben, "
                          "damit Du eine Tour erstellen kannst. Diese erhälst Du z.B. "
                          "von einem Lehrer.",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                showMap: this._type == AddType.CHOOSE,
              );
          }
        });
  }

  Widget _chooseState() {
    var margin = EdgeInsets.only(bottom: 15);
    return Container(
      margin: EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0, bottom: 10.0),
      child: Column(
        children: [
          border(
              _content(
                  "assets/images/undraw_new_entries_nh3h.png",
                  "Tour erstellen",
                  "Erstelle Deine eigene Tour durch das Landesmuseum.",
                  "Neue Tour erstellen", () async {
                setState(() => _type = AddType.CREATE);

                var name = (await MuseumDatabase().getUser())?.username;

                _tour = TourWithStops.empty(name);
                _tour.stops.add(ActualStop.custom());
              }),
              margin: margin),
          border(
              _content(
                  "assets/images/authentication.png",
                  "Tour bearbeiten",
                  "Bearbeite eine Deiner lokalen Touren oder ergänze sie um Stationen.",
                  "Touren bearbeiten",
                  () => setState(() => _type = AddType.EDIT)),
              margin: margin),
          border(
              GestureDetector(
                onTap: () {
                  Scaffold.of(context).showSnackBar(
                      SnackBar(content: Text("Not yet implemented")));
                  print("Video Erklär Tour");
                },
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: horSize(23, 23),
                      child: Icon(Icons.video_library,
                          color: COLOR_ADD, size: size(60, 74)),
                    ),
                    Container(
                      width: horSize(57, 60),
                      child: Text(
                        "Noch Fragen?\nSchau Dir ein Erklärvideo zur Tour-Erstellung an!",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: size(18, 20)),
                      ),
                    )
                  ],
                ),
              ),
              margin: margin,
              padding: EdgeInsets.all(15))
        ],
      ),
    );
  }

  Widget _content(
      String img, String title, String descr, String btnText, action) {
    return Row(
      children: [
        Container(
          width: horSize(34, 38),
          height: verSize(18, 45),
          decoration: BoxDecoration(
              image: DecorationImage(
                  //fit: BoxFit.contain,
                  image: AssetImage(img))),
        ),
        Container(
          margin: EdgeInsets.only(left: 8),
          width: horSize(48, 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: size(18, 20))),
              Text(descr, style: TextStyle(fontSize: size(14, 16))),
              FlatButton(
                onPressed: action,
                child: Text(btnText),
                color: COLOR_ADD,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _editList(List<TourWithStops> tours) {
    return WillPopScope(
      onWillPop: () {
        setState(() => _type = AddType.CHOOSE);
        return Future.value(false);
      },
      child: MuseumTabs.single(
        Stack(children: [
          Center(
            child: Container(
              height: verSize(25, 20),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      "assets/images/undraw_detailed_analysis_flipped.png"),
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
                      onPressed: () => setState(() => _type = AddType.CHOOSE),
                      icon: Icon(Icons.arrow_back),
                      iconSize: 30,
                    ),
                    Text("Übersicht"),
                  ],
                ),
              ))
        ]),
        Padding(
          padding: EdgeInsets.only(left: 16, right: 16, top: 15),
          child: Column(
            children: tours
                .map((t) => border(
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          width: horSize(100, 100),
                          child: Text(
                            t.name.text,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(
                              child: t.getRating(
                                color2: Colors.black.withOpacity(.5),
                                size: horSize(7.5, 4),
                              ),
                            ),
                            t.buildTime(color: Colors.black, scale: 1.2)
                          ],
                        ),
                        FlatButton(
                          color: COLOR_ADD,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(9)),
                          onPressed: () => setState(() {
                            _tour = t;
                            _type = AddType.CREATE;
                          }),
                          child: Text("Bearbeiten",
                              style: TextStyle(color: Colors.white)),
                        )
                      ],
                    ),
                    width: horSize(100, 100),
                    height: verSize(19, 10),
                    padding: EdgeInsets.only(left: 16, right: 16, top: 8),
                    margin: EdgeInsets.only(bottom: 19)))
                .toList(),
          ),
        ),
      ),
    );
  }
}
