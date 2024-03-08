import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../storage/theme_storage.dart';
import '../themes/app_colors.dart';

class ThemeBloc extends Cubit<ThemeData> {
  ThemeBloc() : super(_themeLight);

  static final _themeLight = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.backgroundLight,
    textTheme: GoogleFonts.poppinsTextTheme(),
  );

  static final _themeDark = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.backgroundDark,
    textTheme: GoogleFonts.poppinsTextTheme(),
  );

  void toggleTheme() async {
    final theme = state.brightness == Brightness.light ? 'dark' : 'light';
    await ThemeStorage.writeTheme(theme);

    emit(theme == 'light' ? _themeLight : _themeDark);
  }
}
