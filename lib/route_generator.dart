import 'package:flutter/material.dart';
import 'package:museum_app/bottom_navigationbar/navigationbar_pattern.dart';
import 'package:museum_app/login_page/login_page.dart';
import 'package:museum_app/onboarding/enter_museum.dart';
import 'package:museum_app/onboarding/onboarding.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => EnterMuseum());
      case '/onboard':
        return MaterialPageRoute(builder: (_) => Onboarding());
      case '/login':
        return MaterialPageRoute(builder: (_) => LogIn());
      //case '/':
        //return MaterialPageRoute(builder: (_) => BottomBarNavigationPatternExample());
      case '/home':
        return MaterialPageRoute(builder: (_) => BottomBarNavigationPatternExample.fromIndex(0));
      case '/tours':
        return MaterialPageRoute(builder: (_) => BottomBarNavigationPatternExample.fromIndex(1));
      case '/add':
        return MaterialPageRoute(builder: (_) => BottomBarNavigationPatternExample.fromIndex(2));
      case '/profile':
        return MaterialPageRoute(builder: (_) => BottomBarNavigationPatternExample.fromIndex(3));
      case '/loading':
        return MaterialPageRoute(builder: (_) => Center(child: CircularProgressIndicator()));
      // case '/second':
      //   // Validation of correct data type
      //   if (args is String) {
      //     return MaterialPageRoute(
      //       builder: (_) => SecondPage(
      //             data: args,
      //           ),
      //     );
      //   }
      //   // If args is not of the correct type, return an error page.
      //   // You can also throw an exception while in development.
      //   return _errorRoute();
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
