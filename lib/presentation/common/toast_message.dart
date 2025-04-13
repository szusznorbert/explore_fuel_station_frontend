import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastMessage {
  static Future<void> displayToastMessage(String message, {Color? color, int? time}) async {
    await Fluttertoast.showToast(
      msg: message,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: time ?? 4,
      toastLength: Toast.LENGTH_LONG,
      backgroundColor: color,
    );
  }
}
