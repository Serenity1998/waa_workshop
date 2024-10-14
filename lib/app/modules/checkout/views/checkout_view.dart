/*
 * File name: checkout_view.dart
 * Last modified: 2022.08.14 at 17:06:04
 * Author: SmarterVision - https://codecanyon.net/user/smartervision
 * Copyright (c) 2022
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/booking_model.dart';
import '../../global_widgets/block_button_widget.dart';
import '../../global_widgets/circular_loading_widget.dart';
import '../../global_widgets/main_appbar.dart';
import '../controllers/checkout_controller.dart';
import '../widgets/payment_details_widget.dart';
import '../widgets/payment_method_item_widget.dart';

class CheckoutView extends GetView<CheckoutController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(title: "Checkout".tr, centerTitle: true),
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.loadPaymentMethodsList();
          await controller.loadWalletList();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Obx(() {
            if (controller.isLoading.isTrue) {
              return CircularLoadingWidget(height: 200);
            }
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 0),
                    leading: Icon(
                      Icons.payment,
                      color: Get.theme.hintColor,
                    ),
                    title: Text(
                      "Payment Option".tr,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Get.textTheme.headlineSmall,
                    ),
                    subtitle: Text("Select your preferred payment mode".tr,
                        style: Get.textTheme.bodySmall),
                  ),
                ),
                ListView.separated(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  primary: false,
                  itemCount: controller.paymentsList.length,
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 10);
                  },
                  itemBuilder: (context, index) {
                    var _paymentMethod =
                        controller.paymentsList.elementAt(index);
                    return PaymentMethodItemWidget(
                        paymentMethod: _paymentMethod);
                  },
                ),
              ],
            );
          }),
        ),
      ),
      bottomNavigationBar: buildBottomWidget(Get.arguments as Booking, context),
    );
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
          Obx(() {
            return BlockButtonWidget(
              text: "Confirm & Pay Now".tr,
              color: Get.theme.colorScheme.secondary,
              onPressed:
                  // Get.find<LaravelApiClient>().isLoading(task: "addBooking",ta)
                  // ? null
                  // :
                  () async {
                await controller.createBooking(_booking, context);
                await controller.payBooking(_booking, context);
              },
            );
          }).paddingSymmetric(vertical: 10, horizontal: 20),
        ],
      ),
    );
  }
}
