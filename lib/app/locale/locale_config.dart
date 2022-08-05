import 'package:flutter/material.dart';

class LocaleConfig {

  static Locale get localeDefault =>const  Locale('en', 'US');
  static Map<String, Locale> supportedLanguages = {
    'en': const Locale('en', 'US'),
    'vi': const Locale('vi', 'VN'),
  };
  static const supportedLocales =  [
    Locale('en', 'US'),
    Locale('vi', 'VN')
  ];
}