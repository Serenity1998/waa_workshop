import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/news_controller.dart';

class NewsFilter extends GetWidget<NewsController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: EdgeInsets.only(top: 20),
      child: ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 16),
          scrollDirection: Axis.horizontal,
          itemCount: controller.filters.length + 1,
          itemBuilder: ((context, index) {
            return Obx(() {
              if (index == 0) {
                return Container(
                    margin: EdgeInsets.only(right: 10),
                    child: GestureDetector(
                      onTap: () {
                        controller.selectedIndex.value = index;
                      },
                      child: Chip(
                        label: Text(
                          "Бүгд",
                          style: Get.textTheme.bodyLarge?.merge(TextStyle(
                              color: controller.selectedIndex.value == index
                                  ? Colors.white
                                  : Get.theme.focusColor)),
                        ),
                        backgroundColor: controller.selectedIndex.value == index
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
                      controller.selectedIndex.value = index;
                      print(controller.selectedIndex.value);
                    },
                    child: Chip(
                      label: Text(
                        "${controller.filters[index - 1]}",
                        style: Get.textTheme.bodyLarge?.merge(TextStyle(
                            color: controller.selectedIndex.value == index
                                ? Colors.white
                                : Get.theme.focusColor)),
                      ),
                      backgroundColor: controller.selectedIndex.value == index
                          ? Get.theme.focusColor
                          : Colors.white,
                      side: BorderSide(color: Get.theme.focusColor),
                    ),
                  ));
            });
          })),
    );
  }
}
