import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:iquranic/models/surah.dart';
import 'package:iquranic/components/bottom_nav.dart';
import 'package:iquranic/themes/app_colors.dart';

class MainScreenMobile extends StatelessWidget {
  final Future<SurahList> surahList;
  final DateTime now;
  final HijriCalendar todayHijri;

  const MainScreenMobile(
      {super.key,
      required this.surahList,
      required this.now,
      required this.todayHijri});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        lazy: false,
        create: (context) => MainScreenCubit(),
        child:
            BlocBuilder<MainScreenCubit, User>(builder: (context, User user) {
          return SingleChildScrollView(
            child: Column(
              children: [
                // appbar
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {},
                          radius: 20.0,
                          borderRadius: BorderRadius.circular(20.0),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 10,
                            ),
                            child: Image.asset(
                              'assets/images/hamburger_menu.png',
                              width: 24,
                            ),
                          ),
                        ),
                        const Text(
                          'iQuranic',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                        const Spacer(),
                        SearchBar(
                          trailing: Iterable.generate(1).map((e) {
                            return InkWell(
                              onTap: () {},
                              child: const Icon(
                                Icons.search,
                                size: 18,
                                color: AppColors.primary,
                              ),
                            );
                          }).toList(),
                          constraints: const BoxConstraints(
                            maxWidth: 110,
                            minHeight: 35,
                          ),
                          textStyle: MaterialStateProperty.resolveWith(
                            (states) => const TextStyle(
                              fontSize: 12,
                              color: AppColors.primary,
                            ),
                          ),
                          backgroundColor: MaterialStateColor.resolveWith(
                            (states) => AppColors.secondaryLight,
                          ),
                          shape: MaterialStateProperty.resolveWith(
                            (states) => RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                              color: AppColors.secondaryLight,
                              borderRadius: BorderRadius.circular(50),
                              image: DecorationImage(
                                image: NetworkImage(
                                  user.photoURL ??
                                      'https://via.placeholder.com/35',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // greeting
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Assalamu\'alaikum,',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: AppColors.secondary,
                            ),
                          ),
                          Text(
                            user.displayName ?? 'User',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '${now.hour >= 10 ? '${now.hour}' : '0${now.hour}'}:${now.minute >= 10 ? '${now.minute}' : '0${now.minute}'} ${now.hour >= 12 ? 'PM' : 'AM'}',
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: AppColors.secondary,
                            ),
                          ),
                          Text(
                            todayHijri.toFormat('MMMM dd, yyyyH'),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // last read surah
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: InkWell(
                    onTap: () {},
                    radius: 20.0,
                    hoverColor: AppColors.secondaryLight,
                    child: Container(
                      height: 130,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColors.secondaryLight,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.menu_book_rounded,
                                      size: 18,
                                      color: AppColors.primary,
                                    ),
                                    const SizedBox(width: 12),
                                    Text(
                                      'Terakhir dibaca',
                                      style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                const Text(
                                  'Al-Fatihah',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primary,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                const Text(
                                  'Jumlah Ayat: 7',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Image.asset(
                              'assets/images/quran.png',
                              width: 75,
                              fit: BoxFit.cover,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                // Tab Surah
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: DefaultTabController(
                    length: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TabBar(tabs: [
                          Tab(
                            text: 'Surah',
                          ),
                          Tab(
                            text: 'Juz',
                          ),
                          Tab(
                            text: 'Doa',
                          ),
                        ]),
                        const SizedBox(height: 10),
                        TabBarView(children: [
                          Text('Surah'),
                          Text('Juz'),
                          Text('Doa'),
                        ]),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
      bottomNavigationBar: const BottomNavWidget(
        currentIndex: 0,
      ),
    );
  }
}

class MainScreenCubit extends Cubit<User> {
  MainScreenCubit() : super(FirebaseAuth.instance.currentUser!);

  void signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
