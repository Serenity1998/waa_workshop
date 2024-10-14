/*
 * File name: booking_summary_view.dart
 * Last modified: 2022.02.14 at 11:32:21
 * Author: SmarterVision - https://codecanyon.net/user/smartervision
 * Copyright (c) 2022
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' show DateFormat;

import '../../../../common/helper.dart';
import '../../../../common/ui.dart';
import '../../../providers/laravel_provider.dart';
import '../../checkout/controllers/checkout_controller.dart';
import '../../global_widgets/block_button_widget.dart';
import '../../global_widgets/main_appbar.dart';
import '../controllers/book_e_service_controller.dart';
import 'common_row_widget.dart';

class BookingSummaryView extends GetView<BookEServiceController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const MainAppBar(title: "Захиалгын хураангуй"),
        bottomNavigationBar: Obx(
          () => BlockButtonWidget(
                  text: "Захиалга өгөх".tr,
                  onPressed: controller.isLoading.value
                      ? () {}
                      : () async {
                          controller.isLoading.value = true;
                          Helper.basicLoader();
                          var checkOutController =
                              Get.put(CheckoutController());
                          checkOutController.booking.value =
                              controller.booking.value;
                          checkOutController.fetchData();
                          checkOutController.createBooking(
                              controller.booking.value, context);
                          Get.find<LaravelApiClient>()
                              .isLoading(task: "addBooking");
                          Get.back();
                          controller.isLoading.value = false;
                        })
              .paddingSymmetric(vertical: 20, horizontal: 30),
        ),
        body: Stack(
          children: [
            ListView(
              padding: EdgeInsets.all(20),
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: Ui.getBoxDecorationLessShadow(radius: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonRowWidget(
                        name: "Бизнес эрхлэгч",
                        value: controller.booking.value.salon?.name.toString(),
                      ),
                      CommonRowWidget(
                          name: "Цаг захиалсан огноо",
                          nameColor: Get.theme.focusColor,
                          value:
                              "${DateFormat("MMMEd", "mn").format(controller.booking.value.bookingAt!)} | ${DateFormat("Hm").format(controller.booking.value.bookingAt!)}"),
                      CommonRowWidget(
                          name: "Захиалга өгсөн огноо",
                          nameColor: Get.theme.focusColor,
                          value:
                              "${DateFormat("MMMEd", "mn").format(DateTime.now())} | ${DateFormat("Hm").format(DateTime.now())}"),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: Ui.getBoxDecorationLessShadow(radius: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: controller.booking.value.eServices!
                              .map((e) => CommonRowWidget(
                                    name: e.name!,
                                    value: Ui.currencyFormat(e.price!),
                                  ))
                              .toList()),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CommonRowWidget(
                            name: "Хямдрал",
                            nameColor: Get.theme.focusColor,
                            value: "₮ 0.0",
                          ),
                          Divider(color: Colors.grey[300]),
                          CommonRowWidget(
                            name: "Нийт",
                            value: Ui.currencyFormat(
                                controller.booking.value.getTotal()),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ));
  }
}
