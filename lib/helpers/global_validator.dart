import 'package:get/get_utils/src/extensions/internacionalization.dart';

class GlobalValidator {
  String? emailValid(String? value) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(p);
    if (regExp.hasMatch(value!) == true) {
      return null;
    } else {
      return "email_regex_tr".tr;
    }
  }

  String? phoneValid(String? value) {
    String p = r'^(([0-9]{8}))$';
    RegExp regExp = RegExp(p);
    if (regExp.hasMatch(value!) == true) {
      return null;
    } else {
      return "phone_regex_tr".tr;
    }
  }
}
