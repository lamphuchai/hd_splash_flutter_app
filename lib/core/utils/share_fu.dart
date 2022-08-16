import 'dart:developer';

import 'package:share_plus/share_plus.dart';

Future<void> share(String text) async {
  try {
    await Share.share(
      text,
    );
  } catch (error) {
    log(error.toString());
  }
}
