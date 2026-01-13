import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/app_setting.dart';

class StyleController extends GetxController {
  var _backgroundColor = AppSetting.instance.backgroundColor.obs;
  Color get backgroundColor => _backgroundColor.value;

  var width = 250.0.obs;
  var height = 280.0.obs;

  copyValueFrom(String tag) {
    final sourceController = Get.find<StyleController>(tag: tag);
    width.value = sourceController.width.value;
    height.value = sourceController.height.value;
    setBackgroundColor(sourceController.backgroundColor);
  }

  setBackgroundColor(Color color) {
    _backgroundColor.value = color;
    debugPrint('Background color set to $color');
    AppSetting.instance.backgroundColor = color;
  }
}
