import 'package:flutter/material.dart';

class SharedPrefKeys {
  static const String languageCode = 'languageCode';
  static const String defaultCode = 'tk';
  static const String appLanguage = 'AppLanguage';
}

class Constants {
  static const baseUrl = 'https://106cargo.com.tm/api';
  // static const baseUrl = 'http://216.250.11.150/api';
  static const mustUpdate = '2.1.5';
}

class AppConstants {
  static const Locale defaultLocale = Locale('tk');
  static const List<Locale> supportedLocales = [
    Locale('en', 'US'),
    Locale('ru', 'RU'),
    Locale('tk', 'TM'),
  ];
}
