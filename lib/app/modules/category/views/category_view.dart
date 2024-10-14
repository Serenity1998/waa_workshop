/*
 * File name: category_view.dart
 * Last modified: 2022.02.13 at 19:23:03
 * Author: SmarterVision - https://codecanyon.net/user/smartervision
 * Copyright (c) 2022
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
// import 'package:url_launcher/url_launcher_string.dart';
import '../../../../common/qr_scanner.dart';
import '../../../providers/laravel_provider.dart';
import '../../../routes/app_routes.dart';
import '../../global_widgets/main_appbar.dart';
import '../../search/controllers/search_controller.dart';
import '../controllers/category_controller.dart';
import '../widgets/companies_list_widget.dart';
import '../widgets/services_list_widget.dart';

class CategoryView extends GetView<CategoryController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: GestureDetector(
        onTap: () => Get.toNamed(Routes.MAPS),
        child: Container(
          height: 56,
          width: 56,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            boxShadow: const [
              BoxShadow(
                color: Colors.black45,
                blurRadius: 8.0,
              ),
            ],
            gradient: const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color(0xff7210FF),
                Color(0xff9D59FF),
              ],
            ),
          ),
          child: Center(
            child:
                Image.asset('assets/img_new/ic_map.png', width: 25, height: 25),
          ),
        ),
      ),
      appBar: MainAppBar(
        title: "${controller.category.value.name}",
        actions: [
          InkWell(
            onTap: () {
              Get.put(SearchControllerCustom()).clear();
              Get.put(SearchControllerCustom()).isService.value =
                  controller.tabIndex.value == 0;
              Get.put(SearchControllerCustom()).currentCategory =
                  controller.category.value;
              Get.put(SearchControllerCustom()).getSearchHistory();
              Get.toNamed(Routes.SEARCH);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Image.asset(
                "assets/img_new/ic_search_grey.png",
                width: 22,
                color: Get.theme.focusColor,
              ),
            ),
          ),
          InkWell(
            onTap: () => Get.to(() => QrScanner(onScanned: () {})),
            child: Container(
              padding: const EdgeInsets.only(right: 20, left: 10),
              child: Image.asset(
                "assets/img_new/ic_scan.png",
                width: 24,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                elevation: 0,
                floating: true,
                automaticallyImplyLeading: false,
                title: Container(
                  height: 60,
                  child: Obx(() {
                    return ListView(
                        primary: false,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        children: List.generate(
                            controller.category.value.subCategories!.length + 1,
                            (index) {
                          if (index == 0) {
                            return Obx(() {
                              return Padding(
                                padding:
                                    const EdgeInsetsDirectional.only(start: 20),
                                child: RawChip(
                                  elevation: 0,
                                  label: Text("Бүгд"),
                                  labelStyle: controller
                                          .selectedSubCategory.isEmpty
                                      ? Get.textTheme.bodyMedium?.merge(
                                          TextStyle(
                                              color: Get.theme.primaryColor))
                                      : Get.textTheme.bodyMedium?.copyWith(
                                          color: Get.theme.focusColor),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 5),
                                  backgroundColor: Colors.white,
                                  selectedColor: Get.theme.focusColor,
                                  selected:
                                      controller.selectedSubCategory.isEmpty,
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: Get.theme.focusColor,
                                          width: 1),
                                      borderRadius: BorderRadius.circular(100)),
                                  showCheckmark: false,
                                  checkmarkColor: Get.theme.primaryColor,
                                  onSelected: (bool value) {
                                    controller.selectedSubCategory.clear();
                                    controller.page.value = 0;
                                    controller.loadEServicesOfCategory(
                                        "${controller.category.value.id}",
                                        filter: controller.selected.value);
                                  },
                                ),
                              );
                            });
                          }
                          var _filter = controller.category.value.subCategories!
                              .elementAt(index - 1);

                          return Obx(() {
                            return Padding(
                              padding:
                                  const EdgeInsetsDirectional.only(start: 20),
                              child: RawChip(
                                elevation: 0,
                                label: Text("${_filter.name}"),
                                labelStyle: controller.selectedSubCategory
                                        .contains(_filter.id)
                                    ? Get.textTheme.bodyMedium?.merge(TextStyle(
                                        color: Get.theme.primaryColor))
                                    : Get.textTheme.bodyMedium!
                                        .copyWith(color: Get.theme.focusColor),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 5),
                                backgroundColor: Colors.white,
                                selectedColor: Get.theme.focusColor,
                                selected: controller.selectedSubCategory
                                    .contains(_filter.id),
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: Get.theme.focusColor, width: 1),
                                    borderRadius: BorderRadius.circular(100)),
                                showCheckmark: false,
                                checkmarkColor: Get.theme.primaryColor,
                                onSelected: (bool value) {
                                  controller.toggleSubCategory(value, _filter);
                                  controller.loadEServicesOfCategory(
                                      "${controller.category.value.id}",
                                      filter: controller.selected.value);
                                  controller.loadEServicesByCompany(
                                      " ${controller.category.value.id}");
                                },
                              ),
                            );
                          });
                        }));
                  }),
                ),
              ),
              SliverAppBar(
                elevation: 0,
                pinned: true,
                automaticallyImplyLeading: false,
                flexibleSpace: PreferredSize(
                  preferredSize: const Size(30, 30),
                  child: SizedBox(
                    height: kToolbarHeight,
                    child: TabBar(
                      indicator: MaterialIndicator(
                        height: 4,
                        topLeftRadius: 8,
                        topRightRadius: 8,
                        color: Get.theme.focusColor,
                        horizontalPadding: 8,
                        tabPosition: TabPosition.bottom,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      labelStyle: Get.textTheme.bodyLarge?.merge(
                        TextStyle(
                            fontSize: 16,
                            color: Get.theme.focusColor,
                            fontWeight: FontWeight.w600),
                      ),
                      controller: controller.tabController,
                      indicatorColor: Get.theme.focusColor,
                      labelColor: Get.theme.focusColor,
                      unselectedLabelColor: Colors.grey,
                      onTap: (value) {
                        controller.tabIndex.value = value;
                        controller.changeTab();
                        controller.statusType.refresh();
                        controller.pageController.animateToPage(
                          int.parse('$value'),
                          duration: const Duration(microseconds: 400),
                          curve: Curves.easeInOut,
                        );
                      },
                      tabs: const [
                        Tab(text: "Үйлчилгээгээр"),
                        Tab(text: "Мэргэжилтэнээр"),
                      ],
                    ),
                  ),
                ),
              ),
            ];
          },
          body: Container(
            child: Column(
              children: [
                Expanded(
                  child: PageView(
                    controller: controller.pageController,
                    onPageChanged: (page) {
                      controller.tabIndex.value = page;
                      controller.tabController.index = page;
                    },
                    children: [
                      RefreshIndicator(
                        onRefresh: () async {
                          Get.find<LaravelApiClient>().forceRefresh();
                          controller.refreshEServices(showMessage: true);
                          Get.find<LaravelApiClient>().unForceRefresh();
                        },
                        child: SingleChildScrollView(
                          child: ServicesListWidget(),
                        ),
                      ),
                      RefreshIndicator(
                        onRefresh: () async {
                          Get.find<LaravelApiClient>().forceRefresh();
                          controller.refreshEServices(showMessage: true);
                          Get.find<LaravelApiClient>().unForceRefresh();
                        },
                        child: SingleChildScrollView(
                          child: CompaniesListWidget(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //   Positioned(
  //     right: 15,
  //     bottom: 90,
  //     child: GestureDetector(
  //       onTap: () {
  //         // launchUrlString(
  //         //     "tel:${controller.booking.value.salon?.phoneNumber ?? ''}");
  //       },
  //       child: Container(
  //         height: 50,
  //         width: 50,
  //         child: Center(
  //           child: Image.asset('assets/img_new/ic_calling.png',
  //               width: 25, height: 25),
  //         ),
  //         decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(50),
  //             color: Get.theme.focusColor),
  //       ),
  //     ),
  //   )

  Widget headerComponent(String title, int index) {
    return Obx(() {
      return Container(
        height: 44,
        width: Get.width / 2,
        child: Center(
          child: Text(
            title,
            style: Get.textTheme.bodyLarge?.merge(
              TextStyle(
                fontSize: 16,
                color: controller.tabIndex.value == index
                    ? Get.theme.focusColor
                    : Colors.grey,
                fontWeight: controller.tabIndex.value == index
                    ? FontWeight.w600
                    : FontWeight.w400,
              ),
            ),
          ),
        ),
      );
    });
  }
}
