import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/constants/storage_keys.dart';

class SettingsProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  Locale? _locale;

  ThemeMode get themeMode => _themeMode;
  Locale? get locale => _locale;

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    _loadThemeMode(prefs);
    _loadLocale(prefs);
    notifyListeners();
  }

  void _loadThemeMode(SharedPreferences prefs) {
    final themeModeString = prefs.getString(StorageKeys.themeMode);
    _themeMode = switch (themeModeString) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.system,
    };
  }

  void _loadLocale(SharedPreferences prefs) {
    final localeCode = prefs.getString(StorageKeys.localeCode);
    _locale = (localeCode == null || localeCode.isEmpty) ? null : Locale(localeCode);
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    final prefs = await SharedPreferences.getInstance();
    final value = switch (mode) {
      ThemeMode.light => 'light',
      ThemeMode.dark => 'dark',
      ThemeMode.system => 'system',
    };
    await prefs.setString(StorageKeys.themeMode, value);
    notifyListeners();
  }

  Future<void> setLocale(Locale? locale) async {
    _locale = locale;
    final prefs = await SharedPreferences.getInstance();
    if (locale == null) {
      await prefs.remove(StorageKeys.localeCode);
    } else {
      await prefs.setString(StorageKeys.localeCode, locale.languageCode);
    }
    notifyListeners();
  }

  Future<void> setLocaleCode(String? code) async {
    if (code == null || code.isEmpty) {
      await setLocale(null);
    } else {
      await setLocale(Locale(code));
    }
  }

  Future<void> useSystemTheme() => setThemeMode(ThemeMode.system);
  Future<void> useSystemLocale() => setLocale(null);
}