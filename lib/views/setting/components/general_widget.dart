import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hd_splash_flutter/logic/cubits/app_setting/app_setting_cubit.dart';
import 'package:hd_splash_flutter/views/setting/components/dialog_widget/language_dialog.dart';
import 'dialog_widget/bottom_button_dialog.dart';
import 'dialog_widget/theme_dialog.dart';
import 'item_block.dart';

class GeneralWidget extends StatelessWidget {
  const GeneralWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "General",
          style: textTheme.titleLarge,
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(16)),
          child: Column(
            children: [
              BlocBuilder<AppSettingCubit, AppSettingState>(
                buildWhen: (previous, current) =>
                    previous.locale != current.locale,
                builder: (context, state) {
                  return ItemBlock(
                    icon: const Icon(Icons.language),
                    title: "Language",
                    subtitle: state.locale.languageCode,
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: ((context) => LanguageDialog(
                                localeValue: ValueNotifier(state.locale),
                                onChangeLocale: (locale) => context
                                    .read<AppSettingCubit>()
                                    .changeLocale(locale),
                              )));
                    },
                  );
                },
              ),
              const SizedBox(
                height: 16,
              ),
              BlocBuilder<AppSettingCubit, AppSettingState>(
                buildWhen: (previous, current) =>
                    previous.themeMode != current.themeMode,
                builder: (context, state) {
                  return ItemBlock(
                    icon: const Icon(Icons.light_mode),
                    title: "Theme",
                    subtitle: state.themeMode.name,
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: ((context) => ThemeDialog(
                                themeMode: ValueNotifier(state.themeMode),
                                onChangeThemeMode: (themeMode) => context
                                    .read<AppSettingCubit>()
                                    .changeThemeMode(themeMode),
                              )));
                    },
                  );
                },
              ),
              const SizedBox(
                height: 16,
              ),
              ItemBlock(
                icon: const Icon(Icons.grid_view),
                title: "Gird",
                subtitle: "2",
                onTap: () {
                  print("object");
                },
              )
            ],
          ),
        ),
        const SizedBox(
          height: 24,
        ),
      ],
    );
  }
}

