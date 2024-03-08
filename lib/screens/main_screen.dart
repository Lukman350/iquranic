import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:iquranic/api/api.dart';
import 'package:iquranic/bloc/mainscreen_bloc.dart';
import 'package:iquranic/models/surah.dart';
import 'package:iquranic/screens/mobile/main_screen.dart';
import 'package:iquranic/screens/web/main_screen.dart';

class MainScreen extends StatefulWidget {
  static const routeName = '/home';
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final HijriCalendar _today = HijriCalendar.now();
  DateTime _now = DateTime.now();
  late final Timer _timer;
  late Future<SurahList> _surahList;

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
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (constraints.maxWidth <= 600) {
        return BlocProvider<MainScreenBloc>(
          create: (context) => MainScreenBloc(),
          child: MainScreenMobile(now: _now, todayHijri: _today),
        );
      } else {
        return MainScreenDesktop(
            surahList: _surahList, now: _now, todayHijri: _today);
      }
    });
  }
}
