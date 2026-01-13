import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/keyboard_controller.dart';

import 'KeyActionNormal.dart';

class KeyLanguage extends StatelessWidget {
  final int keyboardType;

  const KeyLanguage({Key? key, required this.keyboardType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KeyActionNormal(
      icon: Icons.language,
      function: () {
        Get.find<KeyboardController>().changeKeyboardType(keyboardType);
      },
    );
  }
}
