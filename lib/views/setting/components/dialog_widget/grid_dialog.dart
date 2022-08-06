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
      {"icon": Icons.list, "value": 1},
      {"icon": Icons.grid_view, "value": 2},
      {"icon": Icons.grid_3x3, "value": 3},
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
                      .map((item) => Row(
                            children: [
                              Checkbox(
                                value: item['value'] == selectedValue.value
                                    ? true
                                    : false,
                                onChanged: (value) {
                                  if (value == true) {
                                    selectedValue.value = item['value'];
                                  }
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4)),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                item['value'].toString(),
                                style: textTheme.bodyMedium,
                              ),
                              const SizedBox(
                                width: 30,
                              ),
                              Icon(item["icon"])
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
