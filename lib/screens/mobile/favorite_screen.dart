import 'package:flutter/material.dart';
import 'package:iquranic/components/appbar_title.dart';
import 'package:iquranic/components/bottom_nav.dart';
import 'package:iquranic/components/surah_card.dart';
import 'package:iquranic/models/surah.dart';
import 'package:skeletonizer/skeletonizer.dart';

class FavoriteScreenMobile extends StatelessWidget {
  final Future<List<Surah>> favorite;
  final int totalFavorite;

  const FavoriteScreenMobile(
      {Key? key, required this.favorite, required this.totalFavorite})
      : super(key: key);

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
                      'Total Favorite: $totalFavorite',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                  Expanded(
                    flex: 10,
                    child: FutureBuilder<List<Surah>>(
                      future: favorite,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return snapshot.data!.isNotEmpty
                              ? ListView.builder(
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    return SurahCard(
                                        surah: snapshot.data![index]);
                                  },
                                )
                              : const Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(
                                        Icons.favorite_border,
                                        size: 90,
                                        color: Colors.grey,
                                      ),
                                      Text('Tidak ada surat favorite',
                                          style: TextStyle(fontSize: 16)),
                                    ],
                                  ),
                                );
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          return Skeletonizer(
                            child: ListView.builder(
                              itemCount: 10,
                              itemBuilder: (context, index) {
                                return SurahCard(
                                  surah: Surah(
                                    nomor: 0,
                                    nama: 'Loading...',
                                    namaLatin: 'Loading...',
                                    arti: 'Loading...',
                                    jumlahAyat: 0,
                                    audioFull: {},
                                    deskripsi: 'Loading...',
                                    tempatTurun: 'Loading...',
                                  ),
                                );
                              },
                            ),
                          );
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
