import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:museum_app/SizeConfig.dart';
import 'package:museum_app/database/moor_db.dart';

import 'onboarding_data.dart';
import 'page_indicator.dart';

class Onboarding extends StatefulWidget {
  Onboarding({Key key})
      : super(
            key:
                key); //necessary? this will be by statefulbldr snippet created.

  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> with TickerProviderStateMixin {
  PageController _controller;
  int currentPage = 0;
  bool lastPage = false;
  AnimationController animationController;
  Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = PageController(
      initialPage: currentPage,
    );
    animationController =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this);
    _scaleAnimation = Tween(begin: 0.6, end: 1.0).animate(animationController);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [Color(0xFFE6E6E6), Color(0xFFFFFFFF)],
            tileMode: TileMode.clamp,
            begin: Alignment.topCenter,
            stops: [0.0, 1.0],
            end: Alignment.bottomCenter),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: new Stack(
          fit: StackFit.expand,
          children: <Widget>[
            PageView.builder(
              itemCount: pageList.length,
              controller: _controller,
              onPageChanged: (index) {
                setState(() {
                  currentPage = index;
                  if (currentPage == pageList.length - 1) {
                    lastPage = true;
                    animationController.forward();
                  } else {
                    lastPage = false;
                    animationController.reset();
                  }
                  print(lastPage);
                });
              },
              itemBuilder: (context, index) {
                return AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    var page = pageList[index];
                    var delta;
                    var y = 1.0;
                    if (_controller.position.haveDimensions) {
                      delta = _controller.page - index;
                      y = 1 - delta.abs().clamp(0.0, 1.0);
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                            margin: EdgeInsets.only(
                                left: 16.0, right: 16.0, top: 10),
                            alignment: Alignment.center,
                            child: SafeArea(
                                bottom: false,
                                child: Image.asset(
                                  page.imageUrl,
                                  width: horSize(80, 30),
                                  height: verSize(35, 20),
                                ))),
                        Container(
                          margin: EdgeInsets.only(left: 16.0, right: 16.0),
                          alignment: Alignment.center,
                          height: SizeConfig.safeBlockVertical * 10,
                          width: SizeConfig.safeBlockHorizontal * 100,
                          child: Container(
                            //padding: EdgeInsets.all(1.0),
                            //margin: EdgeInsets.only(left:16.0, right:16.0, top:5.0),
                            alignment: Alignment.center,
                            child: GradientText(
                              page.title,
                              gradient: LinearGradient(
                                  colors: pageList[index].titleGradient),
                              style: TextStyle(
                                fontSize: horSize(8, 4),
                                fontFamily: "Nunito",
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 16.0, right: 16.0, top: 30),
                          alignment: Alignment.center,
                          child: Transform(
                              transform: Matrix4.translationValues(
                                  0, 50.0 * (1 - y), 0),
                              child: Text(
                                page.body,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: SizeConfig.orientationDevice ==
                                            Orientation.portrait
                                        ? SizeConfig.safeBlockHorizontal * 6
                                        : SizeConfig.safeBlockHorizontal * 3,
                                    fontFamily: "Nunito",
                                    fontWeight: FontWeight.w300,
                                    fontStyle: FontStyle.italic,
                                    color: Color(0xFF1A1A1A)),
                              )),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 16.0, right: 16.0, top: 10),
                          alignment: Alignment.center,
                          child: (page.number == 1)
                              ? Transform(
                                  transform: Matrix4.translationValues(
                                      0, 50.0 * (1 - y), 0),
                                  child: Text(
                                    "Teil des Projekts MINTplus²: Systematischer und vernetzter Kompetenzaufbau in der Lehrerbildung im Umgang mit Digitalisierung und Heterogenität",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: horSize(4, 2),
                                        fontFamily: "Nunito",
                                        fontWeight: FontWeight.w300,
                                        fontStyle: FontStyle.italic,
                                        color: Color(0xFF1A1A1A)),
                                  ))
                              : (page.number == 2)
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        left: 16.0,
                                                        right: 5.0,
                                                        top: 10),
                                                    alignment: Alignment.center,
                                                    child: SafeArea(
                                                      bottom: false,
                                                      child: Icon(
                                                        Icons.check_box,
                                                        color: Colors.red,
                                                      ),
                                                    )),
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        right: 16.0, top: 10),
                                                    alignment: Alignment.center,
                                                    child: SafeArea(
                                                        bottom: false,
                                                        child: Text(
                                                          "Landesmuseum kennenlernen",
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                              fontSize: SizeConfig
                                                                          .orientationDevice ==
                                                                      Orientation
                                                                          .portrait
                                                                  ? SizeConfig.safeBlockHorizontal *
                                                                      5
                                                                  : SizeConfig.safeBlockHorizontal *
                                                                      2,
                                                              fontFamily:
                                                                  "Nunito",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .italic,
                                                              color: Color(
                                                                  0xFF1A1A1A)),
                                                        )))
                                              ]),
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        left: 16.0, right: 5.0),
                                                    alignment: Alignment.center,
                                                    child: SafeArea(
                                                      bottom: false,
                                                      child: Icon(
                                                        Icons.check_box,
                                                        color: Colors.red,
                                                      ),
                                                    )),
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        right: 16.0),
                                                    alignment: Alignment.center,
                                                    child: SafeArea(
                                                        bottom: false,
                                                        child: Text(
                                                          "Rundgänge anlegen und gehen",
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                              fontSize: SizeConfig
                                                                          .orientationDevice ==
                                                                      Orientation
                                                                          .portrait
                                                                  ? SizeConfig.safeBlockHorizontal *
                                                                      5
                                                                  : SizeConfig.safeBlockHorizontal *
                                                                      2,
                                                              fontFamily:
                                                                  "Nunito",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .italic,
                                                              color: Color(
                                                                  0xFF1A1A1A)),
                                                        )))
                                              ]),
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        left: 16.0, right: 5.0),
                                                    alignment: Alignment.center,
                                                    child: SafeArea(
                                                      bottom: false,
                                                      child: Icon(
                                                        Icons.check_box,
                                                        color: Colors.red,
                                                      ),
                                                    )),
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        right: 16.0),
                                                    alignment: Alignment.center,
                                                    child: SafeArea(
                                                        bottom: false,
                                                        child: Text(
                                                          "Museumsobjekte untersuchen",
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                              fontSize: SizeConfig
                                                                          .orientationDevice ==
                                                                      Orientation
                                                                          .portrait
                                                                  ? SizeConfig.safeBlockHorizontal *
                                                                      5
                                                                  : SizeConfig.safeBlockHorizontal *
                                                                      2,
                                                              fontFamily:
                                                                  "Nunito",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .italic,
                                                              color: Color(
                                                                  0xFF1A1A1A)),
                                                        )))
                                              ]),
                                        ])
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        left: 16.0,
                                                        right: 5.0,
                                                        top: 10),
                                                    alignment: Alignment.center,
                                                    child: SafeArea(
                                                      bottom: false,
                                                      child: Icon(
                                                        Icons.check_box,
                                                        color: Colors.red,
                                                      ),
                                                    )),
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        right: 16.0, top: 10),
                                                    alignment: Alignment.center,
                                                    child: SafeArea(
                                                        bottom: false,
                                                        child: Text(
                                                          "Account verwalten",
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                              fontSize: SizeConfig
                                                                          .orientationDevice ==
                                                                      Orientation
                                                                          .portrait
                                                                  ? SizeConfig.safeBlockHorizontal *
                                                                      5
                                                                  : SizeConfig.safeBlockHorizontal *
                                                                      2,
                                                              fontFamily:
                                                                  "Nunito",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .italic,
                                                              color: Color(
                                                                  0xFF1A1A1A)),
                                                        )))
                                              ]),
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        left: 16.0, right: 5.0),
                                                    alignment: Alignment.center,
                                                    child: SafeArea(
                                                      bottom: false,
                                                      child: Icon(
                                                        Icons.check_box,
                                                        color: Colors.red,
                                                      ),
                                                    )),
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        right: 16.0),
                                                    alignment: Alignment.center,
                                                    child: SafeArea(
                                                        bottom: false,
                                                        child: Text(
                                                          "Favoriten sammeln",
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                              fontSize: SizeConfig
                                                                          .orientationDevice ==
                                                                      Orientation
                                                                          .portrait
                                                                  ? SizeConfig.safeBlockHorizontal *
                                                                      5
                                                                  : SizeConfig.safeBlockHorizontal *
                                                                      2,
                                                              fontFamily:
                                                                  "Nunito",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .italic,
                                                              color: Color(
                                                                  0xFF1A1A1A)),
                                                        )))
                                              ]),
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        left: 16.0, right: 5.0),
                                                    alignment: Alignment.center,
                                                    child: SafeArea(
                                                      bottom: false,
                                                      child: Icon(
                                                        Icons.check_box,
                                                        color: Colors.red,
                                                      ),
                                                    )),
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        right: 16.0),
                                                    alignment: Alignment.center,
                                                    child: SafeArea(
                                                        bottom: false,
                                                        child: Text(
                                                          "Statistiken abrufen",
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                              fontSize: SizeConfig
                                                                          .orientationDevice ==
                                                                      Orientation
                                                                          .portrait
                                                                  ? SizeConfig.safeBlockHorizontal *
                                                                      5
                                                                  : SizeConfig.safeBlockHorizontal *
                                                                      2,
                                                              fontFamily:
                                                                  "Nunito",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .italic,
                                                              color: Color(
                                                                  0xFF1A1A1A)),
                                                        )))
                                              ]),
                                        ]),
                        ),
                        Container(
                          child: (page.number == 1)
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                        margin: EdgeInsets.only(
                                            left: 16.0, right: 16.0),
                                        alignment: Alignment.center,
                                        child: SafeArea(
                                          bottom: false,
                                          child: Image.asset(
                                              'assets/images/photo_2020-01-19.jpeg',
                                              width: horSize(22, 30),
                                              height: verSize(15, 10)),
                                        )),
                                    Container(
                                        margin: EdgeInsets.only(
                                            left: 16.0, right: 16.0),
                                        alignment: Alignment.center,
                                        child: SafeArea(
                                          bottom: false,
                                          child: Image.asset(
                                              'assets/images/Logo_MINTplus_182x0.jpg',
                                              width: horSize(22, 30),
                                              height: verSize(15, 20)),
                                        )),
                                    Container(
                                        margin: EdgeInsets.only(
                                            left: 16.0, right: 16.0),
                                        alignment: Alignment.center,
                                        child: SafeArea(
                                          bottom: false,
                                          child: Image.asset(
                                              'assets/images/serveimage.png',
                                              width: horSize(22, 30),
                                              height: verSize(15, 20)),
                                        )),
                                  ],
                                )
                              : Container(),
                        )
                      ],
                    );
                  },
                );
              },
            ),
            Positioned(
              left: 20.0,
              bottom: 25.0,
              child: Container(
                  width: 160.0,
                  child: PageIndicator(currentPage, pageList.length)),
            ),
            Positioned(
              right: 30.0,
              bottom: 30.0,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: lastPage
                    ? FloatingActionButton(
                        backgroundColor: Colors.indigo,
                        child: Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, "/login");
                          MuseumDatabase().updateOnboard(true);
                        },
                      )
                    : Container(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
