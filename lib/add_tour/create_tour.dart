import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:museum_app/constants.dart';
import 'package:museum_app/database/database.dart';
import 'package:museum_app/database/modelling.dart';
import 'package:museum_app/museum_tabs.dart';
import 'package:reorderables/reorderables.dart';

import '../SizeConfig.dart';
import 'add_tour.dart';
import 'edit_single_stop.dart';

class CreateTour extends StatefulWidget {
  final void Function() goBack;
  final TourWithStops tour;

  CreateTour(this.goBack, this.tour, {Key key}) : super(key: key);

  //CreateTour.empty(goBack, String name, {Key key}) : this(goBack, TourWithStops.empty(name), key: key);

  @override
  _CreateTourState createState() => _CreateTourState();
}

class _CreateTourState extends State<CreateTour> {
  int _index = 0;
  CreateType _type = CreateType.GENERAL;

  //final List<ActualStop> stops = [ActualStop.custom()];

  @override
  void initState() {
    super.initState();
    KeyboardVisibilityNotification().addNewListener(
        onHide: () => FocusScope.of(context).requestFocus(FocusNode()));
  }

  Widget _editMultiStop() {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          _navigator(),
          _info(),
          Expanded(
            child: Container(
              width: horSize(100, 100),
              child: ReorderableWrap(
                //alignment: WrapAlignment.center,
                //crossAxisAlignment: WrapCrossAlignment.center,
                needsLongPressDraggable: true,
                alignment: WrapAlignment.center,
                //padding: EdgeInsets.only(top: 30, right: horPad, left: horPad),
                buildDraggableFeedback: (contexta, constraints, widget) =>
                    Material(child: widget, color: Colors.transparent),
                //spacing: 50.0,
                maxMainAxisCount: 1,
                onReorder: (int oldIndex, int newIndex) => setState(() {
                  var old = widget.tour.stops[oldIndex];

                  oldIndex += newIndex < oldIndex ? 1 : 0;
                  newIndex += newIndex > oldIndex ? 1 : 0;

                  widget.tour.stops.insert(newIndex, old);
                  widget.tour.stops.removeAt(oldIndex);
                }),
                children: widget.tour.stops.map(_draggable).toList(),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _info() {
    var style = TextStyle(color: Colors.white, fontWeight: FontWeight.bold);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      color: COLOR_ADD.withOpacity(.5),
      height: verSize(13, 10),
      width: horSize(100, 100),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: verSize(1, 1),
        runSpacing: horSize(7, 2),
        direction: Axis.vertical,
        children: [
          Row(children: [
            Icon(Icons.add_circle, color: Colors.white),
            Text(" Station ergänzen", style: style),
          ]),
          Row(children: [
            Icon(Icons.remove_circle, color: Colors.white),
            Text(" Station löschen", style: style),
          ]),
          Row(children: [
            Icon(Icons.touch_app, color: Colors.white),
            Text(" Station bearbeiten\n durch tippen", style: style),
          ]),
          Row(children: [
            Icon(Icons.crop_5_4, color: Colors.white),
            Text(" Reihenfolge ändern\n durch gedrückt halten", style: style),
          ]),
        ],
      ),
    );
  }

  Widget _navigator() {
    //var topPad = MediaQuery.of(context).padding.top;

    String tourName = widget.tour.name.text.trim();
    if (tourName.isEmpty) tourName = "NEUE TOUR";
    String tourAuthor = widget.tour.author.trim();
    if (tourAuthor.isEmpty) tourAuthor = "mir";
    return Container(
      padding: EdgeInsets.only(
          left: 15, right: 15, bottom: 9, top: SizeConfig.padding.top),
      height: verSize(13, 23, top: true),
      color: COLOR_ADD,
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.center,
        //mainAxisSize: MainAxisSize.min,
        children: [
          Container(width: horSize(21, 15, left: true)),
          Container(
            //color: Colors.red,
            width: horSize(50, 65),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  tourName,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  "von " + tourAuthor,
                  style: TextStyle(
                    fontSize: 15,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
          //Spacer(),
          //MuseumSettings(),
        ],
      ),
    );
  }

  Widget _draggable(ActualStop elem) {
    return GestureDetector(
      onTap: () => setState(() {
        _index = widget.tour.stops.indexOf(elem);
        _type = CreateType.SINGLE_STOP;
      }),
      child: border(
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: horSize(37, 30),
              height: verSize(17, 23),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 8),
                    height: verSize(7, 7),
                    child: Text(
                      "Station " +
                          (widget.tour.stops.indexOf(elem) + 1).toString(),
                      style: TextStyle(
                        color: COLOR_ADD,
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                      child: Text(
                    elem.stop?.name ?? "Fehler",
                    style: TextStyle(fontSize: 16),
                  ))
                ],
              ),
            ),
            Container(
              //margin: EdgeInsets.only(left: 25),
              width: horSize(16, 8),
              //color: Colors.green,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                //buttonMinWidth: 50,
                //buttonPadding: EdgeInsets.zero,
                //buttonHeight: 40,
                children: [
                  StreamBuilder(
                      stream: MuseumDatabase.get().getCustomStop(),
                      builder: (context, snap) {
                        var stop = snap.data ?? ActualStop.custom();
                        return IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () => setState(() {
                            var index = widget.tour.stops.indexOf(elem);
                            widget.tour.stops.insert(index + 1, stop);
                          }),
                          icon: Icon(Icons.add_circle),
                          iconSize: 50,
                          color: COLOR_ADD,
                        );
                      }),
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {if (widget.tour.stops.length > 1) _removeStop(elem);},
                    icon: Icon(Icons.remove_circle),
                    iconSize: 50,
                    color: COLOR_ADD,
                  ),
                ],
              ),
            ),
          ],
        ),
        margin: EdgeInsets.symmetric(vertical: 10),
      ),
    );
  }

  void _removeStop(ActualStop s) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Warnung"),
              content: Text(
                  "Möchten Sie die ausgewählte Station wirklich entfernen?\nDies kann nicht rückgängig gemacht werden."),
              actions: [
                FlatButton(
                  child: Text("Abbrechen", style: TextStyle(color: COLOR_ADD)),
                  onPressed: () => Navigator.pop(context),
                ),
                FlatButton(
                  child: Text("Station entfernen",
                      style: TextStyle(color: COLOR_ADD)),
                  onPressed: () => setState(() {
                    widget.tour.stops.remove(s);
                    if (_index >= widget.tour.stops.length) _index--;
                    Navigator.pop(context);
                  }),
                ),
              ],
            ));
  }

  Widget _general() {
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
      border(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: widget.tour.name,
              autovalidate: true,
              validator: (s) => MIN_TOURNAME > s.length
                  ? "Name zu kurz"
                  : (MAX_TOURNAME < s.length ? "Name zu lang" : null),
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.border_color),
                labelText: "Tournamen festlegen",
                border: InputBorder.none,
              ),
            ),
            Text("Schwierigkeitsgrad bestimmen:"),
            RatingBar(
              initialRating: widget.tour.difficulty,
              minRating: 1,
              allowHalfRating: true,
              onRatingUpdate: (r) => widget.tour.difficulty = r,
              itemBuilder: (context, _) => Icon(Icons.school),
              tapOnlyMode: true,
              itemSize: 33,
            ),
            Text("Eine kurze Beschreibung verfassen:"),
            Container(
              margin: EdgeInsets.only(top: 5),
              height: verSize(18, 30),
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              padding: EdgeInsets.symmetric(horizontal: 13),
              child: TextFormField(
                expands: true,
                minLines: null,
                maxLines: null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
                controller: widget.tour.descr,
              ),
            ),
            ButtonBar(
              buttonPadding: EdgeInsets.all(6),
              alignment: MainAxisAlignment.center,
              buttonHeight: verSize(6.5, 11),
              buttonMinWidth: horSize(35, 29),
              children: [
                FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  textColor: Colors.white,
                  color: COLOR_ADD,
                  onPressed: () {
                    // TODO make input variable
                    widget.tour.creationTime = DateTime.now();
                    for (var s in widget.tour.stops)
                      for (var e in s.extras)
                        if (e is ActualTask) {
                          //e.descr.text = e.descr.text.trim();
                          e.textInfo.text = e.textInfo.text.trim();
                        }
                    MuseumDatabase.get().writeTourStops(widget.tour).then(
                        (val) {
                      widget.goBack();
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text("Tour hinzugefügt!"),
                      ));
                    });
                  },
                  child: Text("Fertigstellen"),
                ),
                FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    textColor: Colors.white,
                    color: COLOR_ADD,
                    onPressed: () =>
                        setState(() => _type = CreateType.MULTI_STOP),
                    child: Text("Stationen festlegen"))
              ],
            ),
          ],
        ),
        margin: EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 7),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
      showSetting: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    //print("Tour: "+widget.tour.stops[_index].stop.name);
    Widget mainWidget;
    switch (_type) {
      case CreateType.GENERAL:
        mainWidget = _general();
        break;
      case CreateType.MULTI_STOP:
        mainWidget = _editMultiStop();
        break;
      case CreateType.SINGLE_STOP:
        mainWidget = EditSingleStop(widget.tour.stops[_index]);
        break;
    }
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Container(
        height: SizeConfig.safeBlockVertical * 100,
        child: Stack(
          children: [
            mainWidget,
            Positioned(
              left: horSize(2, 2, left: true),
              top: verSize(1, 1, top: true),
              child: _backButton(),
            ),
            Positioned(
              right: horSize(2, 2, right: true),
              top: verSize(1, 1, top: true),
              child: MuseumSettings(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _backButton() {
    var funct;
    String label = "";
    switch (_type) {
      case CreateType.GENERAL:
        funct = _confirmBack;
        label = "Übersicht";
        break;
      case CreateType.MULTI_STOP:
        funct = () => setState(() => _type = CreateType.GENERAL);
        label = "Zu Tourdaten";
        break;
      case CreateType.SINGLE_STOP:
        funct = () => setState(() => _type = CreateType.MULTI_STOP);
        break;
    }
    return Container(
      width: horSize(25, 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            onPressed: funct,
            icon: Icon(Icons.arrow_back),
            iconSize: 30,
          ),
          Text(label),
        ],
      ),
    );
  }

  void _confirmBack() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Warnung"),
              content: Text(
                  "Möchten Sie wirklich zur Übersicht zurückkehren?\nAlle Änderungen gehen unwiderruflich verloren."),
              actions: [
                FlatButton(
                  child: Text("Abbrechen", style: TextStyle(color: COLOR_ADD)),
                  onPressed: () => Navigator.pop(context),
                ),
                FlatButton(
                  child:
                      Text("Zur Übersicht", style: TextStyle(color: COLOR_ADD)),
                  onPressed: () => setState(() {
                    widget.goBack();
                    Navigator.pop(context);
                  }),
                ),
              ],
            ));
  }
}

enum CreateType { GENERAL, MULTI_STOP, SINGLE_STOP }