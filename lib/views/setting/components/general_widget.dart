import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hd_splash_flutter/logic/cubits/app_setting/app_setting_cubit.dart';
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
              ItemBlock(
                icon: const Icon(Icons.language),
                title: "Ngôn ngữ",
                subtitle: "Viet nam",
                onTap: () {
                  print("object");
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

class ThemeDialog extends StatelessWidget {
  const ThemeDialog({
    Key? key,
    required this.themeMode,
    required this.onChangeThemeMode,
  }) : super(key: key);

  final ValueNotifier<ThemeMode> themeMode;
  final Function(ThemeMode) onChangeThemeMode;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final List<Map<String, dynamic>> items = [
      {"themeMode": ThemeMode.system, "title": "system"},
      {"themeMode": ThemeMode.light, "title": "light"},
      {"themeMode": ThemeMode.dark, "title": "dark"}
    ];
    return Dialog(
      child: Container(
        height: 255,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              "Theme",
              style: textTheme.titleMedium,
            ),
            const SizedBox(
              height: 8,
            ),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: themeMode,
                builder: (BuildContext context, value, Widget? child) {
                  return Column(
                    children: items
                        .map((item) => Row(
                              children: [
                                Checkbox(
                                  value: item["themeMode"] == themeMode.value
                                      ? true
                                      : false,
                                  onChanged: (value) {
                                    if (value == true) {
                                      themeMode.value = item["themeMode"];
                                    }
                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4)),
                                ),
                                Text(
                                  item["title"],
                                  style: textTheme.bodyMedium,
                                ),
                              ],
                            ))
                        .toList(),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    onChangeThemeMode(themeMode.value);
                    Navigator.pop(context);
                  },
                  child: Text(
                    "OK",
                    style: textTheme.titleSmall!.copyWith(color: Colors.blue),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "Cancel",
                    style: textTheme.titleSmall!.copyWith(color: Colors.red),
                  ),
                ),
                const SizedBox(
                  width: 10,
                )
              ],
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
