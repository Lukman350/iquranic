import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:iquranic/components/alert_error.dart';
import 'package:iquranic/components/appbar_title.dart';
import 'package:iquranic/components/drawer_web.dart';
import 'package:iquranic/components/skeleton_web.dart';
import 'package:iquranic/components/surah_card_web.dart';
import 'package:iquranic/models/surah.dart';

class MainScreenDesktop extends StatelessWidget {
  final Future<SurahList> surahList;
  final DateTime now;
  final HijriCalendar todayHijri;
  static const String _title = 'iQuranic';

  const MainScreenDesktop(
      {super.key,
      required this.surahList,
      required this.now,
      required this.todayHijri});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            title: const AppBarTitle(title: _title),
            centerTitle: true,
            leading: Builder(builder: (context) {
              return IconButton(
                  icon: const Icon(Icons.menu, color: Colors.white),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  });
            }),
            automaticallyImplyLeading: false),
        body: SafeArea(
          child: Column(children: <Widget>[
            Expanded(
              flex: 1,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    child: Container(
                      alignment: Alignment.center,
                      width: screenWidth,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                      child: Center(
                          child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            'assets/images/hero.png',
                            width: 250,
                            height: 250,
                          ),
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
                              const SizedBox(height: 16),
                              Text(
                                todayHijri.toFormat("MMMM dd, yyyyH"),
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                    fontSize: 15),
                              ),
                            ],
                          ),
                        ],
                      )),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
                flex: 2,
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Positioned(
                      child: SizedBox(
                        width: screenWidth <= 1200 ? 800 : 1200,
                        child: FutureBuilder<SurahList>(
                          future: surahList,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var surah = snapshot.data!.data;

                              if (surah.isEmpty) {
                                return const Center(
                                    child: Text('Surah tidak ditemukan'));
                              }

                              return SurahCardDesktop(surah: surah);
                            } else if (snapshot.hasError) {
                              SchedulerBinding.instance
                                  .addPostFrameCallback((_) => showDialog(
                                      context: context,
                                      builder: (_) {
                                        return AlertError(
                                            message: snapshot.error.toString());
                                      }));
                            }

                            return const SkeletonCardWeb();
                          },
                        ),
                      ),
                    )
                  ],
                ))
          ]),
        ),
        drawer: const DrawerWeb());
  }
}
