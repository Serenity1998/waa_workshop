import 'dart:convert' as convert;
import 'dart:io' as io;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;

import '../app/models/address_model.dart';
import '../app/models/salon_model.dart';
// import '../app/modules/global_widgets/block_button_widget.dart';
import 'ui.dart';
import 'package:intl/intl.dart';

class Helper {
  DateTime? currentBackPressTime;

  var MY_DATE_FORMAT = new DateFormat("yyyy-MM-dd");

  static Future<dynamic> getJsonFile(String path) async {
    return rootBundle.loadString(path).then(convert.jsonDecode);
  }

  static Future<dynamic> getFilesInDirectory(String path) async {
    var files = io.Directory(path).listSync();
    // print(files);
    return files;
    // return rootBundle.(path).then(convert.jsonDecode);
  }

  static String toUrl(String path) {
    if (!path.endsWith('/')) {
      path += '/';
    }
    return path;
  }

  static String toApiUrl(String path) {
    path = toUrl(path);
    if (!path.endsWith('/')) {
      path += '/';
    }
    return path;
  }

  static int minTimeDay(TimeOfDay day) {
    return day.hour * 60 + day.minute;
  }

  static getWeekDay(DateTime date) {
    return DateFormat('EEEE').format(date);
  }

  String getMonDate(String string) {
    var date = MY_DATE_FORMAT.parse(string);

    return "${getMonday(date.weekday)}, ${date.month}-р сарын ${date.day}";
  }

  String getMonday(int day) {
    switch (day) {
      case 1:
        return "Даваа";
        break;
      case 2:
        return "Мягмар";
        break;
      case 3:
        return "Лхагва";
        break;
      case 4:
        return "Пүрэв";
        break;
      case 5:
        return "Баасан";
        break;
      case 6:
        return "Бямба";
        break;
      case 7:
        return "Ням";
        break;
      default:
        return "";
    }
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Get.showSnackbar(Ui.defaultSnackBar(message: "Tap again to leave!".tr));
      return Future.value(false);
    }
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    return Future.value(true);
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Future<Marker> getSalonMarker(Salon salon, Address? address) async {
    // var imageUrl = salon.images.first.url;

    // Uint8List bytes =
    //     (await NetworkAssetBundle(Uri.parse(imageUrl)).load(imageUrl))
    //         .buffer
    //         .asUint8List();

    final Uint8List markerIcon =
        await getBytesFromAsset('assets/img/Address.png', 120);

    final Marker marker = Marker(
      markerId: MarkerId(salon.id!),
      icon: BitmapDescriptor.fromBytes(markerIcon),
//        onTap: () {
//          //print(res.name);
//        },
      anchor: const ui.Offset(0.5, 0.5),
      position: address?.getLatLng() ?? const LatLng(47.918189, 106.917636),
    );

    return marker;
  }

  static basicLoader() {
    return Get.dialog(const SpinKitCircle(
      color: Color(0xff7210FF),
      size: 70.0,
    ));
  }

  static void basicAlert(
    BuildContext context,
    String title,
    String text, {
    String? onOkText,
    String? img,
    Function? onPressed,
  }) {
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  child: Image.asset(
                    img ?? "assets/img_new/success.png",
                    width: 185,
                  ),
                ),
                Text(title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        color: Get.theme.focusColor,
                        fontWeight: FontWeight.w600)),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
                  child: Text(
                    text,
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
                // Container(
                //   margin: const EdgeInsets.only(bottom: 10),
                //   width: Get.width - 150,
                //   height: 55,
                //   child: BlockButtonWidget(
                //     color: Get.theme.focusColor,
                //     text: Text(
                //       "${onOkText}".tr ?? 'OK',
                //       style: TextStyle(
                //         color: Colors.white,
                //         fontSize: 16,
                //         fontWeight: FontWeight.w600,
                //       ),
                //     ),
                //     onPressed: () => onPressed ?? Get.back,
                //   ),
                // ),
              ],
            ),
          ),
        );
      },
    );
  }

  static Future<void> basicBottomSheet(
    String onOkText,
    String onNoText,
    Function() onOk,
    Function() onNo,
    String title,
    Widget child, {
    double? height,
  }) async {
    Get.bottomSheet(Container(
      height: height ?? 340,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(40),
          topLeft: Radius.circular(40),
        ),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10),
            height: 3,
            width: 40,
            decoration: BoxDecoration(
                color: Color(0xffE0E0E0),
                borderRadius: BorderRadius.circular(15)),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              title,
              style: TextStyle(fontSize: 20),
            ),
          ),
          Divider(),
          child,
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(height: 100)
              // SizedBox(
              //   height: 58,
              //   width: Get.width / 2 - 30,
              //   child: BlockButtonWidget(
              //     text: Text(
              //       onOkText.tr ?? 'Тийм',
              //       textAlign: TextAlign.center,
              //       style: TextStyle(
              //         color: Get.theme.focusColor,
              //         fontSize: 16,
              //         fontWeight: FontWeight.w500,
              //       ),
              //     ),
              //     color: Color(0xffF1E7FF),
              //     onPressed: onOk,
              //   ),
              // ),
              // SizedBox(
              //   width: Get.width / 2.2,
              //   height: 58,
              //   child: BlockButtonWidget(
              //     text: Text(
              //       onNoText.tr ?? 'Үгүй',
              //       textAlign: TextAlign.center,
              //       style: TextStyle(
              //         color: Get.theme.primaryColor,
              //         fontSize: 16,
              //         fontWeight: FontWeight.w500,
              //       ),
              //     ),
              //     color: Get.theme.colorScheme.secondary,
              //     onPressed: onNo,
              //   ),
              // ),
            ],
          ),
        ],
      ),
    ));
  }
}
