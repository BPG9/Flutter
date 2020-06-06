import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:museum_app/add_tour/search_widget.dart';
import 'package:museum_app/database/modelling.dart';
import 'package:museum_app/database/moor_db.dart';
import 'package:museum_app/tours_page/walk_tour/walk_tour_content.dart';
import 'package:museum_app/tours_page/walk_tour/walk_tour_extras.dart';
import 'package:popup_menu/popup_menu.dart';
import 'package:reorderables/reorderables.dart';

import '../SizeConfig.dart';
import '../constants.dart';

class EditSingleStop extends StatefulWidget {
  final ActualStop stop;

  EditSingleStop(this.stop, {Key key}) : super(key: key);

  @override
  _EditSingleStopState createState() => _EditSingleStopState();
}

class _EditSingleStopState extends State<EditSingleStop> {
  TextEditingController _ctrlSearch = TextEditingController();

  @override
  void dispose() {
    _ctrlSearch.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            color: COLOR_ADD,
            height: verSize(17, 31, top: true),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(
                        left: horSize(16, 9, left: true),
                        top: verSize(3.5, 5.5, top: true)),
                    //alignment: Alignment.center,
                    child: Text("Zurück zur Stationsübersicht"),
                  ),
                ),
                _selecter(),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _maker(),
                _sideBar(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _selecter() {
    return Container(
        color: Colors.white,
        child: StreamBuilder(
          stream: MuseumDatabase().watchCustomStop(),
          builder: (context, snap) {
            Stop stop = snap.data?.stop;
            return DropdownButton(
              hint: Text("  " + widget.stop.stop?.name),
              isExpanded: true,
              items: [
                DropdownMenuItem(
                  value: 0,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Icon(Icons.add),
                      Text("  Museumsobjekt auswählen  "),
                      Icon(FontAwesomeIcons.crown),
                    ],
                  ),
                ),
                DropdownMenuItem(
                  value: 1,
                  child: Row(
                    children: [
                      Icon(Icons.add),
                      Text("  Zwischenstation einfügen  "),
                    ],
                  ),
                ),
              ],
              onChanged: (value) async {
                switch (value) {
                  case 0:
                    _searchDialog();
                    break;
                  case 1:
                    _setStop((await MuseumDatabase().getCustomStop()));
                    break;
                  default:
                }
              },
            );
          },
        ));
  }

  _searchDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        contentPadding: EdgeInsets.only(left: 15, right: 15, top: 15),
        content: Container(
          width: horSize(100, 100),
          height: verSize(53, 50),
          child: MuseumSearch(_setStop, _ctrlSearch),
        ),
        actions: [
          FlatButton(
            onPressed: () => MuseumSearch.showHintScreen(context),
            splashColor: COLOR_ADD.withOpacity(.25),
            child: Text("Hilfe?!", style: TextStyle(color: COLOR_ADD)),
          ),
          Container(width: horSize(25, 50)),
          FlatButton(
            onPressed: () => Navigator.pop(context),
            splashColor: COLOR_ADD.withOpacity(.25),
            child: Text("Schließen", style: TextStyle(color: COLOR_ADD)),
          ),
        ],
      ),
    );
  }

  void _setStop(Stop s) {
    print(s);
    setState(() {
      widget.stop.stop = s;
      widget.stop.features = StopFeature(
        id: null,
        id_tour: null,
        id_stop: s?.id ?? customName,
        showImages: !widget.stop.isCustom(),
        showText: true,
        showDetails: !widget.stop.isCustom(),
      );
    });
  }

  // right-hand sidebar
  Widget _sideBar() {
    return Container(
      color: COLOR_ADD,
      width: horSize(19, 14),
      //height: verSize(80, 90),
      alignment: Alignment.topCenter,
      child: ListView(
        padding: EdgeInsets.only(top: 10),
        //buttonMinWidth: horSize(15, 20),
        //buttonHeight: 15,//verSize(1, 15),
        children: [
          _objectLabel([
            _withLabel(Icons.photo_camera, "Fotos",
                funct: widget.stop.isCustom()
                    ? null
                    : () => setState(() {
                          if (widget.stop.features == null) return;
                          var showImgs = widget.stop.features.showImages;
                          widget.stop.features = widget.stop.features
                              .copyWith(showImages: !showImgs);
                        }),
                cross: !widget.stop.isCustom() &&
                    !widget.stop.features.showImages),
            _withLabel(FontAwesomeIcons.fileAlt, "Text",
                funct: widget.stop.isCustom()
                    ? null
                    : () => setState(() {
                          if (widget.stop.features == null) return;
                          var showText = widget.stop.features.showText;
                          widget.stop.features = widget.stop.features
                              .copyWith(showText: !showText);
                        }),
                cross:
                    !widget.stop.isCustom() && !widget.stop.features.showText),
            _withLabel(
              FontAwesomeIcons.table,
              "Details",
              funct: widget.stop.isCustom()
                  ? null
                  : () => setState(() {
                        if (widget.stop.features == null) return;
                        var showDetails = widget.stop.features.showDetails;
                        widget.stop.features = widget.stop.features
                            .copyWith(showDetails: !showDetails);
                      }),
              cross:
                  !widget.stop.isCustom() && !widget.stop.features.showDetails,
            ),
          ]),
          _withLabel(
            Icons.text_fields,
            "Textfeld",
            funct: () => setState(() => widget.stop.extras
                .add(ActualExtra(ExtraType.TEXT, text: "Textfreifeld"))),
          ),
          _withLabel(
            Icons.playlist_add,
            "Aufgabe",
            funct: _onTapTask,
            key: _keyTask,
          ),
          // TODO MC speichere "nichts ist richtig" ab
          _withLabel(
            FontAwesomeIcons.fileImage,
            "Bild",
            funct: widget.stop.stop.images.isEmpty
                ? null
                : () => setState(() => widget.stop.extras.add(ActualExtra(
                    ExtraType.IMAGE,
                    text: widget.stop.stop.images.join(";")))),
            key: _keyImg,
          ),
        ],
      ),
    );
  }

  GlobalKey _keyTask = GlobalKey();
  GlobalKey _keyImg = GlobalKey();

  void _onTapTask() {
    PopupMenu m = PopupMenu(
      context: context,
      backgroundColor: COLOR_ADD.withOpacity(.8),
      highlightColor: COLOR_ADD.withOpacity(.3),
      items: [
        MenuItem(
            title: "Text",
            image: Icon(Icons.list),
            textStyle: TextStyle(color: Colors.white)),
        MenuItem(
            title: "Multi",
            image: Icon(Icons.check_box),
            textStyle: TextStyle(color: Colors.white)),
        MenuItem(
            title: "Single",
            image: Icon(Icons.check_circle),
            textStyle: TextStyle(color: Colors.white)),
      ],
      onClickMenu: _onClickTask,
    );
    m.show(widgetKey: _keyTask);
  }

  void _onClickTask(MenuItemProvider prov) {
    switch (prov.menuTitle) {
      case "Text":
        setState(() => widget.stop.extras.add(
              ActualExtra(
                ExtraType.TASK_TEXT,
                text: "Aufgabentext",
                sel: ["Antwort"],
                correct: <int>{},
              ),
            ));
        break;
      case "Multi":
        setState(() => widget.stop.extras.add(
              ActualExtra(
                ExtraType.TASK_MULTI,
                text: "Aufgabentext",
                sel: ["Antwort"],
                correct: <int>{},
              ),
            ));
        break;
      case "Single":
        setState(() => widget.stop.extras.add(
              ActualExtra(
                ExtraType.TASK_SINGLE,
                text: "Aufgabentext",
                sel: ["Antwort"],
                correct: <int>{},
              ),
            ));
        break;
    }
  }

  Widget _objectLabel(widgets, {Color color = Colors.white}) {
    return Column(
      children: [
        Text("Objekt", style: TextStyle(color: color)),
        Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: 21),
              padding: EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: color, width: 3),
              ),
              child: Column(
                children: widgets,
              ),
            ),
            Positioned(
              top: 1,
              left: 2,
              right: 2,
              child: Icon(FontAwesomeIcons.crown, color: color),
            ),
          ],
        ),
      ],
    );
  }

  Widget _withLabel(IconData i, String t,
      {Color color = Colors.white, funct, cross = false, Key key}) {
    if (funct == null) color = color.withOpacity(.5);
    return GestureDetector(
      key: key,
      onTap: funct,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 3),
        margin: EdgeInsets.symmetric(vertical: 2),
        child: Column(
          children: [
            Stack(
              overflow: Overflow.visible,
              children: [
                Icon(i, color: color),
                Positioned(
                  bottom: -10,
                  right: -10,
                  child: Transform.rotate(
                    angle: pi / 4,
                    child: cross
                        ? Icon(
                            Icons.add,
                            size: 45,
                            color: Colors.red,
                          )
                        : Container(),
                  ),
                )
              ],
            ),
            Text(t, style: TextStyle(color: color))
          ],
        ),
      ),
    );
  }

  Widget _maker() {
    List<ActualExtra> tasks =
        widget.stop.extras.where((e) => e.task != null).toList();
    return Expanded(
      child: Container(
        height: verSize(75, 90),
        color: COLOR_ADD.withOpacity(0.5),
        child: ReorderableWrap(
          controller: ScrollController(),
          runSpacing: 8,
          header: TourWalkerContent(
            widget.stop,
            color: Colors.black,
            showExtras: false,
          ),
          onReorder: (int oldIndex, int newIndex) => setState(() {
            var old = widget.stop.extras[oldIndex];

            oldIndex += newIndex < oldIndex ? 1 : 0;
            newIndex += newIndex > oldIndex ? 1 : 0;

            widget.stop.extras.insert(newIndex, old);
            widget.stop.extras.removeAt(oldIndex);
          }),
          children: widget.stop.extras
              .map(
                (e) => Container(
                  //padding: EdgeInsets.only(left: 8),
                  margin: EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(7),
                        bottomRight: Radius.circular(7)),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left: 8, right: 5),
                          color: COLOR_ADD.withOpacity(.5),
                          child: TourExtra(
                            tasks.indexOf(e) + 1,
                            e,
                            edit: true,
                          ),
                        ),
                      ),
                      Container(
                        width: horSize(10, 5),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          //crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 3),
                              child: Icon(Icons.drag_handle),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 3),
                              child: GestureDetector(
                                  onTap: () => _removeExtra(e),
                                  child: Icon(Icons.remove_circle)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
          footer: Container(height: verSize(4, 4)),
        ),
      ),
    );
  }

  void _removeExtra(ActualExtra e) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Warnung"),
              content: Text(
                  "Möchten Sie das ausgewählte Extra wirklich entfernen?\nDies kann nicht rückgängig gemacht werden."),
              actions: [
                FlatButton(
                  child: Text("Abbrechen", style: TextStyle(color: COLOR_ADD)),
                  onPressed: () => Navigator.pop(context),
                ),
                FlatButton(
                  child: Text("Extra entfernen",
                      style: TextStyle(color: COLOR_ADD)),
                  onPressed: () => setState(() {
                    widget.stop.extras.remove(e);
                    Navigator.pop(context);
                  }),
                ),
              ],
            ));
  }
}
