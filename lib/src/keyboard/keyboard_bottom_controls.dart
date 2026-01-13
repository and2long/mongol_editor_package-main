import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/keyboard_controller.dart';
import './key_language.dart';

import 'KeyAction.dart';
import 'KeySpacebar.dart';
import 'KeySymbol.dart';

class KeyboardBottomControls extends StatelessWidget {
  final int nextLanguageType;
  const KeyboardBottomControls({Key? key, required this.nextLanguageType})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        KeyAction(
          text: '123',
          function: () {
            //切换到符号键盘
            Get.find<KeyboardController>().changeKeyboardType(2);
          },
        ),
        KeyLanguage(keyboardType: nextLanguageType),
        KeySymbol(','),
        KeySpacebar(),
        KeySymbol('.'),
        GetBuilder<KeyboardController>(
          id: 'latin',
          builder: (ctr) => KeyAction(
            icon: Icons.keyboard_return,
            function: () {
              ctr.latin.isNotEmpty ? ctr.enterAction(null) : ctr.addText('\n');
            },
          ),
        ),
      ],
    );
  }
}
