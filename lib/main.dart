/*
 * File name: main.dart
 * Last modified: 2022.02.18 at 19:24:11
 * Author: SmarterVision - https://codecanyon.net/user/smartervision
 * Copyright (c) 2022
 */

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/modules/root/views/root_view.dart';
import 'app/providers/firebase_provider.dart';
import 'app/providers/laravel_provider.dart';
import 'app/routes/theme1_app_pages.dart';
import 'app/services/auth_service.dart';
import 'app/services/firebase_messaging_service.dart';
import 'app/services/global_service.dart';
import 'app/services/settings_service.dart';
import 'app/services/translation_service.dart';
import 'app/themes/themes.dart';
import 'firebase_options.dart';

initServices() async {
  Get.log('starting services ...');
  await GetStorage.init();
  await Get.putAsync(() => GlobalService().init());

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Get.putAsync(() => AuthService().init());
  await Get.putAsync(() => LaravelApiClient().init());
  await Get.putAsync(() => FirebaseProvider().init());
  await Get.putAsync(() => SettingsService().init());
  await Themes().init();
  await Get.putAsync(() => TranslationService().init());
  Get.log('All services started...');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServices();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.white, // navigation bar color
    statusBarColor: Colors.white, // status bar color
  ));

  runApp(
    GetMaterialApp(
      title: Get.find<SettingsService>().setting.value.appName ?? '',
      // title: 'SaveTime',
      initialRoute: Theme1AppPages.INITIAL,
      onReady: () async {
        await Get.putAsync(() => FireBaseMessagingService().init());
      },
      getPages: Theme1AppPages.routes,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: Get.find<TranslationService>().supportedLocales(),
      translationsKeys: Get.find<TranslationService>().translations,
      // locale: Get.find<TranslationService>().getLocale(),
      fallbackLocale: Get.find<TranslationService>().getLocale(),
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.cupertino,
      // theme: Get.find<SettingsService>().getLightTheme(),
      // darkTheme: Get.find<SettingsService>().getDarkTheme(),
      // themeMode: Get.find<SettingsService>().getThemeMode(),
      home: const MainTab(indexTab: 0),
      enableLog: true,
      // translationsKeys: AppTranslation.translations,
      locale: const Locale('mn', 'MN'),
      theme: Themes().ligthTheme(),
      darkTheme: Themes().darkTheme(),
      // themeMode: ThemeService().theme,
      // home: MainTab(indexTab: 0),
    ),
  );
}
