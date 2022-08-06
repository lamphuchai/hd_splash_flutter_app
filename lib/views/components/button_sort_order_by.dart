import 'package:flutter/material.dart';
import '../../app/extensions/extensions.dart';

class ButtonSortOrderBy extends StatelessWidget {
  const ButtonSortOrderBy(
      {Key? key,
      required this.listValue,
      required this.selected,
      required this.onSelected})
      : super(key: key);
  final List<Enum> listValue;
  final Enum selected;
  final ValueChanged onSelected;
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<Enum>(
        position: PopupMenuPosition.under,
        icon: const Icon(Icons.sort),
        onSelected: onSelected,
        color: Theme.of(context).primaryColor,
        itemBuilder: ((context) {
          return listValue
              .map((orderBy) => PopupMenuItem(
                  value: orderBy,
                  child: TickSelectedWidget(
                      value: orderBy == selected ? true : false,
                      title: orderBy.nameString)))
              .toList();
        }));
  }
}

class TickSelectedWidget extends StatelessWidget {
  const TickSelectedWidget({Key? key, required this.value, required this.title})
      : super(key: key);
  final bool value;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 15,
          height: 15,
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColorLight,
              borderRadius: BorderRadius.circular(20)),
          child: Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                borderRadius: BorderRadius.circular(20)),
            child: value
                ? Container(
                    // margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColorLight,
                        borderRadius: BorderRadius.circular(20)))
                : null,
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        Text(title)
      ],
    );
  }
}
