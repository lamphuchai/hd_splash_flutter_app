import 'package:flutter/material.dart';
import 'package:hd_splash_flutter/app/extensions/extensions.dart';
import 'package:hd_splash_flutter/app/locale/lang_code.dart';
import 'package:hd_splash_flutter/core/type/enum.dart';
import 'bottom_button_dialog.dart';

class LoadQualityDialog extends StatelessWidget {
  const LoadQualityDialog(
      {Key? key, required this.selectedValue, required this.onChange})
      : super(key: key);
  final ValueNotifier<LoadQualityType> selectedValue;
  final Function(LoadQualityType) onChange;

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
              context.lang(LangCode.subQuality),
              style: textTheme.titleMedium,
            ),
            const SizedBox(
              width: double.infinity,
              height: 14,
            ),
            ValueListenableBuilder(
              valueListenable: selectedValue,
              builder: (BuildContext context, value, Widget? child) {
                return Column(
                  children: LoadQualityType.values
                      .map((item) => Row(
                            children: [
                              Checkbox(
                                value:
                                    item == selectedValue.value ? true : false,
                                onChanged: (value) {
                                  if (value == true) {
                                    selectedValue.value = item;
                                  }
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4)),
                              ),
                              const SizedBox(width: 15),
                              Text(
                                item.name,
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
                onChange(selectedValue.value);
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
