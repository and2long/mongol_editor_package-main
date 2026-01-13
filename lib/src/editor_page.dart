import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mongol/mongol.dart' hide MongolTooltip;
import 'components/mongol_tooltip.dart';
import 'components/mongol_fonts.dart';
import 'controllers/keyboard_controller.dart';
import 'controllers/text_controller.dart';
import 'controllers/style_controller.dart';
import 'keyboard/MongolKeyboard.dart';
import 'models/customizable_text.dart';
import 'widgets/delete_confirmation_dialog.dart';
import 'widgets/word_suggestions_section.dart';

///photoWithText
class EditorPage extends StatefulWidget {
  final bool editWithImage;
  final String? text;
  EditorPage({required this.editWithImage, this.text});

  @override
  _EditorPageState createState() => _EditorPageState();
}

class _EditorPageState extends State<EditorPage> {
  // late BannerAd? _adBanner;
  // late PaymentService _paymentService;
  bool overlayOffsetIsInitialed = false;
  FocusNode _focusNode = FocusNode();
  int cursorOffset = 0;
  bool editable = true;
  int layoutTime = 0;

  //double canvasWidth = 300.0;
  //   double canvasHeight = 480.0;
  List<String> teinIlgalCands = [
    'ᡭᡧ',
    'ᡬᡬᡧ',
    'ᡳ',
    "ᡭᡳ",
    "ᡳᡪᢝ",
    "ᡬᡬᡪᢝ",
    "ᡳᡪᡧ",
    "ᡬᡬᡪᡧ",
    'ᢘᡳ',
    'ᢙᡳ',
    'ᡬᡫ',
    'ᡫ',
    'ᡥᢚᡧ',
    "ᢘᡪᡫ",
    "ᡭᡭᡧ",
    "ᢘᡪᡱᡱᡪᡧ",
    "ᢘᡪᢊᡪᡧ",
    "ᢙᡪᡱᡱᡪᡧ",
    "ᢙᡪᢊᡪᡧ",
  ];

  @override
  void initState() {
    super.initState();
    // Force portrait mode
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    // _paymentService = Get.find<PaymentService>();

    // if (!_paymentService.isPremium) {
    // _adBanner = AdmobService.instance.createAdBanner();
    // _adBanner?.load();
    // } else {
    //   _adBanner = null;
    // }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      child: Stack(
        children: [
          WillPopScope(
            onWillPop: () async {
              // Allow going back without clearing text
              // Text will be preserved in memory (KeyboardController is singleton)
              return true;
            },
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  'Zmongol2.0',
                  style: TextStyle(
                    fontFamily: MongolFonts.z52ordostig,
                    color: Colors.white,
                  ),
                ),
                centerTitle: true,
                backgroundColor: Color(0xff0072AA),
                actions: [
                  // IconButton(
                  //   icon: Icon(Icons.help, color: Colors.white),
                  //   onPressed: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) => HelpEditPage(),
                  //       ), //Go to Donation page
                  //     );
                  //   },
                  // ),
                  // IconButton(
                  //   icon: Icon(
                  //     Icons.favorite,
                  //     color: Colors.white,
                  //   ), //Go to Donation page
                  //   onPressed: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) => Donation(),
                  //       ), //Go to Donation page
                  //     );
                  //   },
                  // ),
                  GetBuilder<KeyboardController>(
                    id: 'cands',
                    builder: (ctr) {
                      return IconButton(
                        icon: Icon(Icons.delete, color: Colors.white),
                        onPressed: ctr!.text.isNotEmpty
                            ? () {
                                Get.dialog(
                                  DeleteConfirmationDialog(
                                    body: 'ᡴᡭᡬᢋᡭᡧ ᡫ ᡥᡪᢞᢚᡬᡪᡪᡳ ᡭᡳ ᡓ',
                                    textCancel: 'ᡴᡭᢚᡪᡰᡨ',
                                    textDelete: 'ᡥᡪᢞᢚᡬᡰᡨ',
                                    onOkButtonTap: () => ctr.delelteAll(),
                                  ),
                                );
                              }
                            : null,
                      );
                    },
                  ),
                  GetBuilder<KeyboardController>(
                    builder: (ctr) {
                      return IconButton(
                        icon: Icon(Icons.done, color: Colors.white),
                        onPressed: () {
                          print('✅ Confirm button pressed');
                          print('   Text: "${ctr!.text}"');
                          print('   Text length: ${ctr.text.length}');
                          print('   editWithImage: ${widget.editWithImage}');
                          print('   widget.text: ${widget.text}');

                          // If no text, don't do anything
                          if (ctr.text.isEmpty) {
                            print('   → No text to return, staying on page');
                            return;
                          }

                          // Save the text to return
                          final textToReturn = ctr.text;
                          print('   → Saved text: "$textToReturn"');

                          // NOTE: if we're editing an existing text box, go back to previous screen
                          if (widget.text != null) {
                            print('   → Going back (editing existing text)');
                            try {
                              Get.back(result: textToReturn);
                            } catch (e) {
                              print(
                                '   → Error in Get.back: $e, using Navigator instead',
                              );
                              Navigator.of(context).pop(textToReturn);
                            }
                            return;
                          }
                          if (widget.editWithImage) {
                            print(
                              '   → Going back with image text: "$textToReturn"',
                            );
                            // DON'T clear text - keep it in memory for next time
                            try {
                              Get.back(result: textToReturn);
                            } catch (e) {
                              print(
                                '   → Error in Get.back: $e, using Navigator instead',
                              );
                              Navigator.of(context).pop(textToReturn);
                            }
                          } else {
                            print('   → Going to SharePage');
                            CustomizableText text = CustomizableText(
                              tag: DateTime.now().microsecondsSinceEpoch
                                  .toString(),
                              text: textToReturn,
                              editable: true,
                            );
                            // DON'T clear text - keep it in memory for plain text mode too
                            // Get.to(SharePage(text));
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
              body: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  // SizedBox(     //Google Ads Banner column
                  //   child: AdWidget(ad: _adBanner!),
                  //   height: _adBanner!.size.height.toDouble(),
                  //   width: _adBanner!.size.width.toDouble(),
                  // ),
                  Expanded(
                    child: Container(
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              //padding: EdgeInsets.only(left: 8),
                              color: Colors.grey.shade400,
                              child: Center(
                                child: GetBuilder<StyleController>(
                                  builder: (styleCtr) => Container(
                                    color: Colors.white,
                                    padding: const EdgeInsets.all(4),
                                    child: GetBuilder<TextStyleController>(
                                      builder: (ctr) {
                                        print(
                                          'now fontsize = ${ctr!.style.fontSize}',
                                        );
                                        return GetBuilder<KeyboardController>(
                                          builder: (kbCtr) {
                                            // Only set text if editing existing text box
                                            // Don't clear the controller to preserve memory
                                            if (widget.text != null) {
                                              kbCtr!
                                                      .textEditingController
                                                      .text =
                                                  widget.text!;
                                            }
                                            // Note: Removed the else branch that cleared text
                                            // This preserves text in memory when navigating back
                                            return MongolTextField(
                                              scrollPadding:
                                                  const EdgeInsets.only(),
                                              autofocus: true,
                                              showCursor: true,
                                              readOnly: true,
                                              focusNode: _focusNode,
                                              expands: true,
                                              maxLines: null,
                                              controller:
                                                  kbCtr!.textEditingController,
                                              scrollController:
                                                  kbCtr.scrollController,

                                              decoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.only(),
                                                border: InputBorder.none,
                                              ),
                                              // keyboardType: MongolKeyboard.inputType,
                                              textInputAction:
                                                  TextInputAction.newline,
                                              //keyboardType: TextInputType.multiline,
                                              style: TextStyle(
                                                fontSize: ctr.style.fontSize,
                                                fontFamily:
                                                    MongolFonts.z52agolatig,
                                              ), // Standard Tig
                                              // MongolFonts.fontList[i][0]),   // Change Tig
                                              //像平常一样设置键盘输入类型一样将Step1编写的inputType传递进去
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border(
                                right: BorderSide(
                                  color: Colors.grey.shade200,
                                  width:
                                      1 /
                                      MediaQuery.of(context).devicePixelRatio,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 50,
                            child: Column(
                              children: [
                                // GetBuilder<TextStyleController>(
                                //     builder: (ctr) => IconButton(
                                //         icon: Stack(
                                //           children: [
                                //             Padding(
                                //               padding:
                                //                   const EdgeInsets.all(4.0),
                                //               child: Text('A',
                                //                   style:
                                //                       TextStyle(fontSize: 18)),
                                //             ),
                                //             Positioned(
                                //                 right: 0, child: Text('+'))
                                //           ],
                                //         ),
                                //         onPressed: () {
                                //           ctr.increaseFontSize();
                                //         })),
                                // GetBuilder<TextStyleController>(
                                //   builder: (ctr) => IconButton(
                                //       icon: Stack(
                                //         children: [
                                //           Padding(
                                //             padding: const EdgeInsets.all(4.0),
                                //             child: Text(
                                //               'A',
                                //               style: TextStyle(fontSize: 18),
                                //             ),
                                //           ),
                                //           Positioned(right: 0, child: Text('-'))
                                //         ],
                                //       ),
                                //       onPressed: () {
                                //         ctr.decreaseFontSize();
                                //       }),
                                // ),
                                MongolTooltip(
                                  message:
                                      'ᡳᡬᢚᡬᢑᢊᡪᡨ ᡭᡧ ᢚᡬᡬᡨ ᡫ ᢘᡪᢊᡪᢊᢔᡫ ᢔᡬᢑᢛᡬᢋᡭᢑᢋᡭ',
                                  showDuration: Duration(seconds: 3),
                                  child: GetBuilder<KeyboardController>(
                                    builder: (ctr) => IconButton(
                                      icon: RotatedBox(
                                        quarterTurns: 1,
                                        child: Icon(Icons.skip_previous),
                                      ),
                                      onPressed: () {
                                        ctr!.cursorMoveUp();
                                      },
                                    ),
                                  ),
                                ),
                                MongolTooltip(
                                  message:
                                      'ᡳᡬᢚᡬᢑᢊᡪᡨ ᡭᡧ ᢚᡬᡬᡨ ᡫ ᢘᡭᢞᡭᡪᡪᢔᡫ ᢔᡬᢑᢛᡬᢋᡭᢑᢋᡭ',
                                  showDuration: Duration(seconds: 3),
                                  child: GetBuilder<KeyboardController>(
                                    builder: (ctr) => IconButton(
                                      icon: RotatedBox(
                                        quarterTurns: 3,
                                        child: Icon(Icons.skip_previous),
                                      ),
                                      onPressed: () {
                                        ctr!.cursorMoveDown();
                                      },
                                    ),
                                  ),
                                ),
                                MongolTooltip(
                                  message: 'ᡸᡪᡱᡱᡭᢑᡪᡪᡳ ',
                                  child: GetBuilder<KeyboardController>(
                                    builder: (ctr) => IconButton(
                                      icon: Icon(Icons.copy),
                                      onPressed: () {
                                        ClipboardData data = new ClipboardData(
                                          text: ctr!.text,
                                        );
                                        if (ctr.text != null) {
                                          //增加个判断防止复制null，避免闪退
                                          Clipboard.setData(data);
                                          Get.snackbar(
                                            'ᠠᠭᠤᠯᠭ᠎ᠠ ᠵᠢ ᠬᠠᠭᠤᠯᠪᠠ',
                                            'ᠠᠭᠤᠯᠭ᠎ᠠ ᠲᠠᠨᠢ ᠤᠲᠠᠰᠤᠨ ᠳ᠋ᠤ᠌ ᠬᠠᠭᠤᠯᠤᠭᠰᠠᠨ ᠪᠣᠯᠤᠨ᠎ᠠ᠃',
                                            snackPosition: SnackPosition.BOTTOM,
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                ),
                                MongolTooltip(
                                  message: 'ᡯᡪᡱᡱᡪᡪᡪᡳ ',
                                  child: GetBuilder<KeyboardController>(
                                    builder: (ctr) => IconButton(
                                      icon: Icon(Icons.paste),
                                      onPressed: () async {
                                        ClipboardData? data =
                                            await Clipboard.getData(
                                              Clipboard.kTextPlain,
                                            );
                                        if (data != null && data.text != null) {
                                          ctr!.addText(data.text!);
                                        }
                                        //之前忘了添加到文本里
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GetBuilder<KeyboardController>(
                    id: 'cands',
                    builder: (ctr) {
                      return Material(
                        color: Colors.grey.shade100,
                        elevation: 3,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: _calculateCandsHeight(ctr!.latin.value),
                          child: Stack(
                            children: [
                              WordSuggestionsSection(
                                height: _calculateCandsHeight(ctr.latin.value),
                                words: ctr.cands + teinIlgalCands,
                                onWordTap: (word) {
                                  ctr.enterAction(word);
                                },
                              ),
                              Align(
                                // Latin Letter for word suggestion
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  padding: EdgeInsets.all(2),
                                  color: Colors.transparent,
                                  child: Text(
                                    ctr.latin.value,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: MongolFonts.z52tsagaantig,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  MongolKeyboard(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // _adBanner?.dispose();
    super.dispose();

    // Clear the list of suggestions after page is closed.

    // We do not want the suggestions list to be displayed during built time
    // because all the GlobalKeys used for calculating its dimensions are not
    // yet given size.

    // This will throw an error if controller.cands is not empty
    // during build time.
    KeyboardController controller = Get.find();
    controller.cands.clear();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  ///Calculates height for suggestions section
  ///Based on length of current latin input
  double _calculateCandsHeight(String latin) => latin.length >= 7
      ? latin.length * ScreenUtil().setHeight(10.4) +
            ScreenUtil().setHeight(156)
      : ScreenUtil().setHeight(208.0);
}
