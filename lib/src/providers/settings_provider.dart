import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  static const _kThemeMode = 'theme_mode';
  static const _kLocale = 'locale_code';   

  ThemeMode _themeMode = ThemeMode.system;
  Locale? _locale;

  ThemeMode get themeMode => _themeMode;
  Locale? get locale => _locale;


  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();

    switch (prefs.getString(_kThemeMode)) {
      case 'light': _themeMode = ThemeMode.light; break;
      case 'dark':  _themeMode = ThemeMode.dark;  break;
      default:      _themeMode = ThemeMode.system;
    }

    final code = prefs.getString(_kLocale);
    _locale = (code == null || code.isEmpty) ? null : Locale(code);

    notifyListeners();
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _kThemeMode,
      mode == ThemeMode.light ? 'light'
      : mode == ThemeMode.dark ? 'dark'
      : 'system',
    );
    notifyListeners();
  }

  Future<void> setLocaleCode(String? code) async {
    _locale = (code == null || code.isEmpty) ? null : Locale(code);
    final prefs = await SharedPreferences.getInstance();
    if (code == null || code.isEmpty) {
      await prefs.remove(_kLocale);
    } else {
      await prefs.setString(_kLocale, code);
    }
    notifyListeners();
  }

  // tiện
  Future<void> useSystemTheme() => setThemeMode(ThemeMode.system);
  Future<void> useSystemLocale() => setLocaleCode(null);
}
