/*
 * File name: booking_title_bar_widget.dart
 * Last modified: 2022.02.26 at 14:50:11
 * Author: SmarterVision - https://codecanyon.net/user/smartervision
 * Copyright (c) 2022
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/ui.dart';

class BookingTitleBarWidget extends StatelessWidget implements PreferredSize {
  final Widget title;

  const BookingTitleBarWidget({Key? key, required this.title})
      : super(key: key);

  Widget buildTitleBar() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      height: 155,
      width: double.infinity,
      decoration:
          Ui.bookingDetailContainer(color: Colors.white.withOpacity(0.20)),
      child: title,
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildTitleBar();
  }

  @override
  Widget get child => buildTitleBar();

  @override
  Size get preferredSize => new Size(Get.width, 100);
}
