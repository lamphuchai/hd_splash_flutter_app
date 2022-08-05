import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hd_splash_flutter/app/locale/locale_config.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'app_setting_state.dart';

class AppSettingCubit extends Cubit<AppSettingState> with HydratedMixin {
  AppSettingCubit()
      : super(AppSettingState(
          themeMode: ThemeMode.system,
          locale: LocaleConfig.localeDefault,
          crossAxisCountGird: 2,
        ));

  void changeLayout(int crossAxisCountGird) => emit(state.copyWith(
        crossAxisCountGird: crossAxisCountGird,
      ));

  void changeThemeMode(ThemeMode themeMode) =>
      emit(state.copyWith(themeMode: themeMode));

  void changeLocale(Locale locale) => emit(state.copyWith(locale: locale));

  @override
  AppSettingState? fromJson(Map<String, dynamic> json) {
    return AppSettingState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(AppSettingState state) {
    return state.toMap();
  }
}
