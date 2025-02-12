/*
 * File name: translation_service.dart
 * Last modified: 2022.02.10 at 14:56:16
 * Author: SmarterVision - https://codecanyon.net/user/smartervision
 * Copyright (c) 2022
 */

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../repositories/setting_repository.dart';

class TranslationService extends GetxService {
  final translations = Map<String, Map<String, String>>().obs;

  static List<String> languages = [];

  late SettingRepository _settingsRepo;
  late GetStorage _box;

  TranslationService() {
    _settingsRepo = new SettingRepository();
    _box = new GetStorage();
  }
  // initialize the translation service by loading the assets/locales folder
  // the assets/locales folder must contains file for each language that named
  // with the code of language concatenate with the country code
  // for example (en_US.json)
  Future<TranslationService> init() async {
    languages = await _settingsRepo.getSupportedLocales();
    await loadTranslation();
    return this;
  }

  Future<void> loadTranslation({locale}) async {
    locale = locale ?? getLocale().languageCode;
    Map<String, String> _translations =
        await _settingsRepo.getTranslations(locale);
    Get.addTranslations({locale: _translations});
  }

  Locale getLocale() {
    String? _locale = _box.read<String>('language');
    print(_locale);
    if (_locale == null) {
      _locale = "mn";
    }
    return fromStringToLocale(_locale);
  }

  // get list of supported local in the application
  List<Locale> supportedLocales() {
    return TranslationService.languages.map((_locale) {
      return fromStringToLocale(_locale);
    }).toList();
  }

  // Convert string code to local object
  Locale fromStringToLocale(String _locale) {
    if (_locale.contains('_')) {
      // en_US
      return Locale(
          _locale.split('_').elementAt(0), _locale.split('_').elementAt(1));
    } else {
      // en
      return Locale(_locale);
    }
  }
}
