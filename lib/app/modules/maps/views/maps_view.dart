/*
 * File name: maps_view.dart
 * Last modified: 2022.02.26 at 14:50:11
 * Author: SmarterVision - https://codecanyon.net/user/smartervision
 * Copyright (c) 2022
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import '../../../routes/app_routes.dart';
import '../../global_widgets/main_appbar.dart';
import '../../search/controllers/search_controller.dart' as search;
import '../controllers/maps_controller.dart';
import '../widgets/maps_carousel_widget.dart';
import '../widgets/maps_list_widget.dart';

class MapsView extends GetView<MapsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: "Байршлаар хайх".tr,
        actions: [
          InkWell(
            onTap: () async {
              Get.put(search.SearchControllerCustom()).clear();
              await Get.put(search.SearchControllerCustom()).getSearchHistory();
              Get.toNamed(Routes.SEARCH, arguments: 'from_map');
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
            onTap: () => Get.toNamed(Routes.QR_SCANNER),
            child: Padding(
              padding: const EdgeInsets.only(right: 25, left: 15),
              child: Image.asset(
                "assets/img_new/ic_scan.png",
                width: 22,
              ),
            ),
          ),
        ],
      ),

      body: Stack(
        children: [
          Obx(
            () => Stack(
              alignment: Alignment.bottomCenter,
              children: [
                if (controller.isList.value)
                  Container(
                    child: MapsListWidget(),
                    margin: const EdgeInsets.only(top: 80),
                  )
                else
                  GoogleMap(
                    mapToolbarEnabled: false,
                    zoomControlsEnabled: false,
                    myLocationButtonEnabled: false,
                    zoomGesturesEnabled: true,
                    myLocationEnabled: false,
                    mapType: MapType.normal,
                    initialCameraPosition: controller.cameraPosition.value,
                    markers: Set.from(controller.allMarkers),
                    onMapCreated: (GoogleMapController _controller) {
                      // controller.mapController.value = _controller;
                    },
                    onCameraMoveStarted: () {
                      controller.salons.clear();
                    },
                    onCameraMove: (CameraPosition cameraPosition) {
                      controller.cameraPosition.value = cameraPosition;
                    },
                    onCameraIdle: () {
                      controller.getNearSalons();
                    },
                    onTap: (arg) {},
                  ),
              ],
            ),
          ),
          Column(
            children: [
              Container(
                width: double.infinity,
                color: Colors.white,
                height: 45,
                child: Obx(
                  () => ListView(
                    primary: false,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: List.generate(
                      controller.categories.length + 1,
                      (index) {
                        if (index == 0) {
                          return Padding(
                            padding:
                                const EdgeInsetsDirectional.only(start: 20),
                            child: RawChip(
                              elevation: 0,
                              label: Text("Бүгд"),
                              labelStyle: controller.selectedCategory.isEmpty
                                  ? Get.textTheme.bodyMedium?.merge(
                                      TextStyle(color: Get.theme.primaryColor))
                                  : Get.textTheme.bodyMedium!
                                      .copyWith(color: Get.theme.focusColor),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 5),
                              backgroundColor: Colors.white,
                              selectedColor: Get.theme.focusColor,
                              selected: controller.selectedCategory.isEmpty,
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: Get.theme.focusColor, width: 1),
                                  borderRadius: BorderRadius.circular(100)),
                              showCheckmark: false,
                              checkmarkColor: Get.theme.primaryColor,
                              onSelected: (bool value) async {
                                var _filter =
                                    controller.categories.elementAt(index - 1);
                                controller.toggleCategory(value, _filter);
                                controller.selectedCategory.clear();
                              },
                            ),
                          );
                        }
                        var _filter =
                            controller.categories.elementAt(index - 1);

                        return Padding(
                          padding: const EdgeInsetsDirectional.only(start: 20),
                          child: RawChip(
                            elevation: 0,
                            label: Text("${_filter.name}"),
                            labelStyle: controller.selectedCategory
                                    .contains(_filter.id)
                                ? Get.textTheme.bodyMedium?.merge(
                                    TextStyle(color: Get.theme.primaryColor))
                                : Get.textTheme.bodyMedium!
                                    .copyWith(color: Get.theme.focusColor),
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 5),
                            backgroundColor: Colors.white,
                            selectedColor: Get.theme.focusColor,
                            selected: controller.selectedCategory
                                .contains(_filter.id),
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: Get.theme.focusColor, width: 1),
                                borderRadius: BorderRadius.circular(100)),
                            showCheckmark: false,
                            checkmarkColor: Get.theme.primaryColor,
                            onSelected: (bool value) async {
                              controller.toggleCategory(value, _filter);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              Container(
                color: Get.theme.primaryColor,
                child: DefaultTabController(
                  length: 2,
                  child: TabBar(
                    controller: controller.tabController,
                    tabs: [
                      Tab(text: "Үйлчилгээгээр"),
                      Tab(text: "Бизнес эрхлэгч"),
                    ],
                    indicatorWeight: 4,
                    onTap: (value) async {
                      controller.tabIndex.value = value;
                      await controller.pageController.animateToPage(
                        value,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn,
                      );
                    },
                    unselectedLabelColor: Get.theme.disabledColor,
                    labelStyle: Get.textTheme.bodyMedium?.merge(
                      TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Get.theme.focusColor,
                      ),
                    ),
                    labelColor: Get.theme.focusColor,
                    indicator: MaterialIndicator(
                      height: 4,
                      topLeftRadius: 8,
                      topRightRadius: 8,
                      color: Get.theme.focusColor,
                      horizontalPadding: 8,
                      tabPosition: TabPosition.bottom,
                    ),
                  ),
                ),
              ),
              Spacer(),
              Obx(
                () => SizedBox(
                  height: controller.isList.value ? 80 : 220,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: controller.isList.value
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.spaceBetween,
                          children: [
                            if (!controller.isList.value)
                              InkWell(
                                onTap: () {
                                  controller.isList.value = false;
                                  controller.navigateCurrentLocation();
                                },
                                child: Container(
                                    height: 56,
                                    width: 56,
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Get.theme.focusColor,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black45,
                                          blurRadius: 8.0,
                                        ),
                                      ],
                                      gradient: LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: [
                                          Color(0xff7210FF),
                                          Color(0xff9D59FF),
                                        ],
                                      ),
                                    ),
                                    child: Image.asset(
                                      'assets/img_new/ic_get_location.png',
                                      width: 20,
                                      height: 20,
                                    )),
                              ),
                            InkWell(
                              highlightColor: Colors.black12,
                              onTap: () {
                                controller.isList.value =
                                    !controller.isList.value;
                              },
                              child: Container(
                                height: 56,
                                width: 56,
                                padding: const EdgeInsets.all(18),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Get.theme.focusColor,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black45,
                                      blurRadius: 8.0,
                                    ),
                                  ],
                                  gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      Color(0xff7210FF),
                                      Color(0xff9D59FF),
                                    ],
                                  ),
                                ),
                                child: Image.asset(
                                  !controller.isList.value
                                      ? 'assets/img_new/ic_list.png'
                                      : 'assets/img_new/ic_map.png',
                                  width: 20,
                                  height: 20,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      if (!controller.isList.value)
                        Container(
                          height: 160,
                          child: MapsCarouselWidget(),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      // Column(
      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //   children: [
      // Padding(
      //   padding: const EdgeInsets.only(top: 18),
      //   child: Container(
      //       height: 55,
      //       width: Get.width - 44,
      //       child: TextFormField(
      //         onChanged: (value) async {
      //           controller.searchText.value = value;
      //           controller.selectedSalon = null;
      //         },
      //         onFieldSubmitted: (val) async {
      //           debugPrint("Val :$val");
      //           await controller.getNearSalons();
      //         },
      //         decoration: InputDecoration(
      //             enabledBorder: OutlineInputBorder(
      //                 borderSide:
      //                     BorderSide(color: Colors.grey[100])),
      //             border: OutlineInputBorder(
      //                 borderSide:
      //                     BorderSide(color: Colors.grey[100])),
      //             hintText: "Компаний нэрээр хайх",
      //             hintStyle: TextStyle(color: Colors.grey),
      //             prefixIcon: Icon(Icons.search),
      //             fillColor: Colors.grey[100],
      //             suffixIcon: IconButton(
      //               icon: Icon(Icons.clear),
      //               onPressed: () {
      //                 FocusManager.instance.primaryFocus?.unfocus();
      //               },
      //             ),
      //             filled: true),
      //       )),
      // ),

      //   ],
      // ),
      // ],
      //   ),
      // ),
    );
  }
}
