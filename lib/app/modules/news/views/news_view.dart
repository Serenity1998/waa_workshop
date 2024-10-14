import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../global_widgets/news_search.dart';
import '../controllers/news_controller.dart';
import '../widgets/news_cell.dart';
import '../widgets/news_filter.dart';
import '../widgets/video_cell.dart';

class NewsView extends GetView<NewsController> {
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => NewsController());

    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Мэдээ".tr,
            style: Get.textTheme.titleLarge,
          ),
          centerTitle: false,
          leading: GestureDetector(
            onTap: () => Scaffold.of(context).openDrawer(),
            child: Container(
              margin: EdgeInsets.only(left: 20),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Get.theme.primaryColor.withOpacity(0.5),
              ),
              child: Image.asset("assets/img_new/ic_logo.png"),
            ),
          ),
          elevation: 0,
          actions: [
            GestureDetector(
              onTap: () {
                Get.toNamed(Routes.MAPS);
              },
              child: Image.asset(
                "assets/img_new/ic_location.png",
                width: 24,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 27, left: 20),
              child: Image.asset(
                "assets/img_new/ic_scan.png",
                width: 22,
              ),
            ),
          ],
          bottom: NewsSearchBar()),
      body: ListView(
        children: [
          NewsFilter(),
          VideoCell(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Онцлох мэдээ",
                  style: Get.textTheme.titleLarge,
                ),
                Text(
                  "Бүгдийг харах",
                  style: TextStyle(color: Get.theme.focusColor),
                )
              ],
            ),
          ),
          NewsCell(),
          VideoCell(),
        ],
      ),
    );
  }
}
