import 'package:flutter/material.dart';

extension ColorX on String {
  Color get converterColor => Color(int.parse(replaceAll("#", "0xff")));
}

extension AppContext on BuildContext {
  Size get screenSize => MediaQuery.of(this).size;

  double countHeightPhoto(
      {required int height, required int width, required crossAxisCount}) {
    return (height / width) * (screenSize.width / crossAxisCount);
  }
}
