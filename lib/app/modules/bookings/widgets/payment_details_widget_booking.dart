/*
 * File name: payment_details_widget.dart
 * Last modified: 2022.02.12 at 01:39:43
 * Author: SmarterVision - https://codecanyon.net/user/smartervision
 * Copyright (c) 2022
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/ui.dart';
import '../../../models/booking_model.dart';
import 'booking_row_widget.dart';

class PaymentDetailsWidgetBookinig extends StatelessWidget {
  const PaymentDetailsWidgetBookinig({
    Key? key,
    required Booking booking,
  })  : _booking = booking,
        super(key: key);

  final Booking _booking;

  @override
  Widget build(BuildContext context) {
    List<Widget> _paymentDetails = [
      Column(
        children: List.generate(_booking.taxes!.length, (index) {
          var _tax = _booking.taxes!.elementAt(index);
          return BookingRowWidget(
              description: "${_tax.name}",
              textColor: Colors.white,
              child: Align(
                alignment: Alignment.centerRight,
                child: _tax.type == 'percent'
                    ? Text(_tax.value.toString() + '%',
                        style: Get.textTheme.bodyLarge!
                            .merge(TextStyle(color: Colors.white)))
                    : Ui.getPrice(
                        _tax.value!,
                        style: Get.textTheme.bodyLarge!
                            .merge(TextStyle(color: Colors.white)),
                      ),
              ),
              hasDivider: (_booking.taxes!.length - 1) == index);
        }),
      ),
      // BookingRowWidget(
      //   description: "Tax Amount".tr,
      //   child: Align(
      //     alignment: Alignment.centerRight,
      //     child: Ui.getPrice(_booking.getTaxesValue(), style: Get.textTheme.titleSmall),
      //   ),
      //   hasDivider: false,
      // ),
      // BookingRowWidget(
      //     description: "Subtotal".tr,
      //     textColor: Colors.white,
      //     child: Align(
      //       alignment: Alignment.centerRight,
      //       child: Ui.getPrice(_booking.getSubtotal(),
      //           style: Get.textTheme.titleSmall
      //               .merge(TextStyle(color: Colors.white))),
      //     ),
      //     hasDivider: true),
      if ((_booking.getCouponValue() > 0))
        BookingRowWidget(
            description: "Coupon".tr,
            textColor: Colors.white,
            child: Align(
              alignment: Alignment.centerRight,
              child: Wrap(
                children: [
                  Text(' - ', style: Get.textTheme.bodyLarge),
                  Ui.getPrice(_booking.getCouponValue(),
                      style: Get.textTheme.bodyLarge!
                          .merge(TextStyle(color: Colors.white))),
                ],
              ),
            ),
            hasDivider: true),
      BookingRowWidget(
        textColor: Colors.white,
        description: "Total Amount".tr,
        child: Align(
          alignment: Alignment.centerRight,
          child: Ui.getPrice(_booking.getTotal(),
              style: Get.textTheme.titleLarge!
                  .merge(TextStyle(color: Colors.white))),
        ),
      ),
    ];
    _booking.eServices?.forEach((_eService) {
      var _options = _booking.options
          ?.where((option) => option.eServiceId == _eService.id);
      _paymentDetails.insert(
        0,
        Wrap(
          children: [
            BookingRowWidget(
              textColor: Colors.white,
              description: "${_eService.name}",
              child: Align(
                alignment: Alignment.centerRight,
                child: Ui.getPrice(_eService.getPrice!,
                    style: Get.textTheme.titleSmall!
                        .merge(TextStyle(color: Colors.white))),
              ),
              hasDivider: true,
            ),
            Column(
              children: List.generate(_options!.length, (index) {
                var _option = _options.elementAt(index);
                return BookingRowWidget(
                    description: "${_option.name}",
                    textColor: Colors.white,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Ui.getPrice(_option.price!,
                          style: Get.textTheme.bodyLarge!
                              .merge(TextStyle(color: Colors.white))),
                    ),
                    hasDivider: (_options.length - 1) == index);
              }),
            ),
          ],
        ),
      );
    });
    return Column(
      children: _paymentDetails,
    );
  }
}
