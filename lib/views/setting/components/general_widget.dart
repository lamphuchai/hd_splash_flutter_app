import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hd_splash_flutter/app/extensions/extensions.dart';
import 'package:hd_splash_flutter/app/locale/lang_code.dart';
import 'package:hd_splash_flutter/logic/cubits/app_setting/app_setting_cubit.dart';
import 'package:hd_splash_flutter/views/setting/components/dialog_widget/grid_dialog.dart';
import 'package:hd_splash_flutter/views/setting/components/dialog_widget/language_dialog.dart';
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
          context.lang(LangCode.general),
          style: textTheme.titleLarge,
        ),
        const SizedBox(
          height: 15,
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
                    title: context.lang(LangCode.language),
                    subtitle: context.lang(state.locale.languageCode),
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
                    title: context.lang(LangCode.theme),
                    subtitle: context.lang(state.themeMode.name),
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
              BlocBuilder<AppSettingCubit, AppSettingState>(
                buildWhen: (previous, current) =>
                    previous.crossAxisCountGird != current.crossAxisCountGird,
                builder: (context, state) {
                  return ItemBlock(
                    icon: const Icon(Icons.grid_view),
                    title: "Gird",
                    subtitle: state.crossAxisCountGird.toString(),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: ((context) => GirdDialog(
                              selectedValue:
                                  ValueNotifier(state.crossAxisCountGird),
                              onChange: (value) => context
                                  .read<AppSettingCubit>()
                                  .changeLayout(value))));
                    },
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
