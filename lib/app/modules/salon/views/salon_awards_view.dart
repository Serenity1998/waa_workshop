/*
 * File name: salon_awards_view.dart
 * Last modified: 2022.02.06 at 16:15:30
 * Author: SmarterVision - https://codecanyon.net/user/smartervision
 * Copyright (c) 2022
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/empty_view.dart';
import '../../../../common/ui.dart';
import '../controllers/salon_awards_controller.dart';
import '../widgets/salon_til_widget.dart';

class SalonAwardsView extends GetView<SalonAwardsController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.awards.isEmpty) {
        return EmptyView(title: 'Одоогоор шагнал байхгүй байна');
      }
      return SalonTilWidget(
        title: Text("Awards".tr, style: Get.textTheme.titleSmall),
        content: ListView.separated(
          padding: EdgeInsets.zero,
          primary: false,
          shrinkWrap: true,
          itemCount: controller.awards.length,
          separatorBuilder: (context, index) {
            return Divider(height: 16, thickness: 0.8);
          },
          itemBuilder: (context, index) {
            var _award = controller.awards.elementAt(index);
            return Column(
              children: [
                Text(_award.title ?? '').paddingSymmetric(vertical: 5),
                // Ui.applyHtml(
                //   _award.description ?? '',
                //   style: Get.textTheme.bodySmall!,
                // ),
              ],
              crossAxisAlignment: CrossAxisAlignment.start,
            );
          },
        ),
      );
    });
  }
}
