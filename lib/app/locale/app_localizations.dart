import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'lang/en.dart';
import 'lang/vi.dart';
import 'locale_config.dart';

class AppLocalizations {
  AppLocalizations(this.locale);

  final Locale locale;
  late Map<String, String> localizedStrings;

  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = [
    _AppLocalizationsDelegate(),
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];

  static const supportedLocales = LocaleConfig.supportedLocales;
  static const supportedLocalesList = LocaleConfig.supportedLocales;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  Future<bool> load() async {
    switch (locale.languageCode) {
      case "vi":
        localizedStrings = vi;
        break;
      case "en":
        localizedStrings = en;
        break;
      default:
        break;
    }

    return true;
  }

  // This method will be called from every widget which needs a localized text
  String translate(String key) {
    return localizedStrings[key] ?? 'no-key:$key';
  }
}

// LocalizationsDelegate is a factory for a set of localized resources
// In this case, the localized strings will be gotten in an AppLocalizations object
class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  // ignore: non_constant_identifier_names
  final String TAG = "AppLocalizations";

  // This delegate instance will never change (it doesn't even have fields!)
  // It can provide a constant constructor.
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    // Include all of your supported language codes here
    return ['en', 'vi'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    // AppLocalizations class is where the JSON loading actually runs
    AppLocalizations localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
