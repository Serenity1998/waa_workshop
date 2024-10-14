import '../../helpers/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///Theme change
class ThemeService {
  final _key = 'isThemeMode';
  ThemeMode get theme =>
      _loadThemeFromBox() == false ? ThemeMode.light : ThemeMode.dark;

  bool _loadThemeFromBox() {
    return GlobalVariables.gStorage.read(_key) ?? false;
  }

  void switchTheme() async {
    Get.changeThemeMode(
      _loadThemeFromBox() == false ? ThemeMode.dark : ThemeMode.light,
    );
    GlobalVariables.gStorage
        .write(_key, _loadThemeFromBox() == false ? true : false);
  }
}
