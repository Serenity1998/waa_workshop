/*
 * File name: booking_summary_view.dart
 * Last modified: 2022.02.14 at 11:32:21
 * Author: SmarterVision - https://codecanyon.net/user/smartervision
 * Copyright (c) 2022
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' show DateFormat;

import '../../../../common/ui.dart';
import '../../../models/booking_model.dart';
import '../../../providers/laravel_provider.dart';
import '../../checkout/controllers/checkout_controller.dart';
import '../../global_widgets/block_button_widget.dart';
import '../controllers/book_e_service_controller.dart';
import '../widgets/payment_details_widget.dart';

class BookingSummaryViewCopy extends GetView<BookEServiceController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Захиалгын хураангуй".tr,
            style: context.textTheme.titleLarge,
          ),
          centerTitle: false,
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          leading: Container(
            margin: EdgeInsets.only(left: 20),
            height: 20,
            width: 20,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Get.theme.primaryColor.withOpacity(0.5)),
            child: new IconButton(
              icon: new Icon(Icons.arrow_back,
                  size: 17, color: Get.theme.hintColor),
              onPressed: Get.back,
            ),
          ),
          elevation: 0,
        ),
        bottomNavigationBar:
            buildBottomWidget(controller.booking.value, context),
        body: ListView(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              decoration: Ui.getBoxDecoration(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Booking At".tr, style: Get.textTheme.bodyLarge),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.calendar_today_outlined,
                          color: Get.theme.focusColor),
                      SizedBox(width: 15),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              '${DateFormat.yMMMMEEEEd(Get.locale.toString()).format(controller.booking.value.bookingAt!)}',
                              style: Get.textTheme.bodyMedium),
                          Text(
                              '${DateFormat('HH:mm', Get.locale.toString()).format(controller.booking.value.bookingAt!)}',
                              style: Get.textTheme.bodyMedium),
                        ],
                      )),
                    ],
                  ),
                ],
              ),
            ),
            if (controller.booking.value.address == null)
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                decoration: Ui.getBoxDecoration(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${controller.booking.value.salon?.name}",
                      style: Get.textTheme.bodyLarge,
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.place_outlined, color: Get.theme.focusColor),
                        SizedBox(width: 15),
                        Expanded(
                          child: Obx(() {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                    "${controller.booking.value.salon?.address?.address}",
                                    style: Get.textTheme.bodyMedium),
                              ],
                            );
                          }),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            if (controller.booking.value.address != null)
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                decoration: Ui.getBoxDecoration(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Your Address".tr, style: Get.textTheme.bodyLarge),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.place_outlined, color: Get.theme.focusColor),
                        SizedBox(width: 15),
                        Expanded(
                          child: Obx(() {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                if (controller.booking.value.address!
                                    .hasDescription())
                                  Text(
                                      controller.booking.value.address
                                              ?.getDescription ??
                                          "Loading...".tr,
                                      style: Get.textTheme.titleSmall),
                                if (controller.booking.value.address!
                                    .hasDescription())
                                  SizedBox(height: 10),
                                Text(
                                    controller.booking.value.address?.address ??
                                        "Loading...".tr,
                                    style: Get.textTheme.bodyMedium),
                              ],
                            );
                          }),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            if (controller.booking.value.hint != null &&
                controller.booking.value.hint != "")
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                decoration: Ui.getBoxDecoration(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("A Hint for the Provider".tr,
                        style: Get.textTheme.bodyLarge),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.description_outlined,
                            color: Get.theme.focusColor),
                        SizedBox(width: 15),
                        Expanded(
                          child: Obx(() {
                            return Text(
                              "${controller.booking.value.hint}",
                              style: Get.textTheme.bodyMedium,
                            );
                          }),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
          ],
        ));
  }

  Widget buildBottomWidget(Booking _booking, BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: Get.theme.primaryColor,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
              color: Get.theme.focusColor.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(0, -5)),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PaymentDetailsWidget(booking: _booking),
          BlockButtonWidget(
              text: "Confirm & Booking Now".tr,
              onPressed: () async {
                var checkOutController = Get.put(CheckoutController());
                Get.find<LaravelApiClient>().isLoading(task: "addBooking");
                await checkOutController.createBooking(_booking, context);
                await checkOutController.payBooking(_booking, context);
              }).paddingSymmetric(vertical: 10, horizontal: 20),
        ],
      ),
    );
  }
}
