import 'package:flutter/material.dart';

import 'dark_theme_colors.dart';
import 'light_theme_colors.dart';
import 'my_fonts.dart';

class MyStyles {
  //app bar theme
  static AppBarTheme appBarThemeLight = AppBarTheme(
      titleTextStyle: MyFonts.textThemeLight.titleLarge,
      backgroundColor: LightThemeColors.appBarColor,
      elevation: 0,
      iconTheme: const IconThemeData(color: LightThemeColors.iconColor));

  static AppBarTheme appBarThemeDark = AppBarTheme(
      titleTextStyle: MyFonts.textThemeDark.titleLarge,
      backgroundColor: DarkThemeColors.appBarColor,
      elevation: 0,
      iconTheme: const IconThemeData(color: DarkThemeColors.iconColor));

  // bottom sheet theme data
  static BottomSheetThemeData bottomSheetThemeLight =
      const BottomSheetThemeData(
          backgroundColor: LightThemeColors.bottomSheetColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(15))));
  static BottomSheetThemeData bottomSheetThemeDark = const BottomSheetThemeData(
      backgroundColor: Color(0xff1C1C23),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15))));

  static const navigationRailThemeData = NavigationRailThemeData();
  // drawer theme data
  static const drawerThemeDataLight =
      DrawerThemeData(backgroundColor: LightThemeColors.drawerColor);
  static const drawerThemeDataDark =
      DrawerThemeData(backgroundColor: DarkThemeColors.drawerColor);

  static const tabBarTheme = TabBarTheme();

  static final popupMenuThemeDataLight = PopupMenuThemeData(
      color: Colors.grey[100],
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(color: Colors.black26)));

  static final popupMenuThemeDataDark = PopupMenuThemeData(
      color: const Color(0xff1C1C23),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(color: Colors.black26)));

  static const checkboxThemeDataLight =
      CheckboxThemeData(side: BorderSide(color: Colors.grey));
  static const checkboxThemeDataDark =
      CheckboxThemeData(side: BorderSide(color: Colors.grey));
}
