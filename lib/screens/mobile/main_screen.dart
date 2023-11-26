import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:iquranic/components/alert_error.dart';
import 'package:iquranic/components/appbar_title.dart';
import 'package:iquranic/components/skeleton_mobile.dart';
import 'package:iquranic/components/surah_card.dart';
import 'package:iquranic/models/surah.dart';
import 'package:iquranic/components/bottom_nav.dart';

class MainScreenMobile extends StatelessWidget {
  final Future<SurahList> surahList;
  final DateTime now;
  static const String _title = 'iQuranic';
  final HijriCalendar todayHijri;

  const MainScreenMobile(
      {super.key,
      required this.surahList,
      required this.now,
      required this.todayHijri});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: const AppBarTitle(title: _title),
          automaticallyImplyLeading: false),
      body: SafeArea(
          child: Padding(
              padding:
                  const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                      flex: 2,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Assalamu\'alaikum\nSelamat Datang',
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                  fontSize: 15,
                                ),
                                textAlign: TextAlign.center,
                                softWrap: true,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                '${now.hour >= 10 ? '${now.hour}' : '0${now.hour}'}:${now.minute >= 10 ? '${now.minute}' : '0${now.minute}'}',
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 36),
                              ),
                              Text(
                                todayHijri.toFormat('MMMM dd, yyyyH'),
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
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
                            'Surah Qur\'an',
                            style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          const SizedBox(height: 16),
                          Expanded(
                            child: FutureBuilder<SurahList>(
                              future: surahList,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  var surah = snapshot.data!.data;

                                  if (surah.isEmpty) {
                                    return const Center(
                                        child: Text('Surah tidak ditemukan'));
                                  }

                                  return SurahCard(surah: surah);
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

                                return const SkeletonCardMobile();
                              },
                            ),
                          ),
                        ],
                      ))
                ],
              ))),
      bottomNavigationBar: const BottomNavWidget(
        currentIndex: 0,
      ),
    );
  }
}
