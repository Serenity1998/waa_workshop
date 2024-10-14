/*
 * File name: favorites_view.dart
 * Last modified: 2022.08.16 at 12:14:04
 * Author: SmarterVision - https://codecanyon.net/user/smartervision
 * Copyright (c) 2022
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import '../../../../common/empty_view.dart';
import '../../../../common/helper.dart';
import '../../../providers/laravel_provider.dart';
import '../../category/widgets/companies_list_item_widget.dart';
import '../../category/widgets/services_list_item_widget.dart';
import '../../global_widgets/main_appbar.dart';
import '../../salon/widgets/services_list_loader_widget.dart';
import '../controllers/favorites_controller.dart';

class FavoritesView extends GetView<FavoritesController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(title: "Тэмдэглэсэн үйлчилгээнүүд"),
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
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

                        controller.pageController.animateToPage(
                          value,
                          duration: const Duration(microseconds: 400),
                          curve: Curves.easeInOut,
                        );
                      },
                      tabs: const [
                        Tab(text: "Үйлчилгээгээр"),
                        Tab(text: "Бизнес эрхлэгч"),
                      ],
                    ),
                  ),
                ),
              ),
            ];
          },
          body: Obx(
            () {
              if (Get.find<LaravelApiClient>()
                  .isLoading(task: 'getFavoritesEServices')) {
                return ServicesListLoaderWidget();
              } else {
                return PageView(
                  onPageChanged: (value) {
                    controller.tabController.index = value;
                    controller.tabIndex.value = value;
                    controller.tabController.animateTo(value);
                  },
                  controller: controller.pageController,
                  children: [
                    controller.eServices.isEmpty
                        ? EmptyView(
                            title:
                                "Танд одоогоор тэмдэглэсэн үйлчилгээ байхгүй байна",
                          )
                        : ListView.builder(
                            padding: EdgeInsets.only(bottom: 10, top: 10),
                            primary: false,
                            shrinkWrap: true,
                            itemCount: controller.eServices.length,
                            itemBuilder: ((_, index) {
                              return ServicesListItemWidget(
                                service: controller.eServices[index],
                                favouriteClicked: () async {
                                  Helper.basicBottomSheet(
                                    'Цуцлах',
                                    'Устгах',
                                    Get.back,
                                    () {
                                      if (controller
                                              .eServices[index].isFavorite ??
                                          false) {
                                        controller.removeFromFavorite(
                                            service:
                                                controller.eServices[index]);
                                        controller.eServices.remove(
                                            controller.eServices[index]);
                                      } else {
                                        controller.addToFavorite(
                                            service:
                                                controller.eServices[index]);
                                        controller.eServices
                                            .add(controller.eServices[index]);
                                      }
                                      controller.refreshFavorites();
                                      Get.back();
                                    },
                                    'Тэмдэглэсэн хэсгээс хасах уу?',
                                    ServicesListItemWidget(
                                      service: controller.eServices[index],
                                      isFromFavorite: true,
                                    ),
                                  );
                                },
                              );
                            }),
                          ),
                    controller.salons.isEmpty
                        ? EmptyView(
                            title:
                                "Танд одоогоор тэмдэглэсэн компани байхгүй байна",
                          )
                        : ListView.builder(
                            padding: EdgeInsets.only(bottom: 10, top: 10),
                            primary: false,
                            shrinkWrap: true,
                            itemCount: controller.salons.length,
                            itemBuilder: ((_, index) {
                              return CompaniesListItemWidget(
                                salon: controller.salons[index],
                                favouriteClicked: () async {
                                  Helper.basicBottomSheet(
                                    'Цуцлах',
                                    'Устгах',
                                    Get.back,
                                    () {
                                      if (controller.salons[index].isFavorite ??
                                          false) {
                                        controller.removeFromFavorite(
                                            salon: controller.salons[index]);
                                        controller.salons
                                            .remove(controller.salons[index]);
                                      } else {
                                        controller.addToFavorite(
                                            salon: controller.salons[index]);
                                        controller.salons
                                            .add(controller.salons[index]);
                                      }
                                      controller.refreshFavorites();
                                    },
                                    'Тэмдэглэсэн хэсгээс хасах уу?',
                                    CompaniesListItemWidget(
                                      salon: controller.salons[index],
                                      isFromFavorite: true,
                                    ),
                                  );
                                },
                              );
                            }),
                          ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
