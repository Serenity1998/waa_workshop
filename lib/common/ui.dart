/*
 * File name: ui.dart
 * Last modified: 2022.03.12 at 01:51:41
 * Author: SmarterVision - https://codecanyon.net/user/smartervision
 * Copyright (c) 2022
 */

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import "package:intl/intl.dart";
import 'package:save_time_customer/helpers/color.dart';

import '../app/services/settings_service.dart';

const LightFocusColor = Color(0xFFF1E7FF);
const lightGrayColor = Color(0xFFFAFAFA);
const darkPurpleColor = Color(0xFF6F3ABB);
const lightPurpleColor = Color(0xFFF1E7FF);

class Ui {
  static GetSnackBar SuccessSnackBar(
      {String title = 'Success',
      String? message,
      SnackPosition snackPosition = SnackPosition.TOP}) {
    Get.log("[$title] $message");
    return GetSnackBar(
      titleText: Text(title.tr,
          style: Get.textTheme.titleLarge!
              .merge(TextStyle(color: Color(0xff4AAF57)))),
      messageText: Text("${message}",
          style: Get.textTheme.bodySmall!
              .merge(TextStyle(color: Color(0xff4AAF57)))),
      snackPosition: snackPosition,
      margin: EdgeInsets.all(20),
      backgroundColor: Color(0xff4ADE80).withOpacity(0.2),
      icon:
          Icon(Icons.check_circle_outline, size: 32, color: Color(0xff4AAF57)),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      borderRadius: 8,
      dismissDirection: DismissDirection.horizontal,
      duration: Duration(seconds: 5),
    );
  }

  static Widget addButton(Function onTap,
      {double height = 40, IconData icon = Icons.add}) {
    return Container(
      height: height,
      width: height,
      decoration: BoxDecoration(color: LightFocusColor, shape: BoxShape.circle),
      child: InkWell(
        onTap: () {
          onTap();
        },
        child: Center(
          child: Icon(
            icon,
            color: Get.theme.focusColor,
            size: 15,
          ),
        ),
      ),
    );
  }

  static GetSnackBar ErrorSnackBar(
      {String title = 'Error',
      String? message,
      SnackPosition snackPosition = SnackPosition.TOP}) {
    Get.log("[$title] $message", isError: true);
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

  static GetSnackBar defaultSnackBar(
      {String title = 'Alert', String? message}) {
    Get.log("[$title] $message", isError: false);
    return GetSnackBar(
      titleText: Text(title.tr,
          style: Get.textTheme.titleLarge!
              .merge(TextStyle(color: Color(0xff246BFD)))),
      messageText: Text("${message}",
          style: Get.textTheme.bodySmall!
              .merge(TextStyle(color: Color(0xff246BFD)))),
      snackPosition: SnackPosition.TOP,
      margin: EdgeInsets.all(20),
      backgroundColor: Color(0xff246BFD).withOpacity(0.2),
      borderColor: Color(0xff246BFD).withOpacity(0.1),
      icon:
          Icon(Icons.warning_amber_rounded, size: 32, color: Color(0xff246BFD)),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 8,
      duration: Duration(seconds: 1),
    );
  }

  static GetSnackBar notificationSnackBar(
      {String title = 'Notification',
      String? message,
      OnTap? onTap,
      Widget? mainButton}) {
    Get.log("[$title] $message", isError: false);
    return GetSnackBar(
      onTap: onTap,
      mainButton: mainButton,
      titleText: Text(title.tr,
          style: Get.textTheme.titleLarge!
              .merge(TextStyle(color: Get.theme.hintColor))),
      messageText: Text("${message}",
          style: Get.textTheme.bodySmall!
              .merge(TextStyle(color: Get.theme.focusColor))),
      snackPosition: SnackPosition.TOP,
      margin: EdgeInsets.all(20),
      backgroundColor: Get.theme.primaryColor,
      borderColor: Get.theme.focusColor.withOpacity(0.1),
      icon:
          Icon(Icons.notifications_none, size: 32, color: Get.theme.hintColor),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 8,
      duration: Duration(seconds: 5),
    );
  }

  static Color parseColor(String hexCode, {double opacity = 0}) {
    try {
      return Color(int.parse(hexCode.replaceAll("#", "0xFF")))
          .withOpacity(opacity ?? 1);
    } catch (e) {
      return Color(0xFFCCCCCC).withOpacity(opacity ?? 1);
    }
  }

  static List<Icon> getStarsList(double rate, {double size = 18}) {
    var list = <Icon>[];
    list = List.generate(rate.floor(), (index) {
      return Icon(Icons.star, size: size, color: Color(0xFFFFB24D));
    });
    if (rate - rate.floor() > 0) {
      list.add(Icon(Icons.star_half, size: size, color: Color(0xFFFFB24D)));
    }
    list.addAll(
        List.generate(5 - rate.floor() - (rate - rate.floor()).ceil(), (index) {
      return Icon(Icons.star_border, size: size, color: Color(0xFFFFB24D));
    }));
    return list;
  }

  static Widget getPrice(double myPrice,
      {TextStyle? style, String zeroPlaceholder = '-', String unit = ''}) {
    var _setting = Get.find<SettingsService>();
    print(_setting.setting.value.defaultCurrency);
    style = style?.merge(TextStyle(fontSize: style.fontSize! + 2));
    try {
      return RichText(
        softWrap: false,
        overflow: TextOverflow.fade,
        maxLines: 1,
        text: _setting.setting.value.currencyRight != null &&
                _setting.setting.value.currencyRight == false
            ? TextSpan(
                text: _setting.setting.value.defaultCurrency,
                // style: getPriceStyle(style),
                children: <TextSpan>[
                  TextSpan(
                      text: myPrice.toStringAsFixed(0) ?? '',
                      style: style ?? Get.textTheme.titleSmall),
                  if (unit != null)
                    TextSpan(
                        text: " " + unit + " ", style: getPriceStyle(style!)),
                ],
              )
            : TextSpan(
                text: myPrice.toStringAsFixed(0) ?? '',
                style: style ?? Get.textTheme.titleSmall,
                children: <TextSpan>[
                  const TextSpan(
                    text: "₮",
                    style: TextStyle(fontFamily: 'Arial'),
                    // style: getPriceStyle(style),
                  ),
                  if (unit != null)
                    TextSpan(
                        text: " " + unit + " ", style: getPriceStyle(style!)),
                ],
              ),
      );
    } catch (e) {
      return Text('');
    }
  }

  static TextStyle getPriceStyle(TextStyle style) {
    if (style == null) {
      return Get.textTheme.titleSmall!.merge(
        TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: Get.textTheme.titleSmall!.fontSize! - 4),
      );
    } else {
      return style.merge(TextStyle(
          fontWeight: FontWeight.w300, fontSize: style.fontSize! - 4));
    }
  }

  static BoxDecoration getBoxDecoration(
      {Color? color,
      double? radius,
      Border? border,
      Gradient? gradient,
      List<BoxShadow>? boxShadow}) {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(radius ?? 10)),
      boxShadow: boxShadow ??
          [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 3,
              blurRadius: 5,
              offset: Offset(0, 5),
            ),
          ],
      border:
          border ?? Border.all(color: Get.theme.focusColor.withOpacity(0.05)),
      gradient: gradient,
    );
  }

  static BoxDecoration getBoxDecorationLessShadow(
      {Color? color,
      double? radius,
      Border? border,
      Gradient? gradient,
      List<BoxShadow>? boxShadow}) {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(radius ?? 10)),
      boxShadow: boxShadow ??
          [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 2,
              offset: const Offset(0, 2),
            ),
          ],
      border:
          border ?? Border.all(color: Get.theme.focusColor.withOpacity(0.05)),
      gradient: gradient,
    );
  }

  static BoxDecoration getLabelBoxDecoration(
      {Color? color,
      double? radius,
      Border? border,
      Gradient? gradient,
      List<BoxShadow>? boxShadow}) {
    return BoxDecoration(
      color: color ?? CoreColor.primary,
      borderRadius: BorderRadius.all(Radius.circular(radius ?? 32)),
      boxShadow: boxShadow ??
          [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 2,
              offset: Offset(0, 2),
            ),
          ],
      border:
          border ?? Border.all(color: Get.theme.focusColor.withOpacity(0.05)),
      gradient: gradient,
    );
  }

  static BoxDecoration transparentContainer(
      {Color? color,
      double? radius,
      Border? border,
      Gradient? gradient,
      List<BoxShadow>? boxShadow}) {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(radius ?? 10)),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          spreadRadius: 5,
          blurRadius: 7,
          offset: Offset(0, 2),
        ),
      ],
      border:
          border ?? Border.all(color: Get.theme.focusColor.withOpacity(0.05)),
      gradient: gradient,
    );
  }

  static BoxDecoration getBoxDecorationBookinCell(
      {Color? color,
      double? radius,
      Border? border,
      Gradient? gradient,
      List<BoxShadow>? boxShadow}) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.all(Radius.circular(radius ?? 10)),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          spreadRadius: 2,
          blurRadius: 7,
          offset: Offset(0, 1),
        ),
      ],
      border:
          border ?? Border.all(color: Get.theme.focusColor.withOpacity(0.05)),
      gradient: gradient,
    );
  }

  static BoxDecoration bookingDetailContainer({Color? color}) {
    color ??= Colors.white.withOpacity(0.1);
    return BoxDecoration(color: color, borderRadius: BorderRadius.circular(10));
  }

  static InputDecoration getInputDecoration({
    String? hintText = '',
    String? errorText,
    String? label,
    IconData? iconData,
    Widget? suffixIcon,
    Widget? suffix,
  }) {
    return InputDecoration(
      hintText: hintText,
      label: label != null
          ? Text(
              label,
              style: const TextStyle(color: Colors.grey),
            )
          : null,
      hintStyle:
          TextStyle(color: Colors.grey[500], fontWeight: FontWeight.w400),
      prefixIcon: iconData != null
          ? Padding(
              padding: const EdgeInsets.only(left: 10, right: 5),
              child: Icon(
                iconData,
              ).marginOnly(right: 14),
            )
          : const SizedBox(),
      prefixIconConstraints: iconData != null
          ? const BoxConstraints.expand(width: 38, height: 38)
          : const BoxConstraints.expand(width: 20, height: 0),
      floatingLabelBehavior: FloatingLabelBehavior.never,
      contentPadding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
      border: const OutlineInputBorder(borderSide: BorderSide.none),
      isDense: true,
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Get.theme.focusColor,
            width: 0,
          ),
          borderRadius: BorderRadius.circular(12)),
      enabledBorder: const OutlineInputBorder(borderSide: BorderSide.none),
      suffixIcon: suffixIcon,
      suffix: suffix,
      errorText: errorText,
      counterText: errorText,
    );
  }

  // static Html applyHtml(String html,
  //     {TextStyle? style,
  //     TextAlign? textAlign,
  //     Alignment alignment = Alignment.centerLeft,
  //     double? width}) {
  //   CustomRenderMatcher pMatcher() =>
  //       (context) => context.tree.element?.localName == "";
  //   return Html(
  //     data: html.replaceAll('\r\n', '') ?? '',
  //     customRenders: {
  //       pMatcher(): CustomRender.widget(widget: (context, child) {
  //         return Text(
  //           "${context.tree.element?.text}",
  //           textAlign: textAlign,
  //           style: style == null
  //               ? Get.textTheme.bodyLarge?.merge(TextStyle(fontSize: 11))
  //               : style.merge(TextStyle(fontSize: 11)),
  //         );
  //       }),
  //     },
  //     style: {
  //       "*": Style(
  //         textAlign: textAlign,
  //         alignment: alignment,
  //         color: style == null ? Get.theme.hintColor : style.color,
  //         fontSize: style == null ? FontSize(16.0) : FontSize(style.fontSize!),
  //         display: Display.inlineBlock,
  //         fontWeight: style == null ? FontWeight.w300 : style.fontWeight,
  //         width: Width(width ?? Get.width * 0.85),
  //       ),
  //       "li": Style(
  //         textAlign: textAlign,
  //         lineHeight: LineHeight.normal,
  //         listStylePosition: ListStylePosition.outside,
  //         fontSize: style == null ? FontSize(14.0) : FontSize(style.fontSize!),
  //         display: Display.block,
  //       ),
  //       "h4,h5,h6": Style(
  //         textAlign: textAlign,
  //         fontSize:
  //             style == null ? FontSize(16.0) : FontSize(style.fontSize! + 2),
  //       ),
  //       "h1,h2,h3": Style(
  //         textAlign: textAlign,
  //         lineHeight: LineHeight.number(2),
  //         fontSize:
  //             style == null ? FontSize(18.0) : FontSize(style.fontSize! + 4),
  //         display: Display.block,
  //       ),
  //       "p": Style(
  //         textAlign: textAlign,
  //         lineHeight: LineHeight.number(1),
  //         fontSize: style == null ? FontSize(14.0) : FontSize(style.fontSize!),
  //         display: Display.inlineBlock,
  //         width: Width(Get.width * 0.85),
  //       ),
  //       "br": Style(
  //         height: Height(0),
  //       ),
  //     },
  //   );
  // }

  static BoxFit getBoxFit(String boxFit) {
    switch (boxFit) {
      case 'cover':
        return BoxFit.cover;
      case 'fill':
        return BoxFit.fill;
      case 'contain':
        return BoxFit.contain;
      case 'fit_height':
        return BoxFit.fitHeight;
      case 'fit_width':
        return BoxFit.fitWidth;
      case 'none':
        return BoxFit.none;
      case 'scale_down':
        return BoxFit.scaleDown;
      default:
        return BoxFit.cover;
    }
  }
  //
  // static Html removeHtml(String html,
  //     {TextStyle? style,
  //     TextAlign? textAlign,
  //     Alignment alignment = Alignment.centerLeft}) {
  //   CustomRenderMatcher pMatcher() =>
  //       (context) => context.tree.element?.localName == "p";
  //   return Html(
  //     data: html.replaceAll('\r\n', '') ?? '',
  //     customRenders: {
  //       pMatcher(): CustomRender.widget(widget: (context, child) {
  //         return Text(
  //           context.tree.element!.text,
  //           textAlign: textAlign,
  //           maxLines: 2,
  //           style: style == null
  //               ? Get.textTheme.bodyLarge?.merge(TextStyle(fontSize: 11))
  //               : style.merge(TextStyle(fontSize: 11)),
  //         );
  //       }),
  //     },
  //     style: {
  //       "*": Style(
  //         textAlign: textAlign,
  //         alignment: alignment,
  //         color: style == null ? Get.theme.hintColor : style.color,
  //         fontSize: style == null ? FontSize(11.0) : FontSize(style.fontSize!),
  //         display: Display.block,
  //         fontWeight: style == null ? FontWeight.w300 : style.fontWeight,
  //         width: Width(Get.width),
  //       ),
  //       "br": Style(
  //         height: Height(0),
  //       ),
  //     },
  //   );
  // }

  static AlignmentDirectional getAlignmentDirectional(
      String alignmentDirectional) {
    switch (alignmentDirectional) {
      case 'top_start':
        return AlignmentDirectional.topStart;
      case 'top_center':
        return AlignmentDirectional.topCenter;
      case 'top_end':
        return AlignmentDirectional.topEnd;
      case 'center_start':
        return AlignmentDirectional.centerStart;
      case 'center':
        return AlignmentDirectional.topCenter;
      case 'center_end':
        return AlignmentDirectional.centerEnd;
      case 'bottom_start':
        return AlignmentDirectional.bottomStart;
      case 'bottom_center':
        return AlignmentDirectional.bottomCenter;
      case 'bottom_end':
        return AlignmentDirectional.bottomEnd;
      default:
        return AlignmentDirectional.bottomEnd;
    }
  }

  static String currencyFormat(double amount) {
    try {
      var f =
          NumberFormat.currency(locale: 'MN', symbol: "₮", decimalDigits: 0);
      return f.format(amount);
    } catch (e) {
      return amount.toString();
    }
  }

  static CrossAxisAlignment getCrossAxisAlignment(String textPosition) {
    switch (textPosition) {
      case 'top_start':
        return CrossAxisAlignment.start;
      case 'top_center':
        return CrossAxisAlignment.center;
      case 'top_end':
        return CrossAxisAlignment.end;
      case 'center_start':
        return CrossAxisAlignment.center;
      case 'center':
        return CrossAxisAlignment.center;
      case 'center_end':
        return CrossAxisAlignment.center;
      case 'bottom_start':
        return CrossAxisAlignment.start;
      case 'bottom_center':
        return CrossAxisAlignment.center;
      case 'bottom_end':
        return CrossAxisAlignment.end;
      default:
        return CrossAxisAlignment.start;
    }
  }

  static String getDistance(double distance) {
    String _unit = Get.find<SettingsService>().setting.value.distanceUnit!;
    if (_unit == 'km') {
      distance = (distance ?? 0) * 1.60934;
    }
    return distance != null ? distance.toStringAsFixed(2) + " " + _unit.tr : "";
  }
}
