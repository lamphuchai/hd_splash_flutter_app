import 'package:flutter/material.dart';

import 'bottom_button_dialog.dart';

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
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Wrap(
          children: [
            const SizedBox(
              width: double.infinity,
              height: 25,
            ),
            Text(
              "Theme",
              style: textTheme.titleMedium,
            ),
            const SizedBox(
              width: double.infinity,
              height: 14,
            ),
            ValueListenableBuilder(
              valueListenable: themeMode,
              builder: (BuildContext context, value, Widget? child) {
                return Column(
                  children: ThemeMode.values
                      .map((theme) => Row(
                            children: [
                              Checkbox(
                                value: theme == themeMode.value ? true : false,
                                onChanged: (value) {
                                  if (value == true) {
                                    themeMode.value = theme;
                                  }
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4)),
                              ),
                              Text(
                                theme.name,
                                style: textTheme.bodyMedium,
                              ),
                            ],
                          ))
                      .toList(),
                );
              },
            ),
            BottomButtonDialog(
              onSubmit: () {
                onChangeThemeMode(themeMode.value);
                Navigator.pop(context);
              },
            ),
            const SizedBox(
              width: double.infinity,
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
