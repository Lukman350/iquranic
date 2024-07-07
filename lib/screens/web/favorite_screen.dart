import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:iquranic/components/appbar_title.dart';
import 'package:iquranic/components/drawer_web.dart';
import 'package:iquranic/components/leading_menu.dart';
import 'package:iquranic/components/skeleton_web.dart';
import 'package:iquranic/components/surah_card_web.dart';
import 'package:iquranic/models/surah.dart';
import 'package:skeletonizer/skeletonizer.dart';

class FavoriteScreenWeb extends StatelessWidget {
  final Future<List<Surah>> favorite;
  final int totalFavorite;

  const FavoriteScreenWeb(
      {Key? key, required this.favorite, required this.totalFavorite})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: const LeadingMenu(),
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
                          return snapshot.data!.isNotEmpty
                              ? SurahCardDesktop(
                                  surah: snapshot.data!,
                                  gridCount: kIsWeb &&
                                          (screenWidth < 1200 &&
                                              screenWidth >= 800)
                                      ? 3
                                      : (kIsWeb && screenWidth >= 1200 ? 4 : 2),
                                  gridAspectRatio: kIsWeb &&
                                          (screenWidth < 1200 &&
                                              screenWidth >= 800)
                                      ? 3
                                      : (kIsWeb && screenWidth >= 1200 ? 4 : 5))
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
                                ));
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          return Skeletonizer(
                            child: SkeletonCardWeb(
                              gridCount: kIsWeb &&
                                      (screenWidth < 1200 && screenWidth >= 800)
                                  ? 3
                                  : (kIsWeb && screenWidth >= 1200 ? 4 : 2),
                              gridAspectRatio: kIsWeb &&
                                      (screenWidth < 1200 && screenWidth >= 800)
                                  ? 3
                                  : (kIsWeb && screenWidth >= 1200 ? 4 : 5),
                            ),
                          );
                        }
                      },
                    ),
                  )
                ],
              ))),
      drawer: const DrawerWeb(),
    );
  }
}
