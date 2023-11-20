import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:iquranic/components/alert_error.dart';
import 'package:iquranic/components/appbar_title.dart';
import 'package:iquranic/api/api.dart';
import 'package:iquranic/components/surah_card.dart';
import 'package:iquranic/models/surah.dart';

class MainScreen extends StatefulWidget {
  static const routeName = '/';
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final HijriCalendar _today = HijriCalendar.now();
  DateTime _now = DateTime.now();
  late final Timer _timer;
  late Future<SurahList> _surahList;
  static const String _title = 'iQuranic';

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _now = DateTime.now();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
    _surahList = Api().getAllSurah();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const AppBarTitle(title: _title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search,
                size: 32, color: Theme.of(context).colorScheme.onPrimary),
            onPressed: () {
              Navigator.pushNamed(context, '/search');
            },
          ),
        ],
      ),
      body: SafeArea(
          child: Padding(
              padding:
                  const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                      child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Assalamu\'alaikum',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onBackground,
                              fontSize: 15,
                            ),
                            textAlign: TextAlign.center,
                            softWrap: true,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            '${_now.hour >= 10 ? '${_now.hour}' : '0${_now.hour}'}:${_now.minute >= 10 ? '${_now.minute}' : '0${_now.minute}'}',
                            style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                                fontWeight: FontWeight.bold,
                                fontSize: 36),
                          ),
                          Text(
                            _today.toFormat('MMMM dd, yyyyH'),
                            style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                                fontWeight: FontWeight.bold,
                                fontSize: 10),
                          ),
                        ],
                      ),
                      const SizedBox(width: 16),
                      Image.asset(
                        'assets/images/hero.png',
                        fit: BoxFit.cover,
                        width: 180,
                        height: 180,
                        scale: 1,
                        alignment: Alignment.center,
                      ),
                    ],
                  )),
                  const SizedBox(height: 16),
                  Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Surat Qur\'an',
                            style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          const SizedBox(height: 16),
                          Expanded(
                            child: FutureBuilder<SurahList>(
                              future: _surahList,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  var surah = snapshot.data!.data;

                                  if (surah.isEmpty) {
                                    return const Center(
                                        child: Text('Surat tidak ditemukan'));
                                  }

                                  return SurahCard(
                                      surah: surah, isSearching: false);
                                } else if (snapshot.hasError) {
                                  SchedulerBinding.instance
                                      .addPostFrameCallback((_) => showDialog(
                                          context: context,
                                          builder: (_) {
                                            return AlertError(
                                                message:
                                                    snapshot.error.toString());
                                          }));
                                }

                                return Center(
                                    child: CircularProgressIndicator(
                                  backgroundColor: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary,
                                  color: Colors.white,
                                ));
                              },
                            ),
                          ),
                        ],
                      ))
                ],
              ))),
    );
  }
}
