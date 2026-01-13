import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'src/editor_page.dart';
import 'src/controllers/keyboard_controller.dart';
import 'src/controllers/text_controller.dart';
import 'src/controllers/style_controller.dart';
import 'src/utils/app_setting.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize AppSetting first and wait for it to complete
  await AppSetting.instance.loadSettings();

  Get.put(KeyboardController());
  Get.put(TextStyleController());
  Get.put(StyleController());

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(720, 1600),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(home: EditorPage(editWithImage: false));
      },
    );
  }
}
