import 'package:flutter/material.dart';

class EmptyDataWidget extends StatelessWidget {
  const EmptyDataWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.snowing,
            size: 40,
          ),
          SizedBox(
            height: 10,
          ),
          Text("[---]")
        ],
      ),
    );
  }
}
