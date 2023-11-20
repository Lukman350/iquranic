import 'dart:io';

import 'package:flutter/material.dart';
import 'package:iquranic/storage/favorite_storage.dart';
import 'package:iquranic/models/surah.dart';

class FavoriteButton extends StatefulWidget {
  final Surah surah;

  const FavoriteButton({super.key, required this.surah});

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _checkFavorite();
  }

  Future<void> _checkFavorite() async {
    var favorite = await FavoriteStorage.readFavorite();

    for (var surah in favorite) {
      if (surah.nomor == widget.surah.nomor) {
        setState(() {
          isFavorite = true;
        });
      }
    }
  }

  Future<void> _addToFavorite(Surah surah) async {
    List<Surah> existing = await FavoriteStorage.readFavorite();

    if (existing.isEmpty) {
      existing = <Surah>[];
    }

    existing.add(surah);

    File result = await FavoriteStorage.writeFavorite(existing);

    debugPrint('FavoriteButton[_addToFavorite]: $result');

    setState(() {
      isFavorite = true;
    });
  }

  Future<void> _removeFromFavorite(Surah surah) async {
    List<Surah> existing = await FavoriteStorage.readFavorite();

    if (existing.isEmpty) {
      existing = <Surah>[];
    }

    existing.removeWhere((element) => element.nomor == surah.nomor);

    File result = await FavoriteStorage.writeFavorite(existing);

    debugPrint('FavoriteButton[_removeFromFavorite]: $result');

    setState(() {
      isFavorite = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      style: ButtonStyle(
        backgroundColor: isFavorite
            ? MaterialStateProperty.all(Colors.white)
            : MaterialStateProperty.all(Colors.transparent),
      ),
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: isFavorite ? Colors.red : Colors.white,
      ),
      onPressed: () async {
        if (isFavorite) {
          await _removeFromFavorite(widget.surah);
        } else {
          await _addToFavorite(widget.surah);
        }

        Navigator.pushNamed(context, '/favorite');
      },
    );
  }
}
