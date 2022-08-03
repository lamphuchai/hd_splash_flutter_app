part of 'app_setting_cubit.dart';

class AppSettingState extends Equatable {
  const AppSettingState(
      {required this.themeMode, required this.locale, required this.layout});

  final ThemeMode themeMode;
  final Locale locale;
  final int layout;

  Map<String, dynamic> toMap() {
    return {
      "themeMode": themeMode.index,
      "locale": locale.languageCode,
      "layout": layout
    };
  }

  factory AppSettingState.fromMap(Map<String, dynamic> map) {
    return AppSettingState(
        themeMode: ThemeMode.values[map["themeMode"] as int],
        locale: LocaleConfig.supportedLanguages[map["locale"]] ??
            LocaleConfig.localeDefault,
        layout: map["layout"]);
  }

  @override
  List<Object> get props => [themeMode, locale, layout];

  AppSettingState copyWith({
    ThemeMode? themeMode,
    Locale? locale,
    int? layout,
  }) {
    return AppSettingState(
      themeMode: themeMode ?? this.themeMode,
      locale: locale ?? this.locale,
      layout: layout ?? this.layout,
    );
  }
}
