import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreenState {
  int currentTabIndex;
  bool loading;
  String? error;

  final List<Widget> tabView = [
    const Text('Surah'),
    const Text('Surah Pilihan'),
    const Text('Surah Terakhir'),
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
