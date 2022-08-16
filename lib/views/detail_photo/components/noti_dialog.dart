import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hd_splash_flutter/app/extensions/extensions.dart';
import 'package:hd_splash_flutter/app/locale/lang_code.dart';
import 'package:hd_splash_flutter/logic/cubits/auth/auth_cubit.dart';
import 'package:hd_splash_flutter/views/setting/components/dialog_widget/bottom_button_dialog.dart';

class NotificationDialog extends StatelessWidget {
  const NotificationDialog({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: Wrap(
          children: [
            const SizedBox(
              width: double.infinity,
              height: 15,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                context.lang(LangCode.notification),
                style: textTheme.titleMedium,
              ),
            ),
            const SizedBox(
              width: double.infinity,
              height: 20,
            ),
            Text(
              context.lang(LangCode.subNotificationAddAccount),
              textAlign: TextAlign.center,
              style: textTheme.bodyLarge,
            ),
            const SizedBox(
              width: double.infinity,
              height: 5,
            ),
            BottomButtonDialog(
              onSubmit: () {
                context.read<AuthCubit>().logIn();
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
