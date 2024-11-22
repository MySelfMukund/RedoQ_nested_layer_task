import 'package:flutter/material.dart';

import '../../presentations/pages/pages.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
      case HomePage.routeName:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case AddPersonPage.routeName:
        return MaterialPageRoute(builder: (_) => const AddPersonPage());
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return const Scaffold(
        body: Center(
          child: Text('Error Route'),
        ),
      );
    });
  }
}
