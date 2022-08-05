import 'package:flutter/material.dart';

class ButtonSortPhotos<T> extends StatelessWidget {
  const ButtonSortPhotos(
      {Key? key,
      required this.listValue,
      required this.value,
      required this.onSelected})
      : super(key: key);
  final List<T> listValue;
  final T value;
  final ValueChanged<T> onSelected;
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<T>(
        position: PopupMenuPosition.under,
        icon: const Icon(Icons.sort),
        onSelected: onSelected,
        itemBuilder: ((context) {
          return listValue
              .map((orderBy) => PopupMenuItem(
                  value: orderBy,
                  child: TickSelectedWidget(
                      value: orderBy == value ? true : false,
                      title: orderBy.toString().split('.')[1])))
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
