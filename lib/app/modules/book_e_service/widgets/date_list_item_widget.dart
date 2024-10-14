/*
 * File name: services_list_item_widget.dart
 * Last modified: 2022.02.11 at 18:43:34
 * Author: SmarterVision - https://codecanyon.net/user/smartervision
 * Copyright (c) 2022
 */

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/ui.dart';
import '../../../../helpers/color.dart';
import '../../../../helpers/global_extensions.dart';
import '../../../models/salon_model.dart';
import '../../../routes/app_routes.dart';

class DateListItemWidget extends StatelessWidget {
  final bool selected;
  final bool isAvailable;
  final void Function() onSelect;
  final DateTime dateTime;

  const DateListItemWidget(
      {Key? key,
      this.selected = false,
      this.isAvailable = false,
      required this.dateTime,
      required this.onSelect})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: 80,
      margin: const EdgeInsets.only(right: 15),
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      decoration: BoxDecoration(
          color:
              selected ? CoreColor.primarySelected : CoreColor.primaryLighter,
          borderRadius: const BorderRadius.all(Radius.circular(14))),
      child: InkWell(
        onTap: onSelect,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(weekDayName(dateTime.weekday),
                style: Get.textTheme.bodyLarge!.merge(TextStyle(
                    color: selected
                        ? CoreColor.primaryLighter
                        : CoreColor.primarySelected))),
            const SizedBox(height: 6),
            Text("${dateTime.day}",
                style: Get.textTheme.headlineMedium!.merge(TextStyle(
                    fontWeight: FontWeight.w900,
                    color: selected
                        ? CoreColor.primaryLighter
                        : CoreColor.primarySelected))),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}
