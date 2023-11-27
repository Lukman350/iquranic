import 'package:flutter/material.dart';
import 'package:iquranic/screens/mobile/search_screen.dart';
import 'package:iquranic/screens/web/search_screen.dart';

class SearchScreen extends StatelessWidget {
  static const routeName = '/search';

  const SearchScreen({Key? key}) : super(key: key);

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
