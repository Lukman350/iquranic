import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:iquranic/api/api.dart';
import 'package:iquranic/components/alert_error.dart';
import 'package:iquranic/components/appbar_title.dart';
import 'package:iquranic/components/surah_card.dart';
import 'package:iquranic/models/surah.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/search';
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late Future<SurahList> futureSurah;
  Exception? error;
  static const String _title = 'Cari Surat';

  @override
  void initState() {
    super.initState();
    futureSurah = Api().getAllSurah();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            backgroundColor: Theme.of(context).colorScheme.primary,
            title: const AppBarTitle(title: _title)),
        body: SafeArea(
            child: Padding(
                padding:
                    const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: SearchBar(
                        hintText: 'Cari surat',
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => Colors.white),
                        leading: Icon(Icons.search,
                            color:
                                Theme.of(context).colorScheme.inversePrimary),
                        onChanged: (value) {
                          setState(() {
                            futureSurah = Api().searchSurah(value.toString());
                            futureSurah.then((value) {
                              if (value.data.isEmpty) {
                                error = Exception({
                                  'code': 404,
                                  'content': 'Surat tidak ditemukan'
                                });
                              }
                            }).catchError((error) {
                              this.error = error;
                            });
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
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

                            return SurahCard(surah: surah, isSearching: false);
                          } else if (snapshot.hasError) {
                            SchedulerBinding.instance
                                .addPostFrameCallback((_) => showDialog(
                                    context: context,
                                    builder: (_) {
                                      return AlertError(
                                          message: snapshot.error.toString());
                                    }));
                          }

                          return Center(
                              child: CircularProgressIndicator(
                            backgroundColor:
                                Theme.of(context).colorScheme.inversePrimary,
                            color: Colors.white,
                          ));
                        },
                      ),
                    )
                  ],
                ))));
  }
}
