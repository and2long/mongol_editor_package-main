import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Utils/app_setting.dart';

class TextStyleController extends GetxController {
  var _style = TextStyle(
    fontSize: AppSetting.fontSize,
    color: AppSetting.instance.textColor,
    fontFamily: AppSetting.instance.fontFamily,
    shadows: [
      Shadow(
        offset: Offset(2, -2),
        blurRadius: 3,
        color: AppSetting.instance.shadowColor,
      ),
    ],
  ).obs;

  var _borderStyle = TextStyle(
    fontSize: AppSetting.fontSize,
    fontFamily: AppSetting.instance.fontFamily,
    shadows: [
      Shadow(
        offset: Offset(2, -2),
        blurRadius: AppSetting.instance.shadowBlurRadius,
        color: AppSetting.instance.shadowColor,
      ),
    ],
    foreground: Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = AppSetting.instance.borderThickness
      ..color = AppSetting.instance.borderColor,
  ).obs;

  /// used for base text style
  TextStyle get style => _style.value;

  /// used for edited image text style
  TextStyle get borderStyle => _borderStyle.value;

  bool textShadowAble = false;

  copyValueFrom(String tag) {
    _style.value = Get.find<TextStyleController>(tag: tag).style;
    _borderStyle.value = Get.find<TextStyleController>(
      tag: 'border_style_$tag',
    ).borderStyle;
  }

  setFontSize(double value) {
    _style.value = _style.value.copyWith(fontSize: value);
    _borderStyle.value = _borderStyle.value.copyWith(fontSize: value);
    print('update fontsize ${style.fontSize}');
  }

  increaseFontSize() {
    _style.value = _style.value.copyWith(fontSize: _style.value.fontSize! + 2);
    _borderStyle.value = _borderStyle.value.copyWith(
      fontSize: _style.value.fontSize! + 2,
    );
    print('update fontsize ${style.fontSize}');
  }

  decreaseFontSize() {
    _style.value = _style.value.copyWith(fontSize: _style.value.fontSize! - 2);
    _borderStyle.value = _borderStyle.value.copyWith(
      fontSize: _style.value.fontSize! - 2,
    );
    print('update fontsize ${style.fontSize}');
  }

  setColor(Color value) {
    _style.value = _style.value.copyWith(color: value);
    debugPrint('Text color set to $value');
    AppSetting.instance.textColor = value;
  }

  setShadowColor(Color value) {
    var shadow = Shadow(
      color: value,
      offset: Offset(2, -2),
      blurRadius: AppSetting.instance.shadowBlurRadius,
    );
    _style.value = _style.value.copyWith(shadows: [shadow]);
    _borderStyle.value = _borderStyle.value.copyWith(shadows: [shadow]);
    debugPrint('Shadow color set to $value');
    AppSetting.instance.shadowColor = value;
  }

  setShadowBlurRadius(double value) {
    var shadow = Shadow(
      color: AppSetting.instance.shadowColor,
      offset: Offset(2, -2),
      blurRadius: value,
    );
    _style.value = _style.value.copyWith(shadows: [shadow]);
    _borderStyle.value = _borderStyle.value.copyWith(shadows: [shadow]);
    debugPrint('Shadow blur radius set to $value');
    AppSetting.instance.shadowBlurRadius = value;
  }

  setBorderColor(Color value) {
    _borderStyle.value = _borderStyle.value.copyWith(
      foreground: Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = AppSetting.instance.borderThickness
        ..color = value,
    );
    debugPrint('Border color set to $value');
    AppSetting.instance.borderColor = value;
  }

  setBorderThickness(double value) {
    _borderStyle.value = _borderStyle.value.copyWith(
      foreground: Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = value
        ..color = AppSetting.instance.borderColor,
    );
    debugPrint('Border thickness set to $value');
    AppSetting.instance.borderThickness = value;
  }

  setFontFamily(String value) {
    _style.value = _style.value.copyWith(fontFamily: value);
    _borderStyle.value = _borderStyle.value.copyWith(fontFamily: value);
    AppSetting.instance.fontFamily = value;
  }

  setTextShadow() {
    textShadowAble = !textShadowAble;
    if (textShadowAble) {
      _style.value = _style.value.copyWith(
        shadows: [
          Shadow(
            color: Colors.black.withOpacity(0.5),
            offset: Offset(2, -2),
            blurRadius: 2,
          ),
        ],
      );

      _borderStyle.value = _borderStyle.value.copyWith(
        shadows: [
          Shadow(
            color: Colors.black.withOpacity(0.5),
            offset: Offset(2, -2),
            blurRadius: 2,
          ),
        ],
      );
    } else {
      _style.value = _style.value.copyWith(
        shadows: [
          Shadow(color: Colors.transparent, offset: Offset.zero, blurRadius: 0),
        ],
      );
      _borderStyle.value = _borderStyle.value.copyWith(
        shadows: [
          Shadow(color: Colors.transparent, offset: Offset.zero, blurRadius: 0),
        ],
      );
    }
  }

  @override
  void onClose() {
    super.onClose();
    AppSetting.instance.save();
  }
}
