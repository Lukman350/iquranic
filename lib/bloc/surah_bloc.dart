import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iquranic/models/surah.dart';
import '../api/api.dart';

class SurahBloc extends Cubit<List<Surah>> {
  final List<Surah> surahList;

  SurahBloc(this.surahList) : super(surahList);

  Future<List<Surah>> getSurahList() async {
    final SurahList surahList = await Api().getAllSurah();
    emit(surahList.data);
    return state;
  }
}
