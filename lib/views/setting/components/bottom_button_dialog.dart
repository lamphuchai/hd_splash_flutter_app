import 'package:flutter/material.dart';

class BottomButtonDialog extends StatelessWidget {
  const BottomButtonDialog({Key? key, required this.onSubmit})
      : super(key: key);
  final VoidCallback onSubmit;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: onSubmit,
          child: Text(
            "OK",
            style: textTheme.titleSmall!.copyWith(color: Colors.blue),
          ),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            "Cancel",
            style: textTheme.titleSmall!.copyWith(color: Colors.red),
          ),
        ),
      ],
    );
  }
}
