import 'package:flutter/gestures.dart';
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
        create: (context) => MainScreenCubit(
          FirebaseAuth.instance,
        ),
        child: BlocBuilder<MainScreenCubit, MainScreenState>(
            builder: (context, MainScreenState state) {
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
                                  state.user?.photoURL ??
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
                            state.user?.displayName ?? 'User',
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
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.menu_book_rounded,
                                      size: 18,
                                      color: AppColors.primary,
                                    ),
                                    SizedBox(width: 12),
                                    Text(
                                      'Terakhir dibaca',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20),
                                Text(
                                  'Al-Fatihah',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primary,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
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
                    child: TabBar(
                      labelColor: AppColors.primary,
                      unselectedLabelColor: AppColors.secondary,
                      indicatorColor: AppColors.primary,
                      dividerColor: AppColors.secondaryLight,
                      dividerHeight: 3,
                      unselectedLabelStyle: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                      labelStyle: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                      onTap: (index) {
                        context.read<MainScreenCubit>().changeTabView(index);
                      },
                      dragStartBehavior: DragStartBehavior.down,
                      tabs: const [
                        Tab(text: 'Surah'),
                        Tab(text: 'Surah Pilihan'),
                        Tab(text: 'Surah Terakhir'),
                      ],
                    ),
                  ),
                ),
                // Tab view
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: state.tabView[state.currentTabIndex],
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

class MainScreenState {
  int currentTabIndex;
  User? user;
  bool loading;
  String? error;

  final List<Widget> tabView = [
    const Text('Surah'),
    const Text('Surah Pilihan'),
    const Text('Surah Terakhir'),
  ];

  MainScreenState(
      {this.currentTabIndex = 0, this.user, this.loading = false, this.error});

  MainScreenState.changeTabView(int index)
      : this(currentTabIndex: index, loading: false);
  MainScreenState.loading() : this(loading: true);
  MainScreenState.error(String message) : this(error: message, loading: false);
}

class MainScreenCubit extends Cubit<MainScreenState> {
  final FirebaseAuth _auth;

  MainScreenCubit(this._auth) : super(MainScreenState(user: _auth.currentUser));

  void changeTabView(int index) {
    emit(MainScreenState.changeTabView(index));
  }

  void signOut() async {
    emit(MainScreenState.loading());

    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      emit(MainScreenState.error(e.message!));
    }
  }
}
