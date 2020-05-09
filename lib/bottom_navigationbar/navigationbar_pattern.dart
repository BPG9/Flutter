import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:museum_app/add_tour/add_tour.dart';
import 'package:museum_app/bottom_navigationbar/animated_navigationbar.dart';
import 'package:museum_app/home_page/home_page.dart';
import 'package:museum_app/profile_page/profile_page.dart';
import 'package:museum_app/tours_page/tours_page.dart';

import '../constants.dart';

class BottomBarNavigationPatternExample extends StatefulWidget {
  final int startIndex;

  BottomBarNavigationPatternExample.fromIndex(this.startIndex, {Key key}): super(key: key);

  BottomBarNavigationPatternExample({Key key}) : this.fromIndex(0, key: key);

  final List<BarItem> barItems = [
    BarItem(
      text: "Home",
      iconData: Icons.home,
      color: COLOR_HOME,
    ),
    BarItem(
      text: "Tour",
      iconData: Icons.assistant_photo,
      color: COLOR_TOUR,
    ),
    BarItem(
      text: "Erstellen",
      iconData: Icons.add,
      color: COLOR_ADD,
    ),
    BarItem(
      text: "Profil",
      iconData: Icons.person_outline,
      color: COLOR_PROFILE,
    ),
  ];

  @override
  _BottomBarNavigationPatternExampleState createState() =>
      _BottomBarNavigationPatternExampleState(startIndex);
}

class _BottomBarNavigationPatternExampleState
    extends State<BottomBarNavigationPatternExample> {
  int selectedBarIndex;

  _BottomBarNavigationPatternExampleState(this.selectedBarIndex);

  @override
  void initState() {
    super.initState();
    KeyboardVisibilityNotification().addNewListener(
        onHide: () => FocusScope.of(context).requestFocus(FocusNode()));
  }

  List<Widget> arr = [
    Home(),
    Tours(),
    AddTour(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        color: widget.barItems[selectedBarIndex].color,
        duration: const Duration(milliseconds: 300),
        child: arr[selectedBarIndex],
      ),
      bottomNavigationBar: AnimatedBottomBar(
          barItems: widget.barItems,
          animationDuration: const Duration(milliseconds: 150),
          barStyle: BarStyle(fontSize: 16.0, iconSize: 25.0),
          onBarTap: (index) => setState(() => selectedBarIndex = index),
        startIndex: widget.startIndex,
      ),
    );
  }
}
