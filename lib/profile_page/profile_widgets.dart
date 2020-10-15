import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:museum_app/SizeConfig.dart';
import 'package:museum_app/constants.dart';
import 'package:museum_app/database/moor_db.dart';
import 'package:museum_app/server_connection/graphql_nodes.dart';
import 'package:museum_app/server_connection/http_query.dart';
import 'package:museum_app/tours_page/tours_widgets.dart';
import 'package:museum_app/tours_page/walk_tour/walk_tour_content.dart';

class FavWidget extends StatefulWidget {
  FavWidget({Key key}) : super(key: key);

  @override
  _FavWidgetState createState() => _FavWidgetState();
}

class _FavWidgetState extends State<FavWidget> {
  /// Creates a widget showing [stops] of a certain [division].
  ///
  /// Whether the stops really are part of the division is not checked.
  Widget _buildDivision(Division division, List<Stop> stops) {
    if (stops.isEmpty) return Container();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Headline
        Container(
          padding: EdgeInsets.only(left: 20),
          child: Text(
            division.name,
            style: TextStyle(
              color: division.color,
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
        ),
        // Horizontal Scrollable
        Container(
          padding: EdgeInsets.only(bottom: 20.0, top: 2.0),
          height: verSize(21, 40),
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: stops.length,
              // One "bubble"
              itemBuilder: (context, index) {
                //TODO possible multiple new token creation
                return FutureBuilder(
                  future: HttpQuery.networkImage(
                      HttpQuery.imageURLPicture(stops[index].images.first)),
                  builder: (context, snap) {
                    ImageProvider image;
                    image = snap?.data;
                    image ??=
                        Image.asset("assets/images/empty_profile.png").image;

                    return avatarWithBorder(
                      image,
                      horSize(13.5, 8),
                      borderWidth: 3,
                      borderColor: division.color,
                      padding: EdgeInsets.only(left: 13.0),
                      child: FlatButton(
                        onPressed: () => _showStop(stops[index]),
                        splashColor: division.color.withOpacity(.4),
                        highlightColor: division.color.withOpacity(.2),
                        child: Container(),
                      ),
                    );
                  },
                );
              }),
        ),
      ],
    );
  }

  Widget avatarWithBorder(ImageProvider image, double radius,
      {double borderWidth = 0,
      Color borderColor = Colors.black,
      Widget child,
      EdgeInsetsGeometry padding = EdgeInsets.zero}) {
    return Padding(
      padding: padding,
      child: CircleAvatar(
        radius: radius,
        backgroundColor: borderColor,
        child: CircleAvatar(
          radius: radius - borderWidth,
          backgroundImage: image,
          backgroundColor: Colors.white,
          child: ClipOval(
            child: child,
          ),
        ),
      ),
    );
  }

  /// Shows a dialog for a certain [stop].
  ///
  /// Displays the stop's tour-independent information.
  void _showStop(Stop s) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        contentPadding: EdgeInsets.only(bottom: 2),
        content: Container(
          height: verSize(90, 90),
          width: horSize(100, 100),
          child: SingleChildScrollView(child: TourWalkerContent.fromStop(s)),
        ),
        actions: [
          FlatButton(
            child: Text("Schließen", style: TextStyle(color: COLOR_PROFILE)),
            onPressed: () => Navigator.pop(context),
          ),
        ],
        /*Container(
          width: SizeConfig.safeBlockHorizontal * 70,
          height: SizeConfig.safeBlockHorizontal * 70,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(s.images[0]),
              fit: BoxFit.fill,
            ),
          ),
        ),*/
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return StreamBuilder(
      stream: MuseumDatabase().watchDivisions(),
      builder: (context, snapDev) {
        var divisions = snapDev.data ?? List<Division>();
        return FutureBuilder(
          future: MuseumDatabase().usersDao.getFavStops(),
          builder: (context, snapStop) {
            var stops = snapStop.data ?? List<Stop>();
            // show every division with it's stops

            var favStops = List.generate(
              divisions.length,
              (index) => _buildDivision(
                  divisions[index],
                  stops
                      .where((e) => e.division == divisions[index].name)
                      .toList()),
            );
            if (!snapStop.hasData)
              favStops.add(CircularProgressIndicator());
            else if (stops.isEmpty)
              favStops.add(Text("Keine Objekte favorisiert!\n",
                  style: TextStyle(fontSize: 16)));

            return Column(
              children: <Widget>[
                    Text(
                      "Lieblingsobjekte\n",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    )
                  ] +
                  favStops +
                  [
                    Text(
                      "Lieblingstouren\n",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    DownloadColumn(
                      QueryBackend.favTours,
                      notFoundText: "Keine Touren favorisiert.",
                      showSearchId: true,
                    ),
                  ],
            );
          },
        );
      },
    );
  }
}

class BadgeWidget extends StatefulWidget {
  BadgeWidget({Key key}) : super(key: key);

  @override
  _BadgeState createState() => _BadgeState();
}

class _BadgeState extends State<BadgeWidget> {
  List<bool> popUps = List<bool>();

  List buildWidgets(List<Badge> badges) {
    if (badges == null || badges.length == 0)
      return <Widget>[Text("Keine Erfolge vorhanden")];
    return badges.map((b) {
      double perc = b.current * 100 / b.toGet;
      int i = badges.indexOf(b);
      if (popUps.length != badges.length) popUps.add(false);
      return Container(
        width: horSize(30, 10),
        child: GestureDetector(
          onTap: () => setState(() => popUps[i] = !popUps[i]),
          child: Stack(
            children: [
              Positioned(
                top: horSize(30, 10) / 2 - horSize(20, 40) / 2,
                left: horSize(30, 10) / 2 - horSize(20, 40) / 2,
                child: CircleAvatar(
                  radius: horSize(20, 40) / 2,
                  child: HttpQuery.networkImageWidget(
                    HttpQuery.imageURLBadge(b.id),
                    fit: BoxFit.fill,
                    width: 2000,
                    height: 2000,
                  ),
                  backgroundColor: Colors.white,
                ),
              ),
              AnimatedCircularChart(
                chartType: CircularChartType.Radial,
                size: Size(horSize(30, 10), horSize(30, 10)),
                initialChartData: [
                  CircularStackEntry(
                    [
                      CircularSegmentEntry(perc, b.color),
                      CircularSegmentEntry(100 - perc, Colors.blueGrey[100]),
                    ],
                  ),
                ],
                percentageValues: true,
              ),
              popUps[i]
                  ? Positioned(
                      left: horSize(1, 1),
                      top: horSize(30, 10) / 2 - horSize(32, 40) / 4,
                      child: Container(
                        height: horSize(32, 40) / 2,
                        width: horSize(30, 10) - horSize(2, 2),
                        decoration: BoxDecoration(
                          color: b.color,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(5),
                        child: Text(
                          "${b.name}\n"
                          "${b.current.toInt()}/${b.toGet.toInt()}",
                          maxLines: 3,
                          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: MuseumDatabase().badgesDao.watchBadges(),
      builder: (context, snap) {
        // if (snap.hasError || !snap.hasData) return Text("Fehler");
        return Wrap(children: buildWidgets(snap?.data));
      },
    );
  }
}

@deprecated
class _BadgeWidgetState extends State<BadgeWidget> {
  final _perLine;

  _BadgeWidgetState(this._perLine);

  Widget _getGrid(List<Widget> content) {
    int rowC = (content.length / _perLine).ceil();
    List<Widget> rows = List<Widget>(rowC);
    for (int i = 0; i < rowC; i++) {
      var sub = content.sublist(
          i * _perLine, min(i * _perLine + _perLine, content.length));
      while (sub.length < _perLine) sub.add(Expanded(child: Container()));
      rows[i] = Row(children: sub);
    }
    return Column(children: rows);
  }

  /// comlP represents percentages in the form "42.42" for "42.42%"
  Widget _buildBadge(Badge b) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(2.0),
        height: verSize(51, 130) / _perLine,
        child: _getBadge(b, false),
      ),
    );
  }

  void _badgePopUp(Badge b) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(b.name),
            contentPadding: EdgeInsets.only(bottom: 10),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _getBadge(b, true),
                Text(b.current.toString() + " / " + b.toGet.toString()),
              ],
            ),
          );
        });
  }

  Widget _getBadge(Badge b, popUp) {
    final key = GlobalKey<AnimatedCircularChartState>();
    final key2 = GlobalKey<AnimatedCircularChartState>();
    var perc = max(min(b.current / b.toGet * 100, 100), 0);
    return Stack(
      alignment: Alignment.center,
      children: [
        // Progress circle
        AnimatedCircularChart(
          key: popUp ? key2 : key,
          size: Size.square(verSize(46, 135) * (popUp ? 1.3 : 1) / _perLine),
          initialChartData: [
            CircularStackEntry(
              [
                CircularSegmentEntry(perc, b.color),
                CircularSegmentEntry(100 - perc, Colors.blueGrey[100]),
              ],
            ),
          ],
          percentageValues: true,
        ),
        // Picture/Badge
        Container(
          width: horSize(64, 50) * (popUp ? 1.3 : 1) / _perLine,
          height: horSize(64, 50) * (popUp ? 1.3 : 1) / _perLine,
          decoration: BoxDecoration(shape: BoxShape.circle),
          child: FlatButton(
            padding: EdgeInsets.zero,
            splashColor: b.color.withOpacity(.1),
            highlightColor: b.color.withOpacity(.05),
            onPressed: () => _badgePopUp(b),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(80.0),
            ),
            child: HttpQuery.networkImageWidget(
              HttpQuery.imageURLBadge(b.id),
              fit: BoxFit.fill,
              width: horSize(63, 50) * (popUp ? 1.3 : 1) / _perLine,
              height: horSize(63, 50) * (popUp ? 1.3 : 1) / _perLine,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: MuseumDatabase().badgesDao.watchBadges(),
        builder: (context, snapBad) {
          List<Badge> badges = snapBad.data ?? List<Badge>();
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.center,
            child: _getGrid(badges.map((b) => _buildBadge(b)).toList()),
          );
        });
  }
}
