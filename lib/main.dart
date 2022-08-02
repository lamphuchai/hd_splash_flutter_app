import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'views/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setSystemUIOverlayStyle(
  //   const SystemUiOverlayStyle(
  //       statusBarColor: Colors.transparent, statusBarBrightness: Brightness.dark
  //       // systemOverlayStyle: SystemUiOverlayStyle.dark
  //       ),
  // );
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
    statusBarColor: Colors.transparent, // optional
  ));
  runApp(const App());
}
