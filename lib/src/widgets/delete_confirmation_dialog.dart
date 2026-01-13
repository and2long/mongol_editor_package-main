import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mongol/mongol.dart';
import '../constants/dialog_styles.dart';

class DeleteConfirmationDialog extends StatelessWidget {
  static const title = 'ᡥᡪᡪᢊᡪᡪᡪᢞᡪᡪᡳ'; // Alert
  // static const body = 'ᡴᡭᡬᢋᡭᡧ ᡫ ᡥᡪᢞᢚᡬᡪᡪᡳ ᡭᡳ ᡓ'; // Confirm delete?
  // static const textCancel = 'ᡴᡭᢚᡪᡰᡨ'; // 'cancel'
  // static const textDelete = 'ᡥᡪᢞᢚᡬᡰᡨ'; // 'delete'

  final String body;
  final String textCancel;
  final String textDelete;
  final VoidCallback onOkButtonTap;

  const DeleteConfirmationDialog({
    Key? key,
    required this.onOkButtonTap,
    required this.body,
    required this.textCancel,
    required this.textDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MongolAlertDialog(
      title: MongolText(
        title,
        style: dialogTitleStyle.copyWith(color: Colors.red),
      ),
      content: MongolText(body, style: dialogBodyStyle),
      actions: <Widget>[
        TextButton(
          child: MongolText(textCancel, style: dialogBodyStyle),
          onPressed: () {
            Get.back();
          },
        ),
        TextButton(
          child: MongolText(
            textDelete,
            style: dialogBodyStyle.copyWith(color: Colors.red),
          ),
          onPressed: () {
            onOkButtonTap();
            Get.back();
          },
        ),
      ],
    );
  }
}
