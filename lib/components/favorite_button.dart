import 'package:flutter/material.dart';
import 'package:iquranic/screens/favorite_screen.dart';
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

    await FavoriteStorage.writeFavorite(existing);

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

    await FavoriteStorage.writeFavorite(existing);

    setState(() {
      isFavorite = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
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

        final snackBar = SnackBar(
            content: Text(isFavorite
                ? 'Surah ${widget.surah.namaLatin} telah ditambahkan ke daftar favorit'
                : 'Surah ${widget.surah.namaLatin} telah dihapus dari daftar favorit'),
            duration: const Duration(seconds: 3),
            action: SnackBarAction(
              label: 'Lihat',
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const FavoriteScreen();
                }));
              },
            ));

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
    );
  }
}
