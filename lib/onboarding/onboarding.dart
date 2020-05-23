import 'package:flutter/material.dart';
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

                  } else {
                    lastPage = false;
                    //animationController.reset();
                  }
                  //animationController.forward();
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
                            padding: EdgeInsets.only(top: 30),
                            //margin: EdgeInsets.only(left:16.0, right:16.0, top:5.0),
                            alignment: Alignment.center,
                            child: Text(
                              page.title,
                              //gradient: LinearGradient(
                              //  colors: pageList[index].titleGradient),
                              style: TextStyle(
                                color: Color(0xFF050939),
                                fontSize: horSize(8, 4),
                                fontFamily: "Nunito",
                                fontWeight: FontWeight.w600,
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
                                    fontSize: horSize(5.1, 3),
                                    fontFamily: "Nunito",
                                    fontWeight: FontWeight.w300,
                                    //fontStyle: FontStyle.italic,
                                    color: Color(0xFF1A1A1A)),
                              )),
                        ),
                        Container(
                            padding: const EdgeInsets.only(
                                left: 16.0, right: 16.0, top: 10),
                            alignment: Alignment.center,
                            child: extraInfo(page, y)),
                        bottomInfo(page.number),
                      ],
                    );
                  },
                );
              },
            ),
            Positioned(
              left: 20,
              bottom: 30,
              child: Container(
                  width: 160.0,
                  child: PageIndicator(currentPage, pageList.length,
                      pageList[currentPage].color)),
            ),
            Positioned(
              right: 25.0,
              bottom: 25.0,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: getButton(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getButton() {
    if (lastPage)
      return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, "/login");
          MuseumDatabase().updateOnboard(true);
        },
        child: textWithArrow("Zum Login ", size: 22),
      );
    return GestureDetector(
      onTap: () => _controller.animateToPage(currentPage + 1,
          duration: Duration(milliseconds: 700), curve: Curves.linear),
      child: textWithArrow("Weiter ", size: 22),
    );
  }

  Widget textWithArrow(String s, {double size = 20.0}) {
    return Row(
      children: [
        Text(s, style: TextStyle(fontSize: size),),
        Icon(Icons.arrow_forward, size: size + 7.0,),
      ],
    );
  }

  Widget extraInfo(PageModel page, y) {
    List<String> extras = page.extra.split(";");

    if (extras.length == 0) return Container();
    if (extras.length == 1)
      return Transform(
        transform: Matrix4.translationValues(0, 50.0 * (1 - y), 0),
        child: Text(
          extras[0],
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: horSize(4, 2),
              fontFamily: "Nunito",
              fontWeight: FontWeight.w300,
              //fontStyle: FontStyle.italic,
              color: Color(0xFF1A1A1A)),
        ),
      );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        extras.length,
        (index) => Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 5, right: 7),
              alignment: Alignment.center,
              child: SafeArea(
                bottom: false,
                child: Icon(Icons.check_box, color: page.color, size: 27),
              ),
            ),
            Container(
              //margin: EdgeInsets.only(right: .0),
              alignment: Alignment.center,
              child: SafeArea(
                bottom: false,
                child: Text(
                  extras[index],
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: horSize(5.5, 2),
                      fontFamily: "Nunito",
                      fontWeight: FontWeight.w300,
                      //fontStyle: FontStyle.italic,
                      color: Color(0xFF1A1A1A)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget bottomInfo(int num) {
    return (num == 1)
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  alignment: Alignment.center,
                  child: SafeArea(
                    bottom: false,
                    child: Image.asset('assets/images/photo_2020-01-19.jpeg',
                        width: horSize(22, 30), height: verSize(15, 10)),
                  )),
              Container(
                  margin: EdgeInsets.only(left: 16.0, right: 16.0),
                  alignment: Alignment.center,
                  child: SafeArea(
                    bottom: false,
                    child: Image.asset('assets/images/Logo_MINTplus_182x0.jpg',
                        width: horSize(22, 30), height: verSize(15, 20)),
                  )),
              Container(
                  margin: EdgeInsets.only(left: 16.0, right: 16.0),
                  alignment: Alignment.center,
                  child: SafeArea(
                    bottom: false,
                    child: Image.asset('assets/images/serveimage.png',
                        width: horSize(22, 30), height: verSize(15, 20)),
                  )),
            ],
          )
        : Container();
  }
}
