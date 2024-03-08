import 'package:flutter/material.dart';

import '../screens/auth_screen.dart';
// import '../screens/favorite_screen.dart';
import '../screens/get_started_screen.dart';
import '../screens/main_screen.dart';
// import '../screens/search_screen.dart';
import '../screens/surah_screen.dart';
import '../screens/not_found_screen.dart';

class AppRoutes {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => const MainScreen());
      case '/auth':
        return MaterialPageRoute(builder: (context) => const AuthScreen());
      case '/surah':
        return MaterialPageRoute(builder: (context) => const QuranScreen());
      // case '/search':
      //   return MaterialPageRoute(builder: (context) => const SearchScreen());
      // case '/my_favorite':
      //   return MaterialPageRoute(builder: (context) => const FavoriteScreen());
      case '/get_started':
        return MaterialPageRoute(
            builder: (context) => const GetStartedScreen());
      default:
        return MaterialPageRoute(builder: (context) => const NotFoundScreen());
    }
  }

  List<Route> generateInitialRoutes(String initialRouteName, bool isAuth) {
    if (isAuth) {
      return [
        MaterialPageRoute(builder: (context) => const MainScreen()),
      ];
    } else {
      return [
        MaterialPageRoute(builder: (context) => const GetStartedScreen()),
      ];
    }
  }
}
