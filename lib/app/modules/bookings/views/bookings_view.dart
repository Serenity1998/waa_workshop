/*
 * File name: bookings_view.dart
 * Last modified: 2022.08.16 at 14:19:59
 * Author: SmarterVision - https://codecanyon.net/user/smartervision
 * Copyright (c) 2022
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import '../../../../common/empty_view.dart';
import '../../../../common/qr_scanner.dart';
import '../../../providers/laravel_provider.dart';
import '../../../routes/app_routes.dart';
import '../../auth/controllers/auth_controller.dart';
import '../../global_widgets/notifications_button_widget.dart';
import '../controllers/bookings_controller.dart';
import '../widgets/bookings_list_widget.dart';

class BookingsView extends GetView<BookingsController> {
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => AuthController());
    controller.initScrollController();
    controller.firstLevelPage.value = 0;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Миний захиалга",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        centerTitle: false,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () => Scaffold.of(context).openDrawer(),
          child: Container(
            margin: const EdgeInsets.only(left: 15),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Get.theme.primaryColor.withOpacity(0.5),
            ),
            child: Image.asset("assets/img_new/ic_logo.png"),
          ),
        ),
        actions: const [NotificationsButtonWidget()],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // if (!Get.find<LaravelApiClient>().isLoading(task: 'getBookings')) {
          //   Get.find<LaravelApiClient>().forceRefresh();
          //   controller.refreshBookings(
          //       showMessage: true, statusId: controller.currentStatus.value);
          //   Get.find<LaravelApiClient>().unForceRefresh();
          // }
        },
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: DefaultTabController(
                  length: controller.firstLeveltabs.length,
                  child: TabBar(
                    tabs: controller.firstLeveltabs,
                    indicatorWeight: 4,
                    isScrollable: false,
                    labelPadding: const EdgeInsets.symmetric(horizontal: 10),
                    onTap: ((value) {
                      controller.changeFirstLevelTab(value);
                    }),
                  )),
            ),
            Obx(() {
              if (controller.firstLevelPage.value == 0) {
                return EmptyView(
                    title: 'Захиалга байхгүй байна',
                    buttonTap: () => Get.toNamed(Routes.SALON),
                    buttonText: 'Шинэ захиалга өгөх',
                    message:
                        'Танд хүлээгдэж буй захиалга алга. Доорх товчийг дарж шинэ захиалгаа өгнө үү');
              } else {
                return BookingsListWidget();
              }
            }),

            // DefaultTabController(
            //   length: controller.bookingStatusesLength.value,
            //   child: TabBar(
            //     tabs: controller.tabs,
            //     indicatorWeight: 4,
            //     isScrollable: true,
            //     labelPadding: const EdgeInsets.symmetric(horizontal: 10),
            //     onTap: ((value) {
            //       controller.changeTab(value);
            //     }),
            //     unselectedLabelColor: Get.theme.disabledColor,
            //     labelStyle: Get.textTheme.bodyMedium?.merge(
            //       TextStyle(
            //         fontSize: 18,
            //         fontWeight: FontWeight.w500,
            //         color: Get.theme.focusColor,
            //       ),
            //     ),
            //     labelColor: Get.theme.focusColor,
            //     padding: const EdgeInsets.only(left: 10),
            //     indicator: MaterialIndicator(
            //       height: 4,
            //       topLeftRadius: 8,
            //       topRightRadius: 8,
            //       color: Get.theme.focusColor,
            //       horizontalPadding: 8,
            //       tabPosition: TabPosition.bottom,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
