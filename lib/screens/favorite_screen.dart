import 'package:flutter/material.dart';
import 'package:iquranic/models/surah.dart';
import 'package:iquranic/screens/mobile/favorite_screen.dart';
import 'package:iquranic/screens/web/favorite_screen.dart';
import 'package:iquranic/storage/favorite_storage.dart';

class FavoriteScreen extends StatefulWidget {
  static const routeName = '/favorite';

  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  late Future<List<Surah>> favorite;
  int totalFavorite = 0;

  @override
  void initState() {
    super.initState();
    favorite = FavoriteStorage.readFavorite();
    _getTotalFavorite();
  }

  Future<void> _getTotalFavorite() async {
    var favorite = await FavoriteStorage.readFavorite();

    setState(() {
      totalFavorite = favorite.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (constraints.maxWidth <= 600) {
        return FavoriteScreenMobile(
            favorite: favorite, totalFavorite: totalFavorite);
      } else {
        return FavoriteScreenWeb(
            favorite: favorite, totalFavorite: totalFavorite);
      }
    });
  }
}
