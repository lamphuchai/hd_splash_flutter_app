import 'package:flutter/material.dart';
import 'package:hd_splash_flutter/app/extensions/extensions.dart';
import 'package:hd_splash_flutter/app/locale/lang_code.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog(
      {Key? key, required this.contentText, required this.onAction})
      : super(key: key);
  final String contentText;
  final VoidCallback onAction;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Wrap(
          children: [
            const SizedBox(
              width: double.infinity,
              height: 20,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                context.lang(LangCode.notification),
                style: textTheme.titleMedium,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25, bottom: 15),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  contentText,
                  style: textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: onAction,
                    child: Text(context.lang(LangCode.delete),
                        style: textTheme.titleMedium!
                            .copyWith(color: const Color(0xff34ace0)))),
                const SizedBox(
                  width: 10,
                ),
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(context.lang(LangCode.cancel),
                        style:
                            textTheme.titleMedium!.copyWith(color: Colors.red)))
              ],
            ),
            const SizedBox(
              width: double.infinity,
              height: 6,
            ),
          ],
        ),
      ),
    );
  }
}
