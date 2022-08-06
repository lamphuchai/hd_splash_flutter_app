import 'package:flutter/material.dart';
import 'package:hd_splash_flutter/app/extensions/extensions.dart';
import 'package:hd_splash_flutter/app/locale/lang_code.dart';

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
            context.lang(LangCode.ok),
            style: textTheme.titleSmall!.copyWith(color: Colors.blue),
          ),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            context.lang(LangCode.cancel),
            style: textTheme.titleSmall!.copyWith(color: Colors.red),
          ),
        ),
      ],
    );
  }
}
