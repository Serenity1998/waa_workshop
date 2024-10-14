/*
 * File name: rating_controller.dart
 * Last modified: 2022.02.10 at 17:59:22
 * Author: SmarterVision - https://codecanyon.net/user/smartervision
 * Copyright (c) 2022
 */

import 'dart:async';

import 'package:get/get.dart';

import '../../../../common/helper.dart';
import '../../../../common/ui.dart';
import '../../../models/booking_model.dart';
import '../../../models/review_model.dart';
import '../../../repositories/booking_repository.dart';

class RatingController extends GetxController {
  final review = new Review(rate: 0).obs;
  late BookingRepository _bookingRepository;

  RatingController() {
    _bookingRepository = new BookingRepository();
  }

  @override
  void onInit() {
    review.value.booking = Get.arguments as Booking;
    super.onInit();
  }

  Future addReview(context) async {
    try {
      if (review.value.rate! < 1) {
        Get.showSnackbar(Ui.ErrorSnackBar(
            message:
                "Please rate this salon services by clicking on the stars".tr));
        return;
      }
      if (review.value.review == null || review.value.review!.isEmpty) {
        Get.showSnackbar(Ui.ErrorSnackBar(
            message: "Tell us somethings about this salon services".tr));
        return;
      }
      await _bookingRepository.addReview(review.value);
      Get.back();
      Helper.basicAlert(
        context,
        'Амжилттай',
        "Баярлалаа, таны сэтгэгдлийг хүлээн авлаа",
        onOkText: 'ОК',
        onPressed: () => Get.back(),
      );
      // Timer(Duration(seconds: 2), () {
      //   Get.find<RootController>().changePage(0);
      // });
    } catch (e) {
      Get.back();
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }
}
