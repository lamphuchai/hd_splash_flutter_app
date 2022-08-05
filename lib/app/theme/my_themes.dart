import 'package:flutter/material.dart';

import 'my_fonts.dart';
import 'my_styles.dart';

class MyThemes {
  static final lightTheme = ThemeData(
      primaryColor: Colors.black12,
      backgroundColor: Colors.white,
      scaffoldBackgroundColor: Colors.white,
      splashColor: Colors.transparent,
      primaryColorLight: Colors.black87,
      dialogTheme: DialogTheme(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
      //app bar theme
      appBarTheme: MyStyles.appBarThemeLight,
      popupMenuTheme: MyStyles.popupMenuThemeDataLight,
      tabBarTheme: TabBarTheme(
          labelColor: Colors.black,
          labelStyle: MyFonts.textThemeLight.titleSmall,
          unselectedLabelStyle: MyFonts.textThemeLight.titleSmall),
      //app text theme
      textTheme: MyFonts.textThemeLight,
      listTileTheme: const ListTileThemeData(iconColor: Colors.black),
      drawerTheme: MyStyles.drawerThemeDataLight,
      iconTheme: const IconThemeData(color: Colors.black),
      navigationBarTheme: NavigationBarThemeData(
          backgroundColor: Colors.white,
          iconTheme: MaterialStateProperty.resolveWith(
              (Set<MaterialState> states) =>
                  const IconThemeData(color: Colors.black))),
      bottomSheetTheme: MyStyles.bottomSheetThemeLight,
      checkboxTheme: MyStyles.checkboxThemeDataLight);

  static final darkTheme = ThemeData(
      primaryColor: const Color(0xff1C1C23),
      backgroundColor: const Color(0xff0E0E12),
      scaffoldBackgroundColor: const Color(0xff0E0E12),
      primaryColorLight: Colors.white,
      brightness: Brightness.light,
      tabBarTheme: TabBarTheme(
          labelColor: Colors.white,
          labelStyle: MyFonts.textThemeDark.titleSmall,
          unselectedLabelStyle: MyFonts.textThemeLight.titleSmall),
      dialogTheme: DialogTheme(
          backgroundColor: const Color(0xff1C1C23),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
      //app bar theme
      appBarTheme: MyStyles.appBarThemeDark,
      popupMenuTheme: MyStyles.popupMenuThemeDataDark,
      splashColor: Colors.transparent,

      //app text theme
      textTheme: MyFonts.textThemeDark,
      listTileTheme: const ListTileThemeData(iconColor: Colors.white),
      drawerTheme: MyStyles.drawerThemeDataDark,
      iconTheme: const IconThemeData(color: Colors.white),
      navigationBarTheme: NavigationBarThemeData(
          indicatorColor: const Color(0xff666680),
          backgroundColor: const Color(0xff0E0E12),
          iconTheme: MaterialStateProperty.resolveWith(
              (Set<MaterialState> states) =>
                  const IconThemeData(color: Colors.white))),
      bottomSheetTheme: MyStyles.bottomSheetThemeDark,
      checkboxTheme: MyStyles.checkboxThemeDataDark);
}
