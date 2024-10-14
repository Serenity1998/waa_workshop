/*
 * File name: filter_bottom_sheet_widget.dart
 * Last modified: 2022.02.10 at 02:22:41
 * Author: SmarterVision - https://codecanyon.net/user/smartervision
 * Copyright (c) 2022
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../search/controllers/search_controller.dart';
import 'block_button_widget.dart';

class FilterBottomSheetWidget extends GetView<SearchControllerCustom> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 1.2,
      decoration: BoxDecoration(
        color: Get.theme.primaryColor,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(40), topLeft: Radius.circular(40)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Center(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
          Center(
            child: Text(
              "Шүүлтүүр",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Divider(
              color: Colors.grey[300],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Text("Ангилал"),
          ),
          Container(
            height: 44,
            child: Obx(() {
              controller.hasSubCategory.value =
                  controller.currentCategory != null;
              RxInt itemCount = controller.categories.length.obs + 1;

              if (controller.hasSubCategory.value) {
                controller.categories.value =
                    controller.currentCategory.subCategories!;
                itemCount.value =
                    controller.currentCategory.subCategories!.length + 1;
              } else {
                controller.categories.value = controller.mainCategories;
              }

              return ListView.builder(
                  padding: EdgeInsets.only(left: 16),
                  scrollDirection: Axis.horizontal,
                  itemCount: itemCount.value,
                  itemBuilder: ((context, index) {
                    // var cat = controller.categories[index - 1];
                    if (index == 0) {
                      return Container(
                          margin: EdgeInsets.only(right: 10),
                          child: GestureDetector(
                            onTap: () {
                              controller.selectedCategories.clear();
                              controller.selectedCategories.refresh();
                              controller.categories.refresh();
                              controller.textEditingController.clear();
                              controller.selectedCategoriesName.value = [];
                            },
                            child: Chip(
                              label: Text(
                                "Бүгд",
                                style: Get.textTheme.bodyLarge?.merge(TextStyle(
                                    color: controller.selectedCategories.isEmpty
                                        ? Colors.white
                                        : Get.theme.focusColor)),
                              ),
                              backgroundColor:
                                  controller.selectedCategories.isEmpty
                                      ? Get.theme.focusColor
                                      : Colors.white,
                              side: BorderSide(color: Get.theme.focusColor),
                            ),
                          ));
                    }
                    return Container(
                        margin: EdgeInsets.only(right: 10),
                        child: GestureDetector(
                          onTap: () {
                            controller.toggleCategory(
                                false, controller.categories[index - 1]);

                            controller.selectedCategories.refresh();
                            controller.categories.refresh();
                            controller.textEditingController.clear();
                          },
                          child: Chip(
                            label: Text(
                              controller.categories[index - 1].name!,
                              style: Get.textTheme.bodyLarge?.merge(TextStyle(
                                  color: controller.isSelectedCategory(
                                          controller.categories[index - 1])
                                      ? Colors.white
                                      : Get.theme.focusColor)),
                            ),
                            backgroundColor: controller.isSelectedCategory(
                                    controller.categories[index - 1])
                                ? Get.theme.focusColor
                                : Colors.white,
                            side: BorderSide(color: Get.theme.focusColor),
                          ),
                        ));
                  }));
            }),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Text("Үнэ"),
          ),
          Container(
            width: Get.width,
            child: SfSliderTheme(
              data: SfSliderThemeData(
                  tooltipBackgroundColor: Get.theme.focusColor,
                  thumbColor: Colors.white,
                  thumbStrokeColor: Get.theme.focusColor,
                  thumbStrokeWidth: 2),
              child: Obx(() {
                return SfRangeSlider(
                  min: 0.0,
                  max: 400.0,
                  values: controller.priceRange.value,
                  interval: 50,
                  showTicks: true,
                  showLabels: true,
                  enableTooltip: true,
                  minorTicksPerInterval: 0,
                  labelFormatterCallback: ((actualValue, formattedText) {
                    return "$formattedText${"K"}";
                  }),
                  tooltipTextFormatterCallback: ((actualValue, formattedText) {
                    double val = actualValue;
                    return "${val.toInt()}${"K"}";
                  }),
                  onChanged: (SfRangeValues values) {
                    controller.priceRange.value = values;
                  },
                );
              }),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Text("Үнэлгээ"),
          ),
          Container(
            height: 44,
            child: Obx(() {
              if (controller.starList.length == 1) {
                debugPrint("${controller.starList.length}");
              }
              return ListView.builder(
                  padding: EdgeInsets.only(left: 16),
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.starList.length + 1,
                  itemBuilder: ((context, index) {
                    if (index == 0) {
                      return Container(
                          margin: EdgeInsets.only(right: 10),
                          child: GestureDetector(
                            onTap: () {
                              controller.star.value = 0;
                              controller.starList.refresh();
                            },
                            child: Chip(
                              label: Text(
                                "Бүгд",
                                style: Get.textTheme.bodyLarge?.merge(TextStyle(
                                    color:
                                        controller.star.value - index == index
                                            ? Colors.white
                                            : Get.theme.focusColor)),
                              ),
                              backgroundColor: controller.star.value == index
                                  ? Get.theme.focusColor
                                  : Colors.white,
                              side: BorderSide(color: Get.theme.focusColor),
                            ),
                          ));
                    }
                    var realValue = 6 - index;
                    return Container(
                        margin: EdgeInsets.only(right: 10),
                        child: GestureDetector(
                          onTap: () {
                            controller.star.value = realValue;
                            controller.starList.refresh();
                          },
                          child: Chip(
                            avatar: Icon(Icons.star_rounded,
                                size: 16,
                                color: controller.starList[index - 1] ==
                                        controller.star.value
                                    ? Colors.white
                                    : Get.theme.focusColor),
                            label: Text(
                              "${controller.starList[index - 1]}",
                              style: Get.textTheme.bodyLarge?.merge(TextStyle(
                                  color: controller.starList[index - 1] ==
                                          controller.star.value
                                      ? Colors.white
                                      : Get.theme.focusColor)),
                            ),
                            backgroundColor: controller.starList[index - 1] ==
                                    controller.star.value
                                ? Get.theme.focusColor
                                : Colors.white,
                            side: BorderSide(color: Get.theme.focusColor),
                          ),
                        ));
                  }));
            }),
          ),
          SizedBox(
            height: 60,
            child: Obx(() {
              return Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: RadioListTile(
                      value: true,
                      groupValue: controller.isCustomerAddress.value,
                      onChanged: (value) {
                        controller.isCustomerAddress.value = value!;
                      },
                      title: Text(
                        'Өөрийн хаягаар',
                        style: TextStyle(
                          color: Color(0xff212121),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: RadioListTile(
                      value: false,
                      groupValue: controller.isCustomerAddress.value,
                      onChanged: (value) {
                        controller.isCustomerAddress.value = value!;
                      },
                      title: Text(
                        'Байгууллагын хаягаар',
                        style: TextStyle(
                          color: Color(0xff212121),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 44,
                  width: (Get.width - 60) / 2,
                  child: BlockButtonWidget(
                      color: Color(0xFFF1E7FF),
                      text: 'Дахин тохируулах',
                      onPressed: () {
                        controller.selectedCategories.clear();
                        controller.categories.refresh();
                      }),
                ),
                const SizedBox(width: 10),
                Container(
                  height: 44,
                  width: (Get.width - 32) / 2,
                  child: BlockButtonWidget(
                      color: Get.theme.focusColor,
                      text: 'Шүүлтүүр',
                      onPressed: () {
                        controller.textEditingController.clear();
                        if (controller.tabIndex.value == 0) {
                          controller.searchEServices(keywords: '');
                        } else {
                          controller.searchSalons(keywords: '');
                        }
                        Get.back();
                      }),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
