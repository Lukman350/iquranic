import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:iquranic/api/api.dart';
import 'package:iquranic/components/alert_error.dart';
import 'package:iquranic/components/appbar_title.dart';
import 'package:iquranic/components/drawer_web.dart';
import 'package:iquranic/components/leading_menu.dart';
import 'package:iquranic/components/skeleton_web.dart';
import 'package:iquranic/components/surah_card_web.dart';
import 'package:iquranic/models/surah.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SearchScreenDesktop extends StatefulWidget {
  const SearchScreenDesktop({Key? key}) : super(key: key);

  @override
  State<SearchScreenDesktop> createState() => _SearchScreenDesktopState();
}

class _SearchScreenDesktopState extends State<SearchScreenDesktop> {
  late Future<SurahList> futureSurah;
  Exception? error;

  @override
  void initState() {
    super.initState();
    futureSurah = Api().getAllSurah();
  }

  List<Widget> _createSearchBar() {
    final screenWidth = MediaQuery.of(context).size.width;

    return kIsWeb
        ? <Widget>[
            Expanded(
                flex: 1,
                child: SearchBar(
                  hintText: 'Cari surah...',
                  backgroundColor:
                      WidgetStateColor.resolveWith((states) => Colors.white),
                  leading: Icon(Icons.search,
                      color: Theme.of(context).colorScheme.inversePrimary),
                  onChanged: (value) {
                    setState(() {
                      futureSurah = Api().searchSurah(value.toString());
                      futureSurah.then((value) {
                        if (value.data.isEmpty) {
                          error = Exception({
                            'code': 404,
                            'content': 'Surah tidak ditemukan'
                          });
                        }
                      }).catchError((error) {
                        this.error = error;
                      });
                    });
                  },
                )),
            const SizedBox(width: 16),
            Expanded(
              flex: 8,
              child: FutureBuilder<SurahList>(
                future: futureSurah,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var surah = snapshot.data!.data;

                    if (surah.isEmpty) {
                      SchedulerBinding.instance
                          .addPostFrameCallback((_) => showDialog(
                              context: context,
                              builder: (_) {
                                return AlertError(
                                    message: snapshot.error.toString());
                              }));
                    }

                    return SurahCardDesktop(
                        surah: surah,
                        gridCount:
                            kIsWeb && (screenWidth < 1200 && screenWidth >= 800)
                                ? 3
                                : (kIsWeb && screenWidth >= 1200 ? 4 : 2),
                        gridAspectRatio:
                            kIsWeb && (screenWidth < 1200 && screenWidth >= 800)
                                ? 3
                                : (kIsWeb && screenWidth >= 1200 ? 3 : 4));
                  } else if (snapshot.hasError) {
                    SchedulerBinding.instance
                        .addPostFrameCallback((_) => showDialog(
                            context: context,
                            builder: (_) {
                              return AlertError(
                                  message: snapshot.error.toString());
                            }));
                  }

                  return Skeletonizer(
                    child: SkeletonCardWeb(
                      gridCount:
                          kIsWeb && (screenWidth < 1200 && screenWidth >= 800)
                              ? 3
                              : (kIsWeb && screenWidth >= 1200 ? 4 : 2),
                      gridAspectRatio:
                          kIsWeb && (screenWidth < 1200 && screenWidth >= 800)
                              ? 3
                              : (kIsWeb && screenWidth >= 1200 ? 3 : 3),
                    ),
                  );
                },
              ),
            )
          ]
        : <Widget>[
            Expanded(
              child: FutureBuilder<SurahList>(
                future: futureSurah,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var surah = snapshot.data!.data;

                    if (surah.isEmpty) {
                      SchedulerBinding.instance
                          .addPostFrameCallback((_) => showDialog(
                              context: context,
                              builder: (_) {
                                return AlertError(
                                    message: snapshot.error.toString());
                              }));
                    }

                    return SurahCardDesktop(
                        surah: surah,
                        gridCount: kIsWeb ? 4 : 2,
                        gridAspectRatio: kIsWeb ? 3 : 5);
                  } else if (snapshot.hasError) {
                    SchedulerBinding.instance
                        .addPostFrameCallback((_) => showDialog(
                            context: context,
                            builder: (_) {
                              return AlertError(
                                  message: snapshot.error.toString());
                            }));
                  }

                  return const Skeletonizer(
                    child: SkeletonCardWeb(
                        gridCount: kIsWeb ? 4 : 2,
                        gridAspectRatio: kIsWeb ? 3 : 5),
                  );
                },
              ),
            )
          ];
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
          leading: const LeadingMenu(),
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: const AppBarTitle(title: 'Cari Surah'),
          actions: kIsWeb
              ? null
              : <Widget>[
                  SearchBar(
                    constraints:
                        const BoxConstraints(maxWidth: 300, minHeight: 40),
                    hintText: 'Cari surah...',
                    backgroundColor:
                        WidgetStateColor.resolveWith((states) => Colors.white),
                    leading: Icon(Icons.search,
                        color: Theme.of(context).colorScheme.inversePrimary),
                    onChanged: (value) {
                      setState(() {
                        futureSurah = Api().searchSurah(value.toString());
                        futureSurah.then((value) {
                          if (value.data.isEmpty) {
                            error = Exception({
                              'code': 404,
                              'content': 'Surah tidak ditemukan'
                            });
                          }
                        }).catchError((error) {
                          this.error = error;
                        });
                      });
                    },
                  )
                ],
          automaticallyImplyLeading: false),
      body: SafeArea(
          child: Center(
        child: SizedBox(
            width: screenWidth <= 1200 ? 800 : 1200,
            child: Padding(
                padding:
                    const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: _createSearchBar(),
                ))),
      )),
      drawer: const DrawerWeb(),
    );
  }
}
