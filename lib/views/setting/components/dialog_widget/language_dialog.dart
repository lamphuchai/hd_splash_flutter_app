import 'package:flutter/material.dart';
import 'package:hd_splash_flutter/app/extensions/extensions.dart';
import 'package:hd_splash_flutter/app/locale/app_localizations.dart';
import 'package:hd_splash_flutter/app/locale/lang_code.dart';

import 'bottom_button_dialog.dart';

class LanguageDialog extends StatelessWidget {
  const LanguageDialog(
      {Key? key, required this.localeValue, required this.onChangeLocale})
      : super(key: key);
  final ValueNotifier<Locale> localeValue;
  final Function(Locale) onChangeLocale;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    const locales = AppLocalizations.supportedLocalesList;

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
              context.lang(LangCode.language),
              style: textTheme.titleMedium,
            ),
            const SizedBox(
              width: double.infinity,
              height: 14,
            ),
            ValueListenableBuilder(
              valueListenable: localeValue,
              builder: (BuildContext context, value, Widget? child) {
                return Column(
                  children: locales
                      .map((locale) => Row(
                            children: [
                              Checkbox(
                                value:
                                    locale == localeValue.value ? true : false,
                                onChanged: (value) {
                                  if (value == true) {
                                    localeValue.value = locale;
                                  }
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4)),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                context.lang(locale.languageCode),
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
                onChangeLocale(localeValue.value);
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
