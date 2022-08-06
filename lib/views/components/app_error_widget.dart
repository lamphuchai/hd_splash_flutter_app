import 'package:flutter/material.dart';


class AppErrorWidget extends StatelessWidget {
  const AppErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Icon(
        Icons.error_outline_rounded,
        color: Colors.red,
      ),
    );
  }
}
