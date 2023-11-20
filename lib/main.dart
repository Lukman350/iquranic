import 'package:flutter/material.dart';
import 'package:iquranic/screens/favorite_screen.dart';
import 'package:iquranic/screens/main_screen.dart';
import 'package:iquranic/screens/search_screen.dart';
import 'package:iquranic/screens/surah_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'iQuranic',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromRGBO(149, 67, 255, 1)),
        useMaterial3: true,
        fontFamily: 'Poppins',
      ),
      routes: {
        MainScreen.routeName: (context) => const MainScreen(),
        QuranScreen.routeName: (context) => const QuranScreen(),
        SearchScreen.routeName: (context) => const SearchScreen(),
        FavoriteScreen.routeName: (context) => const FavoriteScreen(),
      },
    );
  }
}
