import 'package:flutter/material.dart';
import 'package:notes_app/src/screen/home_page.dart';
import 'package:notes_app/src/screen/sign_in_page.dart';
import 'package:notes_app/src/util/routes_name.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.homeScreen:
        return MaterialPageRoute(builder: (context) => HomePage());
      case RouteName.signInPage:
        return MaterialPageRoute(builder: (context) => SignInPage());
      default:
        return MaterialPageRoute(builder: (context) {
          return const Scaffold(
            body: Center(child: Text('No route defined')),
          );
        });
    }
  }
}
