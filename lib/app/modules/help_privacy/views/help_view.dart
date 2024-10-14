/*
 * File name: help_view.dart
 * Last modified: 2022.08.16 at 12:12:50
 * Author: SmarterVision - https://codecanyon.net/user/smartervision
 * Copyright (c) 2022
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../common/ui.dart';
import '../../../providers/laravel_provider.dart';
import '../../global_widgets/circular_loading_widget.dart';
import '../../global_widgets/tab_bar_widget.dart';
import '../controllers/help_controller.dart';
import '../widgets/faq_item_widget.dart';

class HelpView extends GetView<HelpController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              iconTheme: IconThemeData(color: Get.theme.hintColor),
              bottom: controller.faqCategories.isEmpty
                  ? TabBarLoadingWidget()
                  : TabBar(
                      tabs: [
                        Tab(text: "FAQ"),
                        Tab(text: "Холбоо барих"),
                      ],
                      indicatorWeight: 4,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      indicatorColor: Get.theme.focusColor,
                    ),
              title: Text(
                "Тусламжийн төв".tr,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              actions: [
                Image.asset(
                  "assets/img_new/ic_location.png",
                  width: 24,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 27, left: 20),
                  child: Image.asset(
                    "assets/img_new/ic_scan.png",
                    width: 22,
                  ),
                )
              ],
              automaticallyImplyLeading: false,
              leading: Container(
                margin: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Get.theme.primaryColor.withOpacity(0.5),
                ),
                child: new IconButton(
                  icon: new Icon(Icons.arrow_back,
                      size: 22, color: Get.theme.hintColor),
                  onPressed: Get.back,
                ),
              ),
              leadingWidth: 50,
            ),
            backgroundColor: Colors.white,
            body: TabBarView(children: [
              RefreshIndicator(
                onRefresh: () async {
                  Get.find<LaravelApiClient>().forceRefresh();
                  controller.refreshFaqs(
                    showMessage: true,
                    categoryId: Get.find<TabBarController>(tag: '/help')
                        .selectedId
                        .value,
                  );
                  Get.find<LaravelApiClient>().unForceRefresh();
                },
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      controller.faqCategories.isEmpty
                          ? Container()
                          : TabBarWidget(
                              tag: 'help',
                              initialSelectedId:
                                  controller.faqCategories.elementAt(0).id,
                              tabs: List.generate(
                                  controller.faqCategories.length, (index) {
                                // var _category =
                                //     controller.faqCategories.elementAt(index);
                                return GestureDetector(
                                  onTap: (() {
                                    controller.getFaqs(
                                        categoryId:
                                            controller.faqCategories[index].id);
                                    controller.selectedIndex.value = index;
                                  }),
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 12),
                                    child: Chip(
                                      label: Text(
                                        "${controller.faqCategories[index].name}",
                                        style: Get.textTheme.bodyLarge?.merge(
                                            TextStyle(
                                                color: controller.selectedIndex
                                                            .value ==
                                                        index
                                                    ? Colors.white
                                                    : Get.theme.focusColor)),
                                      ),
                                      backgroundColor:
                                          controller.selectedIndex.value ==
                                                  index
                                              ? Get.theme.focusColor
                                              : Colors.white,
                                      side: BorderSide(
                                          color: Get.theme.focusColor),
                                    ),
                                  ),
                                );
                              }),
                            ),
                      // NewsSearchBar(),
                      // Text("Help & Support".tr, style: Get.textTheme.headlineSmall),
                      // Text("Most frequently asked questions".tr,
                      //         style: Get.textTheme.bodySmall)
                      //     .paddingSymmetric(vertical: 5),
                      Obx(() {
                        if (Get.find<LaravelApiClient>()
                            .isLoading(task: 'getFaqs')) {
                          return CircularLoadingWidget(height: 300);
                        } else {
                          return ListView.separated(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            primary: false,
                            itemCount: controller.faqs.length,
                            separatorBuilder: (context, index) {
                              return SizedBox(height: 15);
                            },
                            itemBuilder: (context, indexFaq) {
                              return GestureDetector(
                                onTap: () {
                                  controller.selectedFaq.value =
                                      controller.faqs[indexFaq].id!;
                                },
                                child: FaqItemWidget(
                                    faq: controller.faqs.elementAt(indexFaq)),
                              );
                            },
                          );
                        }
                      }),
                    ],
                  ),
                ),
              ),
              ListView.builder(
                  padding: EdgeInsets.only(top: 12),
                  itemCount: controller.contact.length,
                  itemBuilder: ((context, index) {
                    return GestureDetector(
                      onTap: () {
                        if (index != 0) {
                          final Uri url = Uri.parse(controller.link[index]);
                          launchUrl(url);
                        } else {
                          controller.startChat();
                        }
                      },
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        height: 72,
                        decoration: Ui.getBoxDecoration(radius: 20),
                        child: Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 26, right: 18),
                              child: Image.asset(
                                "assets/img_new/${controller.contactIcon[index]}.png",
                                width: 20,
                              ),
                            ),
                            Text(
                              controller.contact[index],
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    );
                  }))
            ])),
      );
    });
  }
}
