import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:iquranic/components/appbar_title.dart';
import 'package:iquranic/components/bottom_nav.dart';
import 'package:iquranic/components/surah_card.dart';
import 'package:iquranic/models/surah.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () async {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const AppBarTitle(title: 'My Favorite'),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
          child: Padding(
              padding:
                  const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Text(
                      'Total Favorite: ${totalFavorite.toString()}',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                  Expanded(
                    flex: 10,
                    child: FutureBuilder<List<Surah>>(
                      future: favorite,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          SchedulerBinding.instance.addPostFrameCallback((_) {
                            setState(() {
                              totalFavorite = snapshot.data!.length;
                            });
                          });

                          return snapshot.data!.isNotEmpty
                              ? SurahCard(
                                  surah: snapshot.data!,
                                  isSearching: false,
                                )
                              : const Center(
                                  child: Text('Tidak ada surat favorite',
                                      style: TextStyle(fontSize: 16)));
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      },
                    ),
                  )
                ],
              ))),
      bottomNavigationBar: const BottomNavWidget(currentIndex: 2),
    );
  }
}
