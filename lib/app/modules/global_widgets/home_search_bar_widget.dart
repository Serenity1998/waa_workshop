/*
 * File name: home_search_bar_widget.dart
 * Last modified: 2022.02.10 at 15:02:14
 * Author: SmarterVision - https://codecanyon.net/user/smartervision
 * Copyright (c) 2022
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/app_routes.dart';
import '../../services/auth_service.dart';
import '../search/controllers/search_controller.dart';
import 'filter_bottom_sheet_widget.dart';

class HomeSearchBarWidget extends StatelessWidget implements PreferredSize {
  final controller = Get.find<SearchControllerCustom>();

  Widget buildSearchBar() {
    controller.heroTag.value = UniqueKey().toString();
    return Hero(
      tag: controller.heroTag.value,
      child: Container(
        margin: EdgeInsets.only(left: 20, right: 20, bottom: 12),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
        decoration: BoxDecoration(
            color: Colors.grey[100], borderRadius: BorderRadius.circular(10)),
        child: GestureDetector(
          onTap: () async {
            controller.isService.value = true;
            controller.clear();
            if (Get.find<AuthService>().isAuth ?? false)
              await controller.getSearchHistory();
            Get.toNamed(Routes.SEARCH, arguments: controller.heroTag.value);
          },
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 12, left: 0),
                child: Image.asset(
                  "assets/img_new/ic_search_grey.png",
                  width: 22,
                ),
              ),
              Expanded(
                child: Text(
                  "Хайх ...",
                  maxLines: 1,
                  softWrap: false,
                  overflow: TextOverflow.fade,
                  style: Get.textTheme.bodySmall,
                ),
              ),
              GestureDetector(
                child: Image.asset(
                  "assets/img_new/ic_filter.png",
                  width: 25,
                  height: 25,
                ),
                onTap: () async {
                  controller.clear();
                  await controller.getSearchHistory();
                  Get.toNamed(Routes.SEARCH);
                  controller.autoFocus.value = false;
                  Get.bottomSheet(
                    FilterBottomSheetWidget(),
                    isScrollControlled: false,
                  );
                },
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
