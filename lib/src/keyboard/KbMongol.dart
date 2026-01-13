import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/keyboard_controller.dart';
import './KeyBackspace.dart';
import './KeySpacebar.dart';

import 'KeyAction.dart';
import 'KeyActionNormal.dart';
import 'KeyMongol.dart';
import 'KeySymbol.dart';

class KBMongol extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double sw = MediaQuery.of(context).size.width;
    double sh = MediaQuery.of(context).size.height;

    return Container(
      width: sw,
      height: 0.05 * 3 * sh,
      color: Colors.grey.shade100,
      child: Column(
        children: <Widget>[
          // GetBuilder<KeyboardController>(
          //     id: 'latin', builder: (ctr) => Obx(() => Text(ctr.latin.value))),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    KeyMongol(title: 'q', mglChar: 'ᢚᡮ', mglShiftChar: 'ᡮ'),
                    KeyMongol(title: 'w', mglChar: 'ᢟᡮ'),
                    KeyMongol(title: 'e', mglChar: 'ᡥᡮ', mglShiftChar: 'ᢟᡮ'),
                    KeyMongol(title: 'r', mglChar: 'ᢞᡮ', mglShiftChar: 'ᢪᡮ'),
                    KeyMongol(title: 't', mglChar: 'ᢘᡮ', mglShiftChar: 'ᢙᡮ'),
                    KeyMongol(title: 'y', mglChar: 'ᢜᡮ'),
                    KeyMongol(title: 'u', mglChar: 'ᡥᡭᡬᡮ', mglShiftChar: 'ᡭᡬᡮ'),
                    KeyMongol(title: 'i', mglChar: 'ᡥᡬᡮ'),
                    KeyMongol(title: 'o', mglChar: 'ᡥᡭᡮ', mglShiftChar: 'ᡭᡮ'),
                    KeyMongol(title: 'p', mglChar: 'ᡶᡮ'),
                  ],
                ),
                SizedBox(height: 0.005 * sh),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    KeyMongol(title: 'a', mglChar: 'ᡥᡪᡮᡮ'),
                    KeyMongol(title: 's', mglChar: 'ᢔᡮᡮ'),
                    KeyMongol(title: 'd', mglChar: 'ᢙᡮ', mglShiftChar: 'ᢘᡮ'),
                    KeyMongol(title: 'f', mglChar: 'ᢡᡮ'),
                    KeyMongol(title: 'g', mglChar: 'ᢈᡮ', mglShiftChar: 'ᢊᡮ'),
                    KeyMongol(title: 'h', mglChar: 'ᡸᡮ', mglShiftChar: 'ᢊᡮ'),
                    KeyMongol(title: 'j', mglChar: 'ᡬᡮ'),
                    KeyMongol(title: 'k', mglChar: 'ᢤᡮ'),
                    KeyMongol(title: 'l', mglChar: 'ᢏᡮ', mglShiftChar: 'ᢏᢨᡮ'),
                  ],
                ),
                SizedBox(height: 0.005 * sh),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GetBuilder<KeyboardController>(
                      id: 'shift',
                      builder: (ctr) => KeyAction(
                        icon: Icons.file_upload,
                        function: () {
                          ctr.changeShiftState();
                        },
                        color: ctr.onShift ? Colors.blue : null,
                      ),
                    ),
                    KeyMongol(title: 'z', mglChar: 'ᢧᡮ', mglShiftChar: 'ᢨᡮ'),
                    KeyMongol(title: 'x', mglChar: 'ᢗᡮᡮ'),
                    KeyMongol(title: 'c', mglChar: 'ᢚᡮ', mglShiftChar: 'ᢦᡮ'),
                    KeyMongol(title: 'v', mglChar: 'ᡥᡭᡮ', mglShiftChar: 'ᡭᡮ'),
                    KeyMongol(title: 'b', mglChar: 'ᡳᡮ'),
                    KeyMongol(title: 'n', mglChar: 'ᡯᡮ'),
                    KeyMongol(title: 'm', mglChar: 'ᢌᡮ'),
                    GetBuilder<KeyboardController>(
                      builder: (ctr) => KeyBackspace(() {
                        if (ctr.latin.value.isNotEmpty) {
                          ctr.setLatin(
                            ctr.latin.substring(0, ctr.latin.value.length - 1),
                            isMongol: true,
                          );
                        } else {
                          ctr.deleteOne();
                        }
                      }),
                    ),
                  ],
                ),
                SizedBox(height: 0.005 * sh),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    KeyAction(
                      text: '123',
                      function: () {
                        Get.find<KeyboardController>().changeKeyboardType(2);
                      },
                    ),
                    KeyActionNormal(
                      icon: Icons.language,
                      function: () {
                        Get.find<KeyboardController>().changeKeyboardType(1);
                      },
                    ),
                    KeySymbol('᠂'),
                    KeySpacebar(),
                    KeySymbol('᠃'),
                    GetBuilder<KeyboardController>(
                      id: 'latin',
                      builder: (ctr) => KeyAction(
                        icon: Icons.keyboard_return,
                        function: () {
                          ctr.latin.isNotEmpty
                              ? ctr.enterAction(null)
                              : ctr.addText('\n');
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 0.01 * sh),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
