import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:note_app_bloc/view/widgets/auth/auth_text.dart';

AwesomeDialog customDialog(
  BuildContext context,
  DialogType type,
  String title,
  String body,
  String btnOk,
  void Function()? onPressOk,
) {
  return AwesomeDialog(
    context: context,
    dialogType: type,
    title: title,
    btnOkText: btnOk,
    btnOkOnPress: onPressOk,
    body: AuthText(
      text: body,
      style: FontWeight.w300,
      size: 16,
      color: Colors.black,
    ),
  )..show();
}
