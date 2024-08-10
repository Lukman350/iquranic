import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:iquranic/bloc/mainscreen_bloc.dart';
import 'package:iquranic/bloc/user_bloc.dart';
import 'package:iquranic/themes/app_colors.dart';

import '../../widgets/app_bar.dart';

class MainScreenMobile extends StatelessWidget {
  final DateTime now;
  final HijriCalendar todayHijri;

  const MainScreenMobile(
      {super.key, required this.now, required this.todayHijri});

  @override
  Widget build(BuildContext context) {
    final UserBloc userCubit = context.read<UserBloc>();
    final MainScreenBloc mainScreenCubit = context.read<MainScreenBloc>();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // appbar
            const MyAppBar(),
            // greeting
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  BlocBuilder<UserBloc, User?>(
                    builder: (context, state) {
                      return state?.displayName == null
                          ? Container(
                              height: 50,
                              width: double.infinity,
                              margin: const EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                color: Colors.red[900],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Row(
                                      children: [
                                        Icon(
                                          Icons.warning_rounded,
                                          size: 18,
                                          color: AppColors.secondaryLight,
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          'Silahkan lengkapi profil Anda',
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.secondaryLight,
                                          ),
                                        ),
                                      ],
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        //   TODO: navigate to profile screen to complete profile
                                      },
                                      child: const Text(
                                        'Lengkapi',
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.secondaryLight,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          : const SizedBox();
                    }
                  ),
                  Row(
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
                          BlocBuilder<UserBloc, User?>(
                            bloc: userCubit,
                            builder: (context, state) {
                              return Text(
                                state?.displayName ?? 'User',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                ),
                              );
                            },
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
                ],
              ),
            ),
            // last read surah
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: Container(
                height: 130,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.secondaryLight.withOpacity(0.5),
                      blurRadius: 10,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Material(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.secondaryLight,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {},
                    hoverColor: AppColors.secondaryLight,
                    focusColor: AppColors.secondaryLight,
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
            ),
            // Tab Surah
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: DefaultTabController(
                length: 2,
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
                    mainScreenCubit.changeTabView(index);
                  },
                  dragStartBehavior: DragStartBehavior.down,
                  tabs: const [
                    Tab(text: 'Surah'),
                    Tab(text: 'Doa Sehari-hari'),
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
              child: BlocBuilder<MainScreenBloc, MainScreenState>(
                bloc: mainScreenCubit,
                builder: (context, state) {
                  if (state.loading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state.error != null) {
                    return Center(
                      child: Text(state.error!),
                    );
                  } else {
                    return state.tabView[state.currentTabIndex];
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
