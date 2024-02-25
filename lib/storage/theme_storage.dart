import 'package:localstorage/localstorage.dart';

class ThemeStorage {
  static const String _fileName = 'theme_data.json';

  static Future<String> get _localStorage async {
    final localStorage = LocalStorage(_fileName);
    await localStorage.ready;

    return localStorage.getItem('theme') ?? 'light';
  }

  static Future<void> writeTheme(String theme) async {
    final localStorage = LocalStorage(_fileName);
    await localStorage.ready;

    await localStorage.setItem('theme', theme);
  }

  static Future<String> readTheme() async {
    try {
      final contents = await _localStorage;

      if (contents.isEmpty) {
        return 'light';
      }

      return contents;
    } catch (e) {
      return 'light';
    }
  }
}
