/*
 * File name: search_view.dart
 * Last modified: 2022.02.10 at 15:02:14
 * Author: SmarterVision - https://codecanyon.net/user/smartervision
 * Copyright (c) 2022
 */

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import '../../../../common/empty_view.dart';
import '../../../providers/laravel_provider.dart';
import '../../category/widgets/companies_list_item_widget.dart';
import '../../category/widgets/services_list_item_widget.dart';
import '../../global_widgets/filter_bottom_sheet_widget.dart';
import '../../global_widgets/main_appbar.dart';
import '../controllers/search_controller.dart';

class SearchView extends GetView<SearchControllerCustom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: MainAppBar(title: 'Хайлт'),
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
                  child: DefaultTabController(
                    length: 2,
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
                      onTap: (int value) {
                        controller.tabIndex.value = value;
                        controller.pageController.animateToPage(
                          value,
                          duration: const Duration(milliseconds: 1),
                          curve: Curves.easeInOut,
                        );

                        controller.searchEServices(
                            keywords: controller.textEditingController.text);
                        controller.searchSalons(
                            keywords: controller.textEditingController.text);
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
          body: Column(
            children: [
              const SizedBox(height: 10),
              buildSearchBar(),
              Obx(() {
                if (controller.searchValue.isEmpty &&
                    controller.eServices.isEmpty &&
                    controller.salons.isEmpty)
                  return searchHistoryView();
                else if (controller.eServices.isEmpty &&
                    controller.salons.isEmpty &&
                    controller.searchValue.isNotEmpty)
                  return EmptyView();
                else
                  return Expanded(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: RichText(
                                  text: TextSpan(
                                    text:
                                        '"${controller.textEditingController.text}" ',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: Get.theme.focusColor),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: 'хайлтын үр дүн',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: Get.theme.hintColor),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                '${controller.tabIndex.value == 0 ? controller.eServices.length : controller.salons.length} олдсон',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Get.theme.focusColor,
                                ),
                              )
                            ],
                          ),
                        ),
                        Obx(() {
                          var eservices = controller.eServices;
                          var salons = controller.salons;
                          return Expanded(
                            child: DefaultTabController(
                              length: 2,
                              child: PageView(
                                controller: controller.pageController,
                                onPageChanged: (page) {
                                  controller.tabIndex.value = page;
                                  controller.tabController.animateTo(page);
                                  controller.searchEServices(
                                      keywords: controller
                                          .textEditingController.text);
                                  controller.searchSalons(
                                      keywords: controller
                                          .textEditingController.text);
                                },
                                children: [
                                  ListView.builder(
                                    padding:
                                        EdgeInsets.only(bottom: 10, top: 10),
                                    primary: false,
                                    shrinkWrap: true,
                                    itemCount: eservices.length,
                                    itemBuilder: ((_, index) {
                                      return ServicesListItemWidget(
                                          service: eservices[index]);
                                    }),
                                  ),
                                  ListView.builder(
                                    padding:
                                        EdgeInsets.only(bottom: 10, top: 10),
                                    primary: false,
                                    shrinkWrap: true,
                                    itemCount: salons.length,
                                    itemBuilder: ((_, index) {
                                      return CompaniesListItemWidget(
                                          salon: salons[index]);
                                    }),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  );
              })
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSearchBar() {
    return Hero(
      tag: Get.arguments ?? '',
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Material(
          child: TextField(
            controller: controller.textEditingController,
            style: Get.textTheme.bodyMedium,
            onChanged: (value) {
              controller.searchValue.value = value;
              controller.searchEServices(keywords: value);
              controller.searchSalons(keywords: value);
            },
            onSubmitted: (value) async {
              if (Get.arguments == 'from_map') {
                LatLng latLng;
                if (controller.salons.isNotEmpty) {
                  if (controller.salons.first.address != null) {
                    latLng = LatLng(controller.salons.first.address!.latitude!,
                        controller.salons.first.address!.longitude!);
                  }
                }

                // if (latLng != null) {
                //   MapsController mapsController = Get.put(MapsController());
                //   await mapsController.mapController.value
                //       .animateCamera(CameraUpdate.newCameraPosition(
                //     CameraPosition(
                //       target: LatLng(latLng.latitude, latLng.longitude),
                //       zoom: 15,
                //     ),
                //   ));
                // }

                Get.back();
              }
            },
            autofocus: controller.autoFocus.value,
            cursorColor: Get.theme.focusColor,
            decoration: InputDecoration(
              hintText: 'Хайх ...',
              hintStyle: TextStyle(color: Color(0xff757575)),
              fillColor: Color(0xFf7210FF).withOpacity(0.08),
              filled: true,
              prefixIcon: SizedBox(
                  height: 16,
                  width: 16,
                  child: Center(
                    child: SvgPicture.asset(
                      "assets/img_new/ic_svg",
                      height: 20,
                      width: 20,
                      alignment: Alignment.center,
                    ),
                  )),
              suffixIcon: IconButton(
                icon: SvgPicture.asset("assets/img_new/ic_filter.svg"),
                onPressed: () {
                  Get.bottomSheet(
                    FilterBottomSheetWidget(),
                    isScrollControlled: false,
                  );
                },
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Get.theme.focusColor,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(12)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Get.theme.focusColor,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ),
      ),
    );
  }

  Widget searchHistoryView() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(children: [
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Сүүлд хайсан',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              InkWell(
                onTap: () async => LaravelApiClient().deleteAllSearchHistory(),
                child: Text(
                  'Бүгдийг устгах',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Get.theme.focusColor,
                  ),
                ),
              )
            ],
          ),
        ),
        Obx(
          () => Column(
            children: controller.searchHistory.map((element) {
              return element['search'] != 'null' &&
                      element['search'].toString().isNotEmpty
                  ? Container(
                      height: 35,
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            element['search'],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff757575),
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              await LaravelApiClient()
                                  .deleteSearchHistory(element['search']);
                            },
                            child: Image.asset('assets/img_new/ic_close.png',
                                width: 22, height: 22),
                          )
                        ],
                      ),
                    )
                  : Container();
            }).toList(),
          ),
        ),
      ]),
    );
  }
}
