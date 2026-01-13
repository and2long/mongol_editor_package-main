import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSetting {
  static const String kContentFontFamily = 'CONTENT_FONT_FAMILY';
  static const String kContentColor = 'CONTENT_COLOR';
  static const String kBackgroundColor = 'BACKGROUND_COLOR'; // Image background
  static const String kShadowColor = 'CONTENT_SHADOW_COLOR';
  static const String kShadowBlurRadius = 'CONTENT_SHADOW_THICKNESS';
  static const String kBorderColor = 'CONTENT_BORDER_COLOR';
  static const String kBorderThickness = 'CONTENT_BORDER_THICKNESS';

  static const double fontSize = 26.0;

  Color textColor = const Color(0xff000000); // Default: Black
  String fontFamily = 'z52ordostig'; // Default font
  Color backgroundColor = Colors.transparent; // Default: Transparent
  Color shadowColor = Colors.transparent; // Default: Transparent
  double shadowBlurRadius = 3.0; // Default blur radius
  Color borderColor = Colors.transparent; // Default: Transparent
  double borderThickness = 8.0; // Default thickness

  AppSetting._privateConstructor();
  static final AppSetting _appSetting = AppSetting._privateConstructor();
  static AppSetting get instance {
    return _appSetting;
  }

  save() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // save font & image background settings
    await prefs.setString(kContentFontFamily, fontFamily);
    await prefs.setString(kContentColor, textColor.value.toRadixString(16));
    await prefs.setString(
      kBackgroundColor,
      backgroundColor.value.toRadixString(16),
    );

    // save shadow settings
    await prefs.setString(kShadowColor, shadowColor.value.toRadixString(16));
    await prefs.setDouble(kShadowBlurRadius, shadowBlurRadius);

    // save border settings
    await prefs.setString(kBorderColor, borderColor.value.toRadixString(16));
    await prefs.setDouble(kBorderThickness, borderThickness);
  }

  loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    fontFamily = prefs.getString(kContentFontFamily) ?? 'z52ordostig';

    String textColorHex = prefs.getString(kContentColor) ?? 'ff000000'; //Black
    textColor = hexToColor(textColorHex);

    String bgColorHex =
        prefs.getString(kBackgroundColor) ?? '00000000'; // Colors.transparent
    backgroundColor = hexToColor(bgColorHex);

    String shadowColorHex =
        prefs.getString(kShadowColor) ?? '00000000'; // Colors.transparent
    shadowColor = hexToColor(shadowColorHex);

    shadowBlurRadius = prefs.getDouble(kShadowBlurRadius) ?? 3;

    String borderColorHex =
        prefs.getString(kBorderColor) ?? '00000000'; //Transparent
    borderColor = hexToColor(borderColorHex);

    borderThickness = prefs.getDouble(kBorderThickness) ?? 8;
  }

  Color hexToColor(String hexStr) => Color(int.parse('0x$hexStr'));
}
