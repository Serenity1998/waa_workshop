import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'global_variables.dart';
import 'package:intl/intl.dart';

class GlobalFunc {
  /// [storageToVar] user variables assign a value
  static storageToVar() {
    var userInformation = GlobalVariables.gStorage.read('userInformation');
    GlobalVariables.id = userInformation['id'] ?? '';
    GlobalVariables.name = userInformation['name'];
    GlobalVariables.email.value = userInformation['email'] ?? '';
    GlobalVariables.salons = userInformation['salons'];
    GlobalVariables.phoneNumber = userInformation['phone_number'];
    GlobalVariables.customField = userInformation['custom_fields'];
    GlobalVariables.hasMedia = userInformation['has_media'];
    GlobalVariables.roles = userInformation['roles'];
    GlobalVariables.media = userInformation['media'];
  }

  // String passEnc(text) {
  //   var bytes = utf8.encode(text);
  //   var digest = sha256.convert(bytes);
  //   return digest.toString();
  // }

  static String timeFormat(date) {
    DateTime datetime = DateTime.parse(date);
    // var dateValue = DateFormat("yyyy-MM-dd HH:mm:ss").parseUTC(date);
    String formattedDate = DateFormat("yyyy.MM.dd").format(datetime);
    return formattedDate;
  }

  static String greetingType() {
    var time = DateTime.now().hour;
    if (time >= 06 && time < 11) {
      return "Өглөөний мэнд";
    }
    if (time >= 11 && time < 18) {
      return "Өдрийн мэнд";
    }

    if (time >= 18 && time < 22) {
      return "Оройн мэнд";
    }

    if (time >= 22 && time < 06) {
      return "Шөнийн мэнд";
    }

    return "Өдрийн мэнд";
  }

  static GetSnackBar errorSnackBar(
      {String title = 'Error',
      String? message,
      SnackPosition snackPosition = SnackPosition.TOP}) {
    // Get.log("[$title] $message", isError: true);
    return GetSnackBar(
      titleText: Text(title.tr,
          style: Get.textTheme.titleLarge!
              .merge(TextStyle(color: Color(0xffF75555)))),
      messageText: Text("${message}".substring(0, min(message!.length, 200)),
          style: Get.textTheme.bodySmall!
              .merge(TextStyle(color: Color(0xffF75555)))),
      snackPosition: snackPosition,
      margin: EdgeInsets.all(20),
      backgroundColor: Color(0xffF75555).withOpacity(0.2),
      icon:
          Icon(Icons.remove_circle_outline, size: 32, color: Color(0xffF75555)),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 8,
      duration: Duration(seconds: 2),
    );
  }
}
