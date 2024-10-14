import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:im_stepper/stepper.dart';

import '../../../models/booking_model.dart';
import '../../../routes/app_routes.dart';
import '../../../services/global_service.dart';
import '../controllers/booking_controller.dart';
import '../controllers/bookings_controller.dart';

class BookiingStep extends GetView<BookingController> {
  final Booking booking;

  const BookiingStep({Key? key, required this.booking}) : super(key: key);

  List<Icon> buildStep() {
    var controller = Get.put(BookingsController());
    List<Icon> icons = [];
    var found = false;
    controller.bookingStatuses.forEach((element) {
      if (element.status != "Цуцлагдсан") {
        if (booking.status?.id == element.id || !found) {
          icons.add(Icon(
            Icons.check_circle_rounded,
            color: Colors.white,
          ));

          if (booking.status?.id == element.id) {
            found = true;
          }
        } else {
          icons.add(Icon(
            Icons.radio_button_off,
            color: Colors.white,
          ));
        }
      }
    });
    return icons;
  }

  String title() {
    if (controller.booking.value.status?.order ==
            Get.find<GlobalService>().global.value.done &&
        controller.booking.value.payment == null) {
      return "Go to Checkout".tr;
    } else if (controller.booking.value.status?.order ==
        Get.find<GlobalService>().global.value.accepted) {
      return "On the Way".tr;
    } else if (controller.booking.value.status?.order ==
        Get.find<GlobalService>().global.value.onTheWay) {
      return "Ready".tr;
    } else if (controller.booking.value.status?.order ==
        Get.find<GlobalService>().global.value.ready) {
      return "Start".tr;
    } else if (controller.booking.value.status?.order ==
        Get.find<GlobalService>().global.value.inProgress) {
      return "Finish".tr;
    } else if (controller.booking.value.status?.order ==
            Get.find<GlobalService>().global.value.done &&
        controller.booking.value.payment != null) {
      return "Leave a Review".tr;
    } else if (controller.booking.value.status?.order ==
            Get.find<GlobalService>().global.value &&
        controller.booking.value.payment != null) {
      return "Leave a Review".tr;
    }
    return controller.booking.value.status!.status!;
  }

  void ontap() {
    var controller = Get.put(BookingController());
    if (controller.booking.value.status?.order ==
            Get.find<GlobalService>().global.value.done &&
        controller.booking.value.payment == null) {
      Get.toNamed(Routes.CHECKOUT, arguments: booking);
    } else if (controller.booking.value.status?.order ==
        Get.find<GlobalService>().global.value.accepted) {
      controller.onTheWayBookingService();
    } else if (controller.booking.value.status?.order ==
        Get.find<GlobalService>().global.value.onTheWay) {
      controller.readyBookingService();
    } else if (controller.booking.value.status?.order ==
        Get.find<GlobalService>().global.value.ready) {
      controller.startBookingService();
    } else if (controller.booking.value.status?.order ==
        Get.find<GlobalService>().global.value.inProgress) {
      controller.finishBookingService();
    } else if (controller.booking.value.status?.order ==
            Get.find<GlobalService>().global.value.done &&
        controller.booking.value.payment != null) {
      Get.toNamed(Routes.RATING, arguments: booking);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      print("obx...");
      return Container(
        padding: EdgeInsets.only(bottom: 40),
        color: Colors.black87,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            controller.booking.value.status?.status == "Цуцлагдсан"
                ? Container()
                : IconStepper(
                    activeStepBorderPadding: 0,
                    icons: buildStep(),

                    // activeStep property set to activeStep variable defined above.
                    activeStep: 1,
                    enableStepTapping: false,
                    stepColor: Colors.transparent,
                    activeStepBorderColor: Colors.transparent,
                    enableNextPreviousButtons: false,
                    steppingEnabled: false,
                    activeStepColor: Colors.transparent,
                    stepPadding: 0,
                    lineColor: Colors.white,
                    lineLength: 20,

                    lineDotRadius: 1,
                    // This ensures step-tapping updates the activeStep.
                    onStepReached: (index) {},
                  ),
            GestureDetector(
              onTap: ontap,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Center(
                    child: Text(
                  "${title()}",
                  style: TextStyle(color: Colors.white),
                )),
              ),
            )
          ],
        ),
      );
    });
  }
}
