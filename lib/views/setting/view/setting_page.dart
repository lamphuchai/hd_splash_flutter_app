import 'package:flutter/material.dart';
import 'package:hd_splash_flutter/views/components/components.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomNestedScrollHead(
      title: "Cài đặt",
      body: Column(
        children: const [
          ListTile(
            title: Text("General"),
          ),
          ListTile(
            title: Text("Ngôn ngữ"),
            subtitle: Text("Tiếng việt"),
          ),
          ListTile(
            title: Text("Chủ đề"),
            subtitle: Text("Sáng"),
          ),
          ListTile(
            title: Text("Layout"),
            subtitle: Text("List"),
          ),
          ListTile(
            title: Text("Quality"),
          ),
          ListTile(
            title: Text("Load Quality"),
            subtitle: Text("Regular"),
          ),
        ],
      ),
    );
  }
}
