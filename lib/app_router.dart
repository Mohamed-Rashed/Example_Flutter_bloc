import 'package:flutter/material.dart';
import 'package:movieapp/constats/strings.dart';
import 'package:movieapp/presentation/screens/home_screen.dart';

class AppRouter{
  Route? genrateRoute(RouteSettings settings){
    switch (settings.name) {
      case HomeScreenRoute:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case movieDetailsRoute:
        return MaterialPageRoute(builder: (_) => HomeScreen());
    }
  }
}