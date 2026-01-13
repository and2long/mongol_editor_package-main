import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/keyboard_controller.dart';
import './keyboard_bottom_controls.dart';

class KbEmoji extends StatelessWidget {
  const KbEmoji({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        EmojiPicker(
          onEmojiSelected: _onEmojiSelected,
          onBackspacePressed: () {
            Get.find<KeyboardController>().deleteOne();
          },
          config: Config(
            emojiViewConfig: EmojiViewConfig(
              columns: 9,
              // Enlarge emoji size because Flutter renders emojis in iOS slightly smaller
              // Issue: https://github.com/flutter/flutter/issues/28894
              emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
              verticalSpacing: 0,
              horizontalSpacing: 0,
              recentsLimit: 28,
              backgroundColor: const Color(0xFFF2F2F2),
              buttonMode: Platform.isIOS
                  ? ButtonMode.CUPERTINO
                  : ButtonMode.MATERIAL,
            ),
            categoryViewConfig: CategoryViewConfig(
              initCategory: Category.RECENT,
              indicatorColor: Colors.blue,
              iconColor: Colors.grey,
              iconColorSelected: Colors.blue,
              backspaceColor: Colors.blue,
              tabIndicatorAnimDuration: kTabScrollDuration,
              categoryIcons: const CategoryIcons(),
              backgroundColor: const Color(0xFFF2F2F2),
            ),
            bottomActionBarConfig: const BottomActionBarConfig(enabled: false),
          ),
        ),
        Positioned(
          bottom: 0,
          child: Container(
            color: const Color(0xFFF2F2F2),
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                SizedBox(height: 0.01 * MediaQuery.of(context).size.height),
                KeyboardBottomControls(nextLanguageType: 0),
                SizedBox(height: 0.01 * MediaQuery.of(context).size.height),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _onEmojiSelected(Category? category, Emoji emoji) {
    Get.find<KeyboardController>().enterAction(
      emoji.emoji,
      addExtraSpace: false,
    );
  }
}
