import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../helpers/color.dart';
import '../models/address_model.dart';
import '../repositories/setting_repository.dart';
import '../services/auth_service.dart';

class Themes extends GetxService {
  dynamic setting = {
    "app_name": "SaveTime",
    "app_short_description":
        "Үйлчилгээний байгууллагаас цаг авах, захиалах цогц систем",
    "default_currency": "₮",
    "fcm_key":
        "AAAAJvQx-TE:APA91bHttuYwyYSkKmQYtdCvolKeAqsDHPaGb_IyvjqYxsFC5xEGjI5dzRFegkt8x41I7bV7YxGPAEQa5NOo_qZxbCnRc3yJ1_82AVsvpYKbYrqNdKtcDbP7CCCetDmg9x4D57bGNCIt",
    "main_color": "#240937",
    "main_dark_color": "#6F3ABB",
    "second_color": "#240937",
    "second_dark_color": "#FFFFFF",
    "accent_color": "#240937",
    "accent_dark_color": "#CFCFCF",
    "scaffold_dark_color": "#E8ECF1",
    "scaffold_color": "#E8ECF1",
    "google_maps_key": "AIzaSyAlkPmpDJqDZl4R3sKE_srjsQpQpqpu4JU",
    "mobile_language": "mn",
    "app_version": "1.0.0",
    "enable_version": "0",
    "default_currency_decimal_digits": "2",
    "currency_right": "1",
    "distance_unit": "km",
    "default_theme": "light",
    "default_country_code": "MN",
    "enable_otp": "0",
    "app_logo": "https://business.savetime.mn/images/logo_default.png"
  };
  final address = Address().obs;
  late GetStorage _box;

  late SettingRepository _settingsRepo;

  Themes() {
    _settingsRepo = new SettingRepository();
    _box = new GetStorage();
  }

  Future<Themes> init() async {
    address.listen((Address _address) {
      _box.write('current_address', _address.toJson());
    });
    // setting.value = await _settingsRepo.get();
    // setting.value = as Setting;
    await getAddress();
    return this;
  }

  Future getAddress() async {
    try {
      if (_box.hasData('current_address') && !address.value.isUnknown()) {
        address.value = Address.fromJson(await _box.read('current_address'));
      } else if (Get.find<AuthService>().isAuth) {
        List<Address> _addresses = await _settingsRepo.getAddresses();
        if (_addresses.isNotEmpty) {
          address.value = _addresses
              .firstWhere((_address) => _address.isDefault!, orElse: () {
            return _addresses.first;
          });
        }
      }
    } catch (e) {
      Get.log(e.toString());
    }
  }

  ligthTheme() {
    return ThemeData(
        // ThemeData.light().copyWith(
        useMaterial3: false,
        primaryColor: Colors.white,
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
            elevation: 0, foregroundColor: Colors.white),
        brightness: Brightness.light,
        dividerColor: CoreColor.fromHex(setting['accent_color']),
        focusColor: CoreColor.fromHex("#212121"),
        hintColor: CoreColor.fromHex(setting['second_color']),
        secondaryHeaderColor: CoreColor.primary,
        scaffoldBackgroundColor: Colors.white,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Colors.white,
            selectedItemColor: CoreColor.fromHex("#7210FF"),
            unselectedItemColor: const Color(0xff9E9E9E),
            selectedLabelStyle: TextStyle(
                color: CoreColor.fromHex(
                  "#7210FF",
                ),
                fontSize: 10)),
        appBarTheme: AppBarTheme(
            elevation: 0,
            centerTitle: false,
            titleTextStyle: Get.textTheme.titleLarge?.merge(const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w600)),
            backgroundColor: Colors.white,
            iconTheme: const IconThemeData(color: Colors.black)),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
              foregroundColor: CoreColor.fromHex(setting['main_color'])),
        ),
        colorScheme: ColorScheme.light(
          primary: CoreColor.fromHex("#7210FF"),
          secondary: CoreColor.fromHex("#6F3ABB"),
        ),
        textTheme: GoogleFonts.getTextTheme(
          'Roboto',
          TextTheme(
            titleLarge: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w700,
              color: CoreColor.fromHex(setting['main_color']),
              height: 1.3,
            ),
            headlineSmall: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w700,
                color: CoreColor.fromHex(setting['second_color']),
                height: 1.3),
            headlineMedium: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
                color: CoreColor.fromHex(setting['second_color']),
                height: 1.3),
            displaySmall: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
                color: CoreColor.fromHex(setting['second_color']),
                height: 1.3),
            displayMedium: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.w700,
                color: CoreColor.fromHex(setting['main_color']),
                height: 1.4),
            displayLarge: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w300,
                color: CoreColor.fromHex(setting['second_color']),
                height: 1.4),
            titleSmall: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
                color: CoreColor.fromHex(setting['second_color']),
                height: 1.2),
            titleMedium: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w400,
                color: CoreColor.fromHex(setting['main_color']),
                height: 1.2),
            bodyMedium: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w600,
                color: CoreColor.fromHex(setting['second_color']),
                height: 1.2),
            bodyLarge: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
                color: CoreColor.fromHex(setting['second_color']),
                height: 1.2),
            bodySmall: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w300,
                color: CoreColor.fromHex(setting['accent_color']),
                height: 1.2),
            labelLarge: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
                color: Colors.white,
                height: 1.2),
          ),
        ),
        checkboxTheme: CheckboxThemeData(
          visualDensity: const VisualDensity(
            horizontal: -4.0,
            vertical: -4.0,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(6.0),
            ),
          ),
          side: BorderSide(color: CoreColor.fromHex("#7210FF"), width: 2),
          fillColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.selected)) {
              return CoreColor.fromHex("#7210FF");
            }
            return null;
          }),
        ),
        radioTheme: RadioThemeData(
          fillColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return null;
            }
            if (states.contains(MaterialState.selected)) {
              return CoreColor.fromHex("#7210FF");
            }
            return null;
          }),
        ),
        switchTheme: SwitchThemeData(
          thumbColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return null;
            }
            if (states.contains(MaterialState.selected)) {
              return CoreColor.fromHex("#7210FF");
            }
            return null;
          }),
          trackColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return null;
            }
            if (states.contains(MaterialState.selected)) {
              return CoreColor.fromHex("#7210FF");
            }
            return null;
          }),
        ));
  }

  static final dark = ThemeData.dark().copyWith(
    useMaterial3: false,
    scaffoldBackgroundColor: const Color.fromARGB(255, 78, 78, 78),
  );

  darkTheme() {
    return ThemeData(
      primaryColor: const Color(0xFF252525),
      floatingActionButtonTheme:
          const FloatingActionButtonThemeData(elevation: 0),
      scaffoldBackgroundColor: const Color(0xFF2C2C2C),
      brightness: Brightness.dark,
      dividerColor: CoreColor.fromHex(setting['accent_dark_color']),
      focusColor: CoreColor.fromHex(setting['accent_dark_color']),
      hintColor: CoreColor.fromHex(setting['second_dark_color']),
      // toggleableActiveColor: CoreColor.fromHex(setting.value.mainDarkColor),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
            foregroundColor: CoreColor.fromHex(setting['main_color'])),
      ),
      colorScheme: ColorScheme.dark(
        primary: CoreColor.fromHex(setting['main_dark_color']),
        secondary: CoreColor.fromHex(setting['main_dark_color']),
      ),
      textTheme: GoogleFonts.getTextTheme(
        'Roboto',
        TextTheme(
          titleLarge: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w700,
              color: CoreColor.fromHex(setting['main_dark_color']),
              height: 1.3),
          headlineSmall: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w700,
              color: CoreColor.fromHex(setting['second_dark_color']),
              height: 1.3),
          headlineMedium: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w400,
              color: CoreColor.fromHex(setting['second_dark_color']),
              height: 1.3),
          displaySmall: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
              color: CoreColor.fromHex(setting['second_dark_color']),
              height: 1.3),
          displayMedium: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.w700,
              color: CoreColor.fromHex(setting['main_dark_color']),
              height: 1.4),
          displayLarge: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w300,
              color: CoreColor.fromHex(setting['second_dark_color']),
              height: 1.4),
          titleSmall: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w600,
              color: CoreColor.fromHex(setting['second_dark_color']),
              height: 1.2),
          titleMedium: TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.w400,
              color: CoreColor.fromHex(setting['main_dark_color']),
              height: 1.2),
          bodyMedium: TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.w600,
              color: CoreColor.fromHex(setting['second_dark_color']),
              height: 1.2),
          bodyLarge: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w400,
              color: CoreColor.fromHex(setting['second_dark_color']),
              height: 1.2),
          bodySmall: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w300,
              color: CoreColor.fromHex(setting['accent_dark_color']),
              height: 1.2),
        ),
      ),
    );
  }
}
