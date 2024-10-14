/*
 * File name: home_search_bar_widget.dart
 * Last modified: 2022.02.10 at 15:02:14
 * Author: SmarterVision - https://codecanyon.net/user/smartervision
 * Copyright (c) 2022
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../search/controllers/search_controller.dart';
import '../controllers/category_controller.dart';
import 'SubCategoryBottomSheet.dart';

class CategorySearchView extends StatelessWidget implements PreferredSize {
  final Function filter;

  final controller = Get.find<CategoryController>();
  final searchController = Get.find<SearchControllerCustom>();

  CategorySearchView({Key? key, required this.filter}) : super(key: key);

  Widget buildSearchBar() {
    // controller.heroTag.value = UniqueKey().toString();
    return Hero(
      tag: "",
      child: Container(
        margin: const EdgeInsets.only(left: 20, right: 20, bottom: 16),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
            color: Get.theme.primaryColor,
            border: Border.all(
              color: Get.theme.focusColor.withOpacity(0.2),
            ),
            borderRadius: BorderRadius.circular(10)),
        child: GestureDetector(
          onTap: () {
            Get.put(SearchController()).clear();
            Get.toNamed(Routes.SEARCH,
                arguments: searchController.heroTag.value);
          },
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 12, left: 0),
                child:
                    Icon(Icons.search, color: Get.theme.colorScheme.secondary),
              ),
              Expanded(
                child: Text(
                  "Search for salon service...".tr,
                  maxLines: 1,
                  softWrap: false,
                  overflow: TextOverflow.fade,
                  style: Get.textTheme.bodySmall,
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () {
                  Get.bottomSheet(
                    SubCategoryBottomSheet(),
                    isScrollControlled: true,
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 10, left: 10, top: 10, bottom: 10),
                  child: Image.asset(
                    "assets/img_new/ic_filter.png",
                    width: 21,
                  ),
                ),
                // child: Container(
                //   padding: const EdgeInsets.only(
                //       right: 10, left: 10, top: 10, bottom: 10),
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.all(Radius.circular(8)),
                //     color: Get.theme.focusColor.withOpacity(0.1),
                //   ),
                //   child: Wrap(
                //     crossAxisAlignment: WrapCrossAlignment.center,
                //     spacing: 4,
                //     children: [
                //       Text("Filter".tr, style: Get.textTheme.bodyMedium),
                //       Image.asset(
                //         "assets/img_new/ic_filter.png",
                //         width: 16,
                //       ),
                //     ],
                //   ),
                // ),
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
