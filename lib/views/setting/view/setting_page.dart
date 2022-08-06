import 'package:flutter/material.dart';
import 'package:hd_splash_flutter/app/extensions/extensions.dart';
import 'package:hd_splash_flutter/app/locale/lang_code.dart';
import 'package:hd_splash_flutter/views/setting/setting.dart';


class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Text(
              context.lang(LangCode.setting),
              style: textTheme.headlineLarge,
            ),
          ),
          const GeneralWidget(),
          const QualityWidget(),
        ],
      ),
    );
  }
}
