import 'package:flutter/material.dart';
import 'package:hd_splash_flutter/views/components/components.dart';
import 'package:hd_splash_flutter/views/setting/setting.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomNestedScrollHead(
      title: "Cài đặt",
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            GeneralWidget(),
            QualityWidget(),

            // Checkbox(value: true, onChanged: (v)
          ],
        ),
      ),
    );
  }
}
