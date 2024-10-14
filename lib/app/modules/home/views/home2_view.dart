/*
 * File name: home2_view.dart
 * Last modified: 2022.02.17 at 09:53:26
 * Author: SmarterVision - https://codecanyon.net/user/smartervision
 * Copyright (c) 2022
 */

import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/svg.dart';
import 'package:save_time_customer/app/modules/home/controllers/home_controller.dart';
import 'package:save_time_customer/app/modules/salon/widgets/salon_list_item_widget.dart';

import '../../../../common/ui.dart';
import '../../../models/category_model.dart';
import '../../category/widgets/category_grid_item_widget.dart';
import '../../category/widgets/services_list_item_widget.dart';
import '../../global_widgets/circular_loading_widget.dart';

import '../../global_widgets/address_widget.dart';

import '../../../../helpers/global_functions.dart';

import '../../../../helpers/core_url.dart';

import '../../../../helpers/global_variables.dart';
import '../../../services/get_service.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';
import '../../../services/auth_service.dart';
import '../../global_widgets/notifications_button_widget.dart';
import '../widgets/slide_item_widget.dart';

class HomeView extends GetView<HomeController> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
          onRefresh: () async {},
          child: CustomScrollView(
            // primary: true,
            shrinkWrap: false,
            controller: scrollController,
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                elevation: 0,
                pinned: true,
                iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
                centerTitle: false,
                title: !Get.find<AuthService>().isAuth
                    ? Container(
                        child: Text(
                          "Save time",
                          style: context.textTheme.titleLarge,
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${GlobalFunc.greetingType()}",
                                  overflow: TextOverflow.ellipsis,
                                  style: Get.textTheme.bodySmall,
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  Get.find<AuthService>().user.value.name ??
                                      "Unknown",
                                  overflow: TextOverflow.fade,
                                  style: context.textTheme.bodyMedium,
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 10),
                            child: Image.asset(
                              'assets/img_new/ic_smile.png',
                              width: 22,
                              height: 22,
                            ),
                          )
                        ],
                      ),
                leadingWidth: 50,
                leading: GestureDetector(
                  onTap: () => Scaffold.of(context).openDrawer(),
                  child: Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(90),
                      child: Get.find<AuthService>().user.value.avatar?.url !=
                              null
                          ? CachedNetworkImage(
                              imageUrl: Get.find<AuthService>()
                                  .user
                                  .value
                                  .avatar!
                                  .url!,
                            )
                          : Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Get.theme.colorScheme.primary,
                                      width: 2),
                                  shape: BoxShape.circle,
                                  color: Get.theme.dividerColor),
                              child: SvgPicture.asset('assets/icon/user.svg'),
                            ),
                    ),
                  ),
                ),
                actions: const [
                  NotificationsButtonWidget(),
                ],
                // bottom: HomeSearchBarWidget(),
              ),
              SliverToBoxAdapter(
                child: Wrap(
                  children: [
                    Container(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Ангилал".tr,
                              style: context.textTheme.headlineSmall,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Get.toNamed(Routes.CATEGORIES);
                            },
                            child: Text(
                              "Бүгдийг харах".tr,
                              style: TextStyle(
                                color: context.theme.secondaryHeaderColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    ///category carousel
                    Container(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Obx(() {
                        if (controller.categories.isEmpty) {
                          return CircularLoadingWidget(
                            height: 300,
                          );
                        } else {
                          return GridView.count(
                            controller:
                                ScrollController(keepScrollOffset: false),
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            addAutomaticKeepAlives: false,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 0.85,
                            primary: false,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            crossAxisCount:
                                MediaQuery.of(context).orientation ==
                                        Orientation.portrait
                                    ? 4
                                    : 6,
                            children: controller.categories
                                .map(
                                  (element) => CategoryGridItemWidget(
                                    category: element,
                                    heroTag: "heroTag",
                                  ),
                                )
                                .toList(),
                          );
                        }
                      }),
                    ),

                    Container(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Бизнес эрхлэгчид".tr,
                              style: context.textTheme.headlineSmall,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Get.toNamed(Routes.CATEGORIES);
                            },
                            child: Text(
                              "Бүгдийг харах".tr,
                              style: TextStyle(
                                color: context.theme.secondaryHeaderColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Obx(() {
                      return Container(
                          margin: const EdgeInsets.only(
                              left: 14.0, right: 17, top: 15),
                          child: Stack(
                            children: [
                              CarouselSlider(
                                options: CarouselOptions(
                                  autoPlay: true,
                                  disableCenter: false,
                                  padEnds: false,
                                  height: 270,
                                  autoPlayInterval: const Duration(seconds: 7),
                                  viewportFraction: 0.76,
                                  onPageChanged: (index, reason) {
                                    controller.currentSlide.value = index;
                                  },
                                ),
                                items: controller.salons.map((slide) {
                                  return SalonListItemWidget(
                                    salon: slide,
                                  );
                                }).toList(),
                              ),
                            ],
                          ));
                    }),

                    Container(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Санал болгох".tr,
                              style: context.textTheme.headlineSmall,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Get.toNamed(Routes.CATEGORIES);
                            },
                            child: Text(
                              "Бүгдийг харах".tr,
                              style: TextStyle(
                                color: context.theme.secondaryHeaderColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      padding: const EdgeInsets.only(bottom: 75),
                      child: Obx(() {
                        if (controller.salons.isEmpty) {
                          return CircularLoadingWidget(
                            height: 300,
                          );
                        } else {
                          return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.eServices.length,
                              padding: const EdgeInsets.all(0),
                              itemBuilder: (itemBuilder, index) {
                                return ServicesListItemWidget(
                                    service: controller.eServices[index]);
                              });
                        }
                      }),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
