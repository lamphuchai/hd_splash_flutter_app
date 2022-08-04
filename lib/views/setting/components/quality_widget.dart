import 'package:flutter/material.dart';

import 'item_block.dart';

class QualityWidget extends StatelessWidget {
  const QualityWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Quality",
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
                icon: const Icon(Icons.workspaces),
                title: "Load Quality",
                subtitle: "Reqular",
                onTap: () {
                  print("object");
                },
              ),
              const SizedBox(
                height: 16,
              ),
              ItemBlock(
                icon: const Icon(Icons.download),
                title: "Download quality",
                subtitle: "Reqular",
                onTap: () {
                  print("object");
                },
              ),
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
