import 'color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// string extension capitalize
extension StringExtension on String {
  /// uppercase first one string
  capitalizeCustom() {
    if (isEmpty) {
      return "";
    }
    return "${this[0].toUpperCase()}${substring(1)}";
  }

  ///First 3 character of string
  first3() {
    return substring(0, 3);
  }

  lastSplice3() {
    return substring(0, 5);
  }
}

String weekDayName(int weekday) {
  switch (weekday) {
    case DateTime.monday:
      return "Mon";
    case DateTime.tuesday:
      return "Tue";
    case DateTime.wednesday:
      return "Wed";
    case DateTime.thursday:
      return "Thu";
    case DateTime.friday:
      return "Fri";
    case DateTime.saturday:
      return "Sat";
    case DateTime.sunday:
      return "Sun";
  }
  return "";
}

class CustomLoader {
  static logoLoading() {
    return Get.dialog(
      Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            'assets/icons/loader.png',
            height: 50,
            width: 50,
          ),
          SizedBox(
            height: 60.0,
            width: 60.0,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(CoreColor.primary),
              strokeWidth: 2.5,
            ),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }
}
