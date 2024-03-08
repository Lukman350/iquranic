import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iquranic/widgets/views/surahlist_view.dart';

import 'surah_bloc.dart';

class MainScreenState {
  int currentTabIndex;
  bool loading;
  String? error;

  final List<Widget> tabView = [
    BlocProvider(
      create: (context) => SurahBloc([]),
      child: const SurahListView(),
    ),
    const Text('Doa'),
  ];

  MainScreenState({this.currentTabIndex = 0, this.loading = false, this.error});

  MainScreenState.changeTabView(int index)
      : this(currentTabIndex: index, loading: false);
  MainScreenState.loading() : this(loading: true);
  MainScreenState.error(String message) : this(error: message, loading: false);
}

class MainScreenBloc extends Cubit<MainScreenState> {
  MainScreenBloc() : super(MainScreenState());

  void changeTabView(int index) {
    emit(MainScreenState.changeTabView(index));
  }
}
