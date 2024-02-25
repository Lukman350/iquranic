import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../storage/theme_storage.dart';
import '../themes/app_colors.dart';

class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit() : super(_themeLight);

  static final _themeLight = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.backgroundLight,
    fontFamily: 'Poppins',
  );

  static final _themeDark = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.backgroundDark,
    fontFamily: 'Poppins',
  );

  void toggleTheme() async {
    final theme = state.brightness == Brightness.light ? 'dark' : 'light';
    await ThemeStorage.writeTheme(theme);

    emit(theme == 'light' ? _themeLight : _themeDark);
  }
}
