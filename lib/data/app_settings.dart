import 'package:flutter/material.dart';

class AppSettings {
  static final ValueNotifier<ThemeMode> themeMode =
      ValueNotifier<ThemeMode>(ThemeMode.light);

  static final ValueNotifier<String> selectedLanguage =
      ValueNotifier<String>('Indonesia (Bahasa Indonesia)');

  static bool get isDarkMode => themeMode.value == ThemeMode.dark;

  static void toggleDarkMode(bool isDark) {
    themeMode.value = isDark ? ThemeMode.dark : ThemeMode.light;
  }

  static void setLanguage(String language) {
    selectedLanguage.value = language;
  }
}