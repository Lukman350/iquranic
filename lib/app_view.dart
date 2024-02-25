import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iquranic/cubit/theme_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '/screens/favorite_screen.dart';
import '/screens/main_screen.dart';
import '/screens/search_screen.dart';
import '/screens/surah_screen.dart';
import '/screens/get_started_screen.dart';
import '/screens/auth_screen.dart';

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeData>(builder: (_, theme) {
      return MaterialApp(
        title: 'iQuranic',
        theme: theme,
        home: FirebaseAuth.instance.currentUser != null
            ? const MainScreen()
            : const GetStartedScreen(),
        routes: {
          MainScreen.routeName: (context) => const MainScreen(),
          AuthScreen.routeName: (context) => const AuthScreen(),
          QuranScreen.routeName: (context) => const QuranScreen(),
          SearchScreen.routeName: (context) => const SearchScreen(),
          FavoriteScreen.routeName: (context) => const FavoriteScreen(),
          GetStartedScreen.routeName: (context) => const GetStartedScreen(),
        },
      );
    });
  }
}
