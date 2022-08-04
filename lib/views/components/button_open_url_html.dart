import 'package:flutter/material.dart';
import 'package:hd_splash_flutter/app/config/app_assets.dart';
import 'package:url_launcher/url_launcher.dart';

class ButtonOpenUrlHtml extends StatelessWidget {
  const ButtonOpenUrlHtml({Key? key, required this.uri}) : super(key: key);

  final String uri;
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () async {
          Uri url = Uri.parse(uri);
          try {
            if (await canLaunchUrl(url)) {}
            await launchUrl(
              url,
              mode: LaunchMode.externalApplication,
            );
          } catch (e) {
            debugPrint(e.toString());
          }
        },
        icon: const Icon(Icons.language));
  }
}
