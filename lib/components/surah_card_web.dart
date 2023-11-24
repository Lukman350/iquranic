import 'package:flutter/material.dart';
import 'package:iquranic/models/surah.dart';
import 'package:iquranic/screens/surah_screen.dart';

class SurahCardDesktop extends StatelessWidget {
  final List<Surah> surah;

  const SurahCardDesktop({Key? key, required this.surah}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
        childAspectRatio: 3,
        crossAxisCount: 4,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: surah.map((data) {
          return InkWell(
            splashColor: Theme.of(context).colorScheme.secondary,
            child: Card(
              elevation: 2,
              child: ListTile(
                leading: CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    child: Text(data.nomor.toString(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18))),
                title: Text(
                  data.namaLatin,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondaryContainer,
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
                      color: Theme.of(context).colorScheme.onSecondaryContainer,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Amiri',
                      fontSize: 24),
                ),
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
  }
}
