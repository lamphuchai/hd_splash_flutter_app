import 'package:flutter/material.dart';

class ItemTotal extends StatelessWidget {
  const ItemTotal({Key? key, required this.title, required this.total})
      : super(key: key);
  final String title;
  final String total;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          FittedBox(
            child: Text(
              total,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(title),
        ],
      ),
    );
  }
}
