import 'package:flutter/material.dart';
import 'package:hd_splash_flutter/app/locale/app_localizations.dart';
import 'package:hd_splash_flutter/core/type/enum.dart';
import 'package:intl/intl.dart';
import 'package:unsplash_dart/unsplash_dart.dart';

extension ColorX on String {
  Color get converterColor => Color(int.parse(replaceAll("#", "0xff")));
}

extension AppContext on BuildContext {
  Size get screenSize => MediaQuery.of(this).size;
  double countHeightPhoto(
      {required int height, required int width, required crossAxisCount}) {
    return (height / width) * (screenSize.width / crossAxisCount);
  }

  String lang(String key) => AppLocalizations.of(this).translate(key);
}

extension StringX on String {
  String get formatTimeString {
    return DateFormat("dd-MM-yyyy").format(DateTime.parse(this));
  }

  String? get checkNullString => this == "" ? null : this;
}

extension EnumX on Enum {
  String get nameString => name;
}

extension PhotoURl on Urls {
  String photoUrl(LoadQualityType type) {
    switch (type) {
      case LoadQualityType.full:
        return full;
      case LoadQualityType.raw:
        return raw;
      case LoadQualityType.regular:
        return regular;
      case LoadQualityType.small:
        return small;
      case LoadQualityType.thumb:
        return thumb;
      default:
        break;
    }
    return regular;
  }
}
