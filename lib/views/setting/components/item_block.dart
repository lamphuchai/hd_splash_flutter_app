import 'package:flutter/material.dart';

class ItemBlock extends StatelessWidget {
  const ItemBlock(
      {Key? key,
      required this.title,
      required this.subtitle,
      this.icon,
      this.onTap})
      : super(key: key);
  final String title;
  final String subtitle;
  final Widget? icon;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            flex: 2,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (icon != null) ...[
                  icon!,
                  const SizedBox(
                    width: 20,
                  ),
                ],
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium,
                )
              ],
            )),
        Expanded(
            child: GestureDetector(
          onTap: onTap,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodySmall,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.end,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              const Icon(Icons.navigate_next),
            ],
          ),
        ))
      ],
    );
  }
}
