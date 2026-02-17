import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../constants/app_strings.dart';

void showErrorMessage(String? message) {
  Fluttertoast.showToast(
    msg: message ?? AppStrings.generalErrorMessage,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 3,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

void showSuccessMessage(String? message) {
  Fluttertoast.showToast(
    msg: message ?? AppStrings.generalErrorMessage,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 3,
    backgroundColor: Colors.green,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
