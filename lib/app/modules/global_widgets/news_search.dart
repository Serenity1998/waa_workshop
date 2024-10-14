/*
 * File name: home_search_bar_widget.dart
 * Last modified: 2022.02.10 at 15:02:14
 * Author: SmarterVision - https://codecanyon.net/user/smartervision
 * Copyright (c) 2022
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/app_routes.dart';
import '../search/controllers/search_controller.dart';
import 'filter_bottom_sheet_widget.dart';

class NewsSearchBar extends StatelessWidget implements PreferredSize {
  final controller = Get.find<SearchControllerCustom>();

  Widget buildSearchBar() {
    // controller.heroTag.value = UniqueKey().toString();
    return Hero(
      tag: controller.heroTag.value,
      child: Container(
        height: 56,
        margin: EdgeInsets.only(left: 20, right: 20, bottom: 0, top: 0),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
        decoration: BoxDecoration(
            color: Colors.grey[100], borderRadius: BorderRadius.circular(10)),
        child: GestureDetector(
          onTap: () async {
            controller.clear();
            await controller.getSearchHistory();
            Get.toNamed(Routes.SEARCH, arguments: controller.heroTag.value);
          },
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 12, left: 0),
                child: Image.asset(
                  "assets/img_new/ic_search_grey.png",
                  width: 16,
                ),
              ),
              Expanded(
                child: Text(
                  "Хайх".tr,
                  maxLines: 1,
                  softWrap: false,
                  overflow: TextOverflow.fade,
                  style: Get.textTheme.bodySmall!
                      .merge(TextStyle(color: Color(0xffBDBDBD))),
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () {
                  Get.bottomSheet(
                    FilterBottomSheetWidget(),
                    isScrollControlled: true,
                  );
                },
                child: Image.asset(
                  "assets/img_new/ic_filter.png",
                  width: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildSearchBar();
  }

  @override
  Widget get child => buildSearchBar();

  @override
  Size get preferredSize => new Size(Get.width, 80);
}
