import 'package:flutter/material.dart';

import 'bottom_button_dialog.dart';

class GirdDialog extends StatelessWidget {
  const GirdDialog(
      {Key? key, required this.selectedValue, required this.onChange})
      : super(key: key);
  final ValueNotifier<int> selectedValue;
  final Function(int) onChange;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    List<Map<String, dynamic>> listGird = [
      {"icon": const Icon(Icons.list), "value": 1},
      {"icon": const Icon(Icons.grid_view), "value": 2},
      {"icon": const Icon(Icons.grid_3x3), "value": 3},
      {"icon": const Icon(Icons.grid_4x4), "value": 4},
    ];
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
              "Row Item Gird",
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
                  children: listGird
                      .map((locale) => Row(
                            children: [
                              Checkbox(
                                value: locale['value'] == selectedValue.value
                                    ? true
                                    : false,
                                onChanged: (value) {
                                  if (value == true) {
                                    selectedValue.value = locale['value'];
                                  }
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4)),
                              ),
                              Text(
                                locale['value'].toString(),
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