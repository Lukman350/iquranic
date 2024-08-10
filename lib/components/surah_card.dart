import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iquranic/models/surah.dart';
// import 'package:iquranic/screens/surah_screen.dart';

import '../themes/app_colors.dart';

class SurahCard extends StatelessWidget {
  final Surah surah;

  const SurahCard({Key? key, required this.surah}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: InkWell(
            onTap: () {
            //   TODO: Navigate to SurahScreen
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        surah.namaLatin,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      Text(
                        'Ayat: ${surah.jumlahAyat}',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primary,
                        ),
                      ),
                      Text(
                        '(${surah.arti})',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: Text(
                      surah.nama,
                      style: GoogleFonts.lateef(
                        textStyle: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const Divider(
          color: AppColors.secondaryLight,
          thickness: 2,
        ),
      ],
    );
  }
}
