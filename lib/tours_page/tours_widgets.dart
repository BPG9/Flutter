import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:museum_app/SizeConfig.dart';
import 'package:museum_app/constants.dart';
import 'package:museum_app/database/modelling.dart';
import 'package:museum_app/database/moor_db.dart';
import 'package:museum_app/server_connection/graphqlConf.dart';
import 'package:museum_app/server_connection/graphql_nodes.dart';
import 'package:museum_app/server_connection/http_query.dart';
import 'package:museum_app/tours_page/walk_tour/walk_tour.dart';

import '../util.dart';

Widget _pictureLeft(ActualStop stop, Size s, {margin = EdgeInsets.zero}) {
  String path = stop.stop != null && stop.stop.images.isNotEmpty
      ? stop.stop.images[0]
      : "";
  return Container(
    margin: margin,
    width: SizeConfig.safeBlockHorizontal * s.width,
    height: SizeConfig.safeBlockVertical * s.height,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      border: Border.all(color: Colors.black),
      image: DecorationImage(
          image: AssetImage("assets/images/haupthalle_hlm_blue.png"),
          fit: BoxFit.cover),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      child: path != ""
          ? HttpQuery.networkImageWidget(
              HttpQuery.imageURLPicture(path),
            )
          : Container(),
    ),
  );
}

enum PanelType { NONE, DOWNLOAD, SHOW, DELETE }

/// A single Panel containing infos about a tour
class _TourPanel extends StatelessWidget {
  final TourWithStops _tour;
  final Color _color;
  final PanelType type;
  final PanelType secondType;
  final bool showAuthor;
  final bool showID;

  const _TourPanel(this._tour, this._color,
      {this.type = PanelType.SHOW,
      this.secondType = PanelType.NONE,
      Key key,
      this.showAuthor = true,
      this.showID = true})
      : super(key: key);

  Widget _textBox(String text,
      {width,
      height,
      fontStyle = FontStyle.normal,
      fontWeight = FontWeight.normal,
      textAlign = TextAlign.left,
      textColor = Colors.black,
      int maxLines = 2,
      Alignment alignment = Alignment.bottomLeft,
      margin = const EdgeInsets.all(0),
      double fontSize = 15.0}) {
    return Container(
      margin: margin,
      width: width,
      //SizeConfig.safeBlockHorizontal * s.width,
      height: height,
      //SizeConfig.safeBlockVertical * s.height,
      alignment: alignment,
      child: Text(
        text,
        textAlign: textAlign,
        style: TextStyle(
          color: textColor,
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontStyle: fontStyle,
        ),
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  void _showTour(context) {
    showGeneralDialog(
      barrierColor: Colors.grey.withOpacity(0.7),
      barrierDismissible: true,
      barrierLabel: '',
      transitionDuration: Duration(milliseconds: 270),
      context: context,
      transitionBuilder: (context, a1, a2, widget) => Transform.scale(
        scale: a1.value,
        child: Opacity(
          opacity: a1.value,
          child: _TourPopUp(_tour),
        ),
      ),
      pageBuilder: (context, animation1, animation2) {},
    );
  }

  void _download(context) async {
    String s;
    if (await MuseumDatabase().idExists(_tour.onlineId))
      s = "Tour bereits heruntergeladen!";
    else if (await MuseumDatabase()
        .joinAndDownloadTour(_tour.onlineId, searchId: false))
      s = "Tour heruntergeladen!";
    else
      s = "Tour konnte nicht heruntergeladen werden...";
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(s)));
  }

  Widget _infoRight(context) {
    return Expanded(
      //width: horSize(50, 55),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _textBox(
            _tour.name.text,
            //s: Size(size(90, 80), size(6.5, 11)),
            margin: EdgeInsets.only(bottom: 3),
            fontSize: 20,
            fontWeight: FontWeight.bold,
            maxLines: 2,
          ),
          showAuthor
              ? Text(
                  "von " + _tour.author,
                  maxLines: 1,
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: size(14, 15),
                  ),
                )
              : Container(),
          Container(
            height: verSize(4, 5),
            child: Row(
              children: [
                _tour.getRating(
                    color: _color, color2: Colors.grey, size: horSize(5, 3.5)),
                //Container(width: horSize(1, 3)),
                _tour.buildTime(color: _color),
              ],
            ),
          ),
          _textBox(
            _tour.descr.text,
            width: horSize(50, 80),
            height: verSize(8.5, 18),
            textAlign: TextAlign.justify,
            fontSize: size(13, 15),
            maxLines: 4,
            alignment: Alignment.topLeft,
          ),
          (showID && _tour.searchId != null && _tour.searchId != ""
              ? SelectableText(
                  "Such-ID: " + _tour.searchId,
                  style: TextStyle(fontStyle: FontStyle.italic),
                )
              : Container()),
          ButtonBar(
            buttonMinWidth: secondType != PanelType.NONE
                ? horSize(21.5, 10)
                : horSize(30, 30),
            mainAxisSize: MainAxisSize.max,
            //buttonPadding: EdgeInsets.only(right: horSize(10, 10)),
            alignment: secondType != PanelType.NONE
                ? MainAxisAlignment.start
                : MainAxisAlignment.center,
            children: [
              _oneButton(type, context),
              //Container(width: 5),
              _oneButton(secondType, context),
            ],
          ),
        ],
      ),
    );
  }

  Widget _oneButton(PanelType lType, context) {
    switch (lType) {
      case PanelType.SHOW:
        return FlatButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          color: _color,
          child: Text("Anzeigen",
              style: TextStyle(fontSize: size(14, 17), color: Colors.white)),
          onPressed: () => _showTour(context),
        );
      case PanelType.DOWNLOAD:
        return FlatButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          color: _color,
          child: Text("Download",
              style: TextStyle(fontSize: size(14, 17), color: Colors.white)),
          onPressed: () => _download(context),
        );
      case PanelType.DELETE:
        return FlatButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          color: _color,
          child: Text("Löschen",
              style: TextStyle(fontSize: size(14, 17), color: Colors.white)),
          onPressed: () async {
            showDialog(
                context: context,
                builder: (c) => _deleteTour(_tour.onlineId, context));
            //Scaffold.of(context).showSnackBar(SnackBar(content: Text("Not yet implemented")));
            //print("Not yet implemented");
          },
        );
      default:
        return Container();
    }
  }

  Widget _deleteTour(String onlineID, context) {
    return AlertDialog(
      title: Text("WARNUNG"),
      content: Text(
          "Das Löschen von einer Tour kann NICHT rückgängig gemacht werden. "
          "Die Tour kann anschließend nicht mehr heruntergeladen oder abgelaufen werden.\n"
          "Bitte sei Dir absolut sicher, bevor du fortfährst."),
      actions: [
        FlatButton(
          child: Text("Zurück", style: TextStyle(color: COLOR_PROFILE)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        FlatButton(
          child: Text("Tour löschen", style: TextStyle(color: COLOR_PROFILE)),
          onPressed: () async {
            String s = await MuseumDatabase().deleteTour(onlineID)
                ? "Tour gelöscht. Lade die Liste ggf. neu."
                : "Die Tour konnte nicht gelöscht werden.";

            Scaffold.of(context).showSnackBar(SnackBar(content: Text(s)));

            Navigator.pop(context);
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return border(
      Row(
        //crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _pictureLeft(
            _tour.stops[0], Size(horSize(8.5, 8.5), size(29, 57)),
            //Size(30, size(29, 57))
            margin: EdgeInsets.only(right: 10),
          ),
          _infoRight(context),
        ],
      ),
      margin: EdgeInsets.only(left: 16, right: 16, bottom: 16),
      borderColor: _color,
    );
  }
}

/// The Popup after clicking "Anzeigen"
class _TourPopUp extends StatefulWidget {
  final TourWithStops tour;

  _TourPopUp(this.tour, {Key key}) : super(key: key);

  @override
  _TourPopUpState createState() => _TourPopUpState();
}

class _TourPopUpState extends State<_TourPopUp> {
  @override
  Widget build(BuildContext context) {
    var t = widget.tour;
    return SimpleDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      backgroundColor: COLOR_TOUR,
      contentPadding: EdgeInsets.all(16),
      children: [
        // Picture
        _pictureLeft(
          t.stops[0],
          Size(85, size(30, 55)),
          margin: EdgeInsets.only(bottom: 16),
        ),
        // Titel
        Text(
          t.name.text,
          maxLines: 2,
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        // Autor
        Text(
          "von " + t.author,
          maxLines: 1,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontStyle: FontStyle.italic,
          ),
        ),
        // Stars
        Container(
            margin: EdgeInsets.symmetric(vertical: 3.5),
            child: Row(children: [
              t.getRating(
                  color: Colors.white,
                  color2: COLOR_TOUR,
                  size: horSize(7, 3.5)),
              Container(width: 8),
              t.buildTime(
                  color: Colors.white, color2: Colors.white, scale: 1.2),
            ])),
        // Description
        Text(
          t.descr.text,
          textAlign: TextAlign.justify,
          maxLines: 5,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
        // Buttons
        ButtonBar(
          alignment: MainAxisAlignment.center,
          buttonPadding: EdgeInsets.all(12),
          //buttonHeight: SizeConfig.safeBlockVertical * 12,
          children: [
            FlatButton(
                splashColor: COLOR_TOUR.shade100,
                color: Colors.white,
                shape: CircleBorder(side: BorderSide(color: Colors.black)),
                child: Icon(
                  FontAwesomeIcons.trash,
                  color: Colors.black,
                  size: 30,
                ),
                onPressed: () {
                  if (t.id != null)
                    showDialog(context: context, builder: _popUp);
                }),
            FlatButton(
              padding: EdgeInsets.all(8),
              splashColor: COLOR_TOUR.shade100,
              color: Colors.white,
              shape: CircleBorder(side: BorderSide(color: Colors.black)),
              child: Icon(
                Icons.play_arrow,
                color: Colors.black,
                size: 46,
              ),
              onPressed: () async {
                print("KURZ_SYNC");
                await t.syncTasks();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TourWalker(tour: t)));
              },
              onLongPress: () {
                print("LANG_RESET");
                t.resetTasks();

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TourWalker(tour: t)));
              },
            ),
            FutureBuilder(
              future: MuseumDatabase().usersDao.isFavTour(t.onlineId),
              builder: (context, snap) {
                bool fav = snap.data ?? false;
                return FlatButton(
                  splashColor: COLOR_TOUR.shade100,
                  color: Colors.white,
                  shape: CircleBorder(side: BorderSide(color: Colors.black)),
                  child: Icon(
                    fav ? Icons.favorite : Icons.favorite_border,
                    color: Colors.black,
                    size: 31,
                  ),
                  onPressed: () async {
                    if (fav)
                      await MuseumDatabase().usersDao.removeFavTour(t.onlineId);
                    else
                      await MuseumDatabase().usersDao.addFavTour(t.onlineId);
                    setState(() {});
                  },
                );
              },
            ),
            /*FlatButton(
              splashColor: COLOR_TOUR.shade100,
              color: Colors.white,
              shape: CircleBorder(side: BorderSide(color: Colors.black)),
              child: Icon(
                Icons.favorite,
                color: Colors.black,
                size: 31,
              ),
              onPressed: () {},
            ),*/
          ],
        ),
      ],
    );
  }

  Widget _popUp(context) {
    return AlertDialog(
      title: Text("Warnung"),
      content: Text("Die ausgewählte Tour wirklich entfernen?\n"
          "Dies kann nicht rückgängig gemacht werden."),
      actions: [
        FlatButton(
          child: Text("Abbrechen", style: TextStyle(color: COLOR_TOUR)),
          onPressed: () => Navigator.pop(context),
        ),
        FlatButton(
          child: Text("Tour entfernen", style: TextStyle(color: COLOR_TOUR)),
          onPressed: () => setState(() {
            MuseumDatabase().removeTour(widget.tour.id);
            Navigator.pop(context);
            Navigator.pop(context);
          }),
        ),
      ],
    );
  }
}

class TourList extends StatefulWidget {
  final List<TourWithStops> tours;

  TourList.fromList(this.tours, {Key key}) : super(key: key);

  TourList.downloaded() : tours = null;

  @override
  _TourListState createState() => _TourListState();
}

class _TourListState extends State<TourList> {
  Widget _toursFromList(List<TourWithStops> list) {
    if (widget.tours == null && list.isEmpty)
      return Center(child: Text("Es wurde keine Tour heruntergeladen."));
    return Column(
      children: list.map((t) => _TourPanel(t, COLOR_TOUR)).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    if (widget.tours != null) return _toursFromList(widget.tours);

    return StreamBuilder(
      stream: MuseumDatabase().getTourStops(),
      builder: (context, snap) {
        List<TourWithStops> tours = snap.data ?? List<TourWithStops>();
        return _toursFromList(tours);
      },
    );
  }
}

class DownloadColumn extends StatefulWidget {
  final Function query;
  final Color color;
  final String search;
  final String notFoundText;
  final bool showSearchId;
  final bool deleteTour;

  DownloadColumn(this.query,
      {Key key,
      this.showSearchId = false,
      this.color = COLOR_PROFILE,
      this.search = "",
      this.notFoundText = "\n\nEs konnten keine Touren gefunden werden.",
      this.deleteTour = false})
      : super(key: key);

  @override
  _DownloadColumnState createState() => _DownloadColumnState();
}

class _DownloadColumnState extends State<DownloadColumn> {
  List<TourWithStops> _list = List<TourWithStops>();
  bool _loading = false;
  Future fut;

  @override
  void initState() {
    super.initState();
    fut = initList();
  }

  @override
  void dispose() {
    fut.timeout(Duration(seconds: 0), onTimeout: () => Future.value(true));
    super.dispose();
  }

  initList() async {
    //String token = await MuseumDatabase().accessToken();
    //if (!await GraphQLConfiguration.isConnected(token))
    //  token = await MuseumDatabase().refreshAccess();
    String token = await MuseumDatabase().usersDao.checkRefresh();

    if (token == null || token == "") return;
    GraphQLClient _client = GraphQLConfiguration().clientToQuery();
    QueryResult result = await _client.query(QueryOptions(
      documentNode: gql(widget.query(token)),
      //onError: (e) => print("ERROR_auth: " + e.toString()),
    ));
    if (result.hasException)
      print("EXC_downColumn: " + result.exception.toString());
    if (result.loading || result.data == null) return;
    _loading = result.loading;
    _list.clear();
    var d = result.data;

    List<Stop> allStops = await MuseumDatabase().getStops();

    for (var m in d[d.keys.first] ?? []) {
      Tour t = Tour(
          onlineId: m["id"],
          searchId: widget.showSearchId ? m["searchId"] : null,
          name: m["name"],
          author: m["owner"]["username"],
          difficulty: m["difficulty"].toDouble(),
          desc: m["description"],
          lastEdit: DateTime.parse(m["lastEdit"]));

      // Add the first used Stop (for its image)
      QueryResult stopResult = await _client.query(QueryOptions(
        documentNode: gql(QueryBackend.checkpointTour(token, m["id"])),
      ));
      if (result.hasException)
        print("EXC_downColumnStop: ${result.exception.toString()}");

      Stop s;
      List<dynamic> checkpoints = stopResult.data["checkpointsTour"];
      if (checkpoints.isEmpty) {
        _client.query(QueryOptions(
          documentNode: gql(MutationBackend.joinTour(token, m["id"])),
        ));
        s = await MuseumDatabase().getCustomStop();
      }
      else {
        var firstStop = checkpoints.where((s) => s["index"] == 1).toList()[0];

        s = allStops
            .firstWhere((e) => e.id == firstStop["museumObject"]["objectId"]);
        //await MuseumDatabase().getStop(firstStop["museumObject"]["objectId"]);
        if (s == null) s = await MuseumDatabase().getCustomStop();
      }

      _list.add(
          TourWithStops(t, <ActualStop>[ActualStop(s, StopFeature(), [])]));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    //for (var t in _list) print(t.name.text);
    List<Widget> children = _list
        .where((t) {
          String srch = widget.search.toLowerCase();
          String title = t.name.text.toLowerCase();
          //title = title.substring(0, min(title.length, srch.length));
          return title.contains(srch);
        })
        .map((t) => _TourPanel(
              t,
              widget.color,
              type: PanelType.DOWNLOAD,
              secondType: widget.deleteTour ? PanelType.DELETE : PanelType.NONE,
              showID: widget.showSearchId,
            ))
        .toList();
    if (_loading) {
      _loading = false;
      return Padding(
        padding: EdgeInsets.only(top: 16),
        child: CircularProgressIndicator(),
      );
    }
    if (_list.isEmpty)
      children = [Text(widget.notFoundText, style: TextStyle(fontSize: 16))];
    return Column(
      children: children,
    );
  }
}
