import 'dart:math';

import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:museum_app/SizeConfig.dart';
import 'package:museum_app/constants.dart';
import 'package:museum_app/database/modelling.dart';
import 'package:museum_app/database/moor_db.dart';
import 'package:museum_app/image_carousel.dart';
import 'package:museum_app/tours_page/walk_tour/walk_tour_extras.dart';

class TourWalkerContent extends StatefulWidget {
  final ActualStop stop;
  final Color color;
  final bool showExtras;

  TourWalkerContent(this.stop,
      {Key key, this.color = COLOR_TOUR, this.showExtras = true})
      : super(key: key);

  TourWalkerContent.fromStop(Stop s)
      : this(ActualStop(
            s,
            StopFeature(showText: true, showImages: true, showDetails: true),
            []));

  @override
  _TourWalkerContentState createState() => _TourWalkerContentState();
}

class _TourWalkerContentState extends State<TourWalkerContent> {
  @override
  Widget build(BuildContext context) {
    var feat = widget.stop.features ??
        StopFeature(
            id_tour: 1,
            id_stop: "1",
            showImages: false,
            showDetails: false,
            showText: false);
    return Column(
      //shrinkWrap: true,
      //padding: EdgeInsets.all(0),
      children: [
        // Images
        feat.showImages
            ? ImageCaroussel.fromStrings(widget.stop.stop.images)
            : Container(height: 16),
        _information(feat.showText, feat.showDetails),
        //TourWalkerTasks(widget.),
      ],
    );
  }

  Widget _expButton(String text) => ExpandableButton(
        child: Container(
          //color: Colors.red,
          height: verSize(6, 10),
          width: horSize(37, 30),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
        ),
      );

  Widget _information(showText, showDetails) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          showText ? _text(widget.stop.stop) : Container(),
          showDetails ? _informationTable(widget.stop.stop) : Container(),
          widget.showExtras ? _extras(widget.stop.extras) : Container(),
        ],
      ),
    );
  }

  Widget _text(Stop stop) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableText(
          stop.name,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: widget.color,
          ),
        ),
        stop.descr.isNotEmpty
            ? ExpandableNotifier(
                child: Expandable(
                  theme: ExpandableThemeData(
                    tapBodyToCollapse: true,
                    tapBodyToExpand: true,
                  ),
                  collapsed: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        stop.descr,
                        maxLines: 5,
                        textAlign: TextAlign.justify,
                        style: TextStyle(fontSize: 18),
                        overflow: TextOverflow.ellipsis,
                      ),
                      _expButton("Mehr anzeigen"),
                    ],
                  ),
                  expanded: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SelectableText(
                        stop.descr,
                        textAlign: TextAlign.justify,
                        style: TextStyle(fontSize: 18),
                      ),
                      _expButton("Weniger anzeigen"),
                    ],
                  ),
                ),
              )
            : Container(),
      ],
    );
  }

  Map<String, String> getInformation(Stop s) {
    Map<String, String> map = {
      "Inv.nummer": s.id,
      "Abteilung": s.division,
      "Kategorie": s.artType,
      "Ersteller": s.creator,
      "Zeitraum": s.time,
      "Material": s.material,
      "Größe": s.size,
      "Ort": s.location,
      "Kontext": s.interContext
    };
    map.removeWhere((key, val) => val == null || (val is String && val.trim() == ""));

    return map;
  }

  Widget _informationTable(Stop s) {
    var info = getInformation(s);
    if (info.isEmpty) return Container();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 10, bottom: 5),
          child: Text(
            "Weitere Informationen",
            style: TextStyle(fontSize: 22, color: widget.color),
          ),
        ),
        Container(
          //margin: EdgeInsets.only(right: 23),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              border: Border.all(color: Colors.black),
              boxShadow: [BoxShadow(offset: Offset.fromDirection(pi / 4))]),
          child: Table(
            columnWidths: {
              0: FixedColumnWidth(horSize(33, 25)),
              //1: FixedColumnWidth(horSize(58, 62))
            },
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            border:
                TableBorder.symmetric(inside: BorderSide(color: Colors.black)),
            children: List.generate(
              info.length,
              (index) => TableRow(
                children: [
                  Container(
                    //padding: EdgeInsets.all(3),
                    child: Text(
                      info.keys.elementAt(index),
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    child: Text(
                      info[info.keys.elementAt(index)],
                      style:
                          TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _extras(List<ActualExtra> extras) {
    List<ActualExtra> tasks = extras?.where((e) => e.task != null).toList();
    String id = widget.stop.stop.id;

    var base = List<Widget>();

    if (!widget.stop.isCustom())
      base.add(Container(
          width: horSize(100, 100),
          alignment: Alignment.centerRight,
          child: FutureBuilder(
            future: MuseumDatabase().isFavStop(id),
            builder: (context, snap) {
              bool fav = snap.data ?? false;
              return FlatButton(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Objekt favorisieren "),
                    Icon(fav ? Icons.favorite : Icons.favorite_border),
                  ],
                ),
                onPressed: () async {
                  if (fav)
                    await MuseumDatabase().removeFavStop(id);
                  else
                    await MuseumDatabase().addFavStop(id);
                  setState(() {});
                  },
              );
            },
          )));

    base += (extras?.map((t) => TourExtra(tasks.indexOf(t) + 1, t)))?.toList();

    return Container(
      margin: EdgeInsets.only(top: 13),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: base,
      ),
    );
  }
}
