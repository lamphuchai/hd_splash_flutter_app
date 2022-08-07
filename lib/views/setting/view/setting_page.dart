import 'package:flutter/material.dart';
import 'package:hd_splash_flutter/app/extensions/extensions.dart';
import 'package:hd_splash_flutter/app/locale/lang_code.dart';
import 'package:hd_splash_flutter/views/setting/setting.dart';
import 'package:path_provider/path_provider.dart';

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
          ElevatedButton(
              onPressed: () async {
                // await DefaultCacheManager().emptyCache();
                final cacheDir = await getTemporaryDirectory();
                if (cacheDir.existsSync()) {
                  cacheDir.deleteSync(recursive: true);
                }
                final appDir = await getApplicationSupportDirectory();
                if (appDir.existsSync()) {
                  appDir.deleteSync(recursive: true);
                }
              },
              child: const Text("clear cache"))
        ],
      ),
    );
  }
}
