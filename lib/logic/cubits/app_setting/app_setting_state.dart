part of 'app_setting_cubit.dart';

class AppSettingState extends Equatable {
  const AppSettingState({
    required this.themeMode,
    required this.locale,
    required this.crossAxisCountGird,
  });

  final ThemeMode themeMode;
  final Locale locale;
  final int crossAxisCountGird;

  Map<String, dynamic> toMap() {
    return {
      "themeMode": themeMode.index,
      "locale": locale.languageCode,
      "layout": crossAxisCountGird,
    };
  }

  factory AppSettingState.fromMap(Map<String, dynamic> map) {
    return AppSettingState(
      themeMode: ThemeMode.values[map["themeMode"] as int],
      locale: LocaleConfig.supportedLanguages[map["locale"]] ??
          LocaleConfig.localeDefault,
      crossAxisCountGird: map["layout"],
    );
  }

  @override
  List<Object> get props => [themeMode, locale, crossAxisCountGird];

  AppSettingState copyWith({
    ThemeMode? themeMode,
    Locale? locale,
    int? crossAxisCountGird,
  }) {
    return AppSettingState(
      themeMode: themeMode ?? this.themeMode,
      locale: locale ?? this.locale,
      crossAxisCountGird: crossAxisCountGird ?? this.crossAxisCountGird,
    );
  }
}
