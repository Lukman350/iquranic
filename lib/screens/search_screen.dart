import 'package:flutter/material.dart';
import 'package:iquranic/screens/mobile/search_screen.dart';
import 'package:iquranic/screens/web/search_screen.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/search';
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (constraints.maxWidth <= 600) {
        return const SearchScreenMobile();
      } else {
        return const SearchScreenDesktop();
      }
    });
  }
}
