import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:iquranic/components/alert_error.dart';
import 'package:iquranic/components/appbar_title.dart';
import 'package:iquranic/components/drawer_web.dart';
import 'package:iquranic/components/surah_card.dart';
import 'package:iquranic/models/surah.dart';
import 'package:iquranic/screens/surah_screen.dart';

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
            child: Padding(
                padding:
                    const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                        child: Center(
                            child: Column(
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
                                color:
                                    Theme.of(context).colorScheme.onBackground,
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
                              todayHijri.toFormat("dd MMMM yyyyH"),
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                  fontSize: 15),
                            ),
                          ],
                        ),
                      ],
                    ))),
                    Expanded(
                        child: Center(
                            child: SizedBox(
                      width: screenWidth <= 1200 ? 800 : 1200,
                      child: FutureBuilder<SurahList>(
                        future: surahList,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            var surah = snapshot.data!.data;

                            if (surah.isEmpty) {
                              return const Center(
                                  child: Text('Surat tidak ditemukan'));
                            }

                            return GridView.count(
                                crossAxisCount: 4,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 16,
                                children: surah.map((data) {
                                  return InkWell(
                                    splashColor:
                                        Theme.of(context).colorScheme.secondary,
                                    child: ListTile(
                                      leading: CircleAvatar(
                                          backgroundColor: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                          child: Text(data.nomor.toString(),
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18))),
                                      title: Text(
                                        data.namaLatin,
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSecondaryContainer,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 20),
                                      ),
                                      subtitle: Text(
                                          '${data.tempatTurun.toUpperCase()} • ${data.jumlahAyat.toString().toUpperCase()} AYAT',
                                          style: const TextStyle(
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w300,
                                              fontSize: 12)),
                                      trailing: Text(
                                        data.nama,
                                        textDirection: TextDirection.rtl,
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSecondaryContainer,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'Amiri',
                                            fontSize: 24),
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) {
                                                return const QuranScreen();
                                              },
                                              settings: RouteSettings(
                                                  arguments: ScreenArguments(
                                                nomor: data.nomor,
                                                nama: data.nama,
                                                namaLatin: data.namaLatin,
                                                arti: data.arti,
                                                jumlahAyat: data.jumlahAyat,
                                                tempatTurun: data.tempatTurun,
                                                audioFull: data.audioFull,
                                                deskripsi: data.deskripsi,
                                              ))));
                                    },
                                  );
                                }).toList());
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
                    ))),
                  ],
                ))),
        drawer: const DrawerWeb());
  }
}
