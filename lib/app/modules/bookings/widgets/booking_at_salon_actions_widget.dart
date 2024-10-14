import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../../services/global_service.dart';
import '../../global_widgets/block_button_widget.dart';
import '../controllers/booking_controller.dart';

class BookingAtSalonActionsWidget extends GetView<BookingController> {
  const BookingAtSalonActionsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _booking = controller.booking;
    return Obx(() {
      if (_booking.value.status == null) {
        return SizedBox(height: 0);
      }
      return Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Get.theme.focusColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
                color: Colors.white.withOpacity(0.1),
                blurRadius: 10,
                offset: Offset(0, -5)),
          ],
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          if (_booking.value.status?.order ==
                  Get.find<GlobalService>().global.value.done &&
              _booking.value.payment == null)
            Expanded(
              child: BlockButtonWidget(
                  text: "Go to Checkout".tr,
                  color: Get.theme.colorScheme.secondary,
                  onPressed: () {
                    Get.toNamed(Routes.CHECKOUT, arguments: _booking.value);
                  }),
            ),
          if (_booking.value.status?.order ==
              Get.find<GlobalService>().global.value.received)
            Expanded(
                child: BlockButtonWidget(
                    text: "Waiting".tr,
                    color: Color(0xFFFFB800),
                    onPressed: () {
                      controller.onTheWayBookingService();
                    })),
          if (_booking.value.status?.order ==
              Get.find<GlobalService>().global.value.accepted)
            Expanded(
                child: BlockButtonWidget(
                    text: "Ticket".tr,
                    color: Color(0xFF09D436),
                    onPressed: () {
                      Get.toNamed(Routes.BOOKING_TICKET);
                      //controller.onTheWayBookingService();
                    })),
          if (_booking.value.status?.order ==
              Get.find<GlobalService>().global.value.onTheWay)
            Expanded(
              child: BlockButtonWidget(
                  text: "Ready".tr,
                  color: Colors.white,
                  onPressed: () {
                    controller.readyBookingService();
                  }),
            ),
          if (_booking.value.status?.order ==
              Get.find<GlobalService>().global.value.ready)
            Expanded(
                child: BlockButtonWidget(
                    text: "Start".tr,
                    color: Colors.white,
                    onPressed: () {
                      controller.startBookingService();
                    })),
          if (_booking.value.status?.order ==
              Get.find<GlobalService>().global.value.inProgress)
            Expanded(
              child: BlockButtonWidget(
                  text: "Finish".tr,
                  color: Colors.white,
                  onPressed: () {
                    controller.finishBookingService();
                  }),
            ),
          if (_booking.value.status!.order! >=
                  Get.find<GlobalService>().global.value.done! &&
              _booking.value.payment != null)
            Expanded(
              child: BlockButtonWidget(
                  text: "Leave a Review".tr,
                  color: Colors.white,
                  onPressed: () {
                    Get.toNamed(Routes.RATING, arguments: _booking.value);
                  }),
            ),
          SizedBox(width: 10),
          if (!_booking.value.cancel! &&
              _booking.value.status!.order! <
                  Get.find<GlobalService>().global.value.onTheWay!)
            MaterialButton(
              onPressed: () {
                controller.cancelBookingService();
              },
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              color: Colors.white.withOpacity(0.2),
              child: Text("Cancel".tr,
                  style: Get.textTheme.bodyMedium!
                      .merge(TextStyle(color: Colors.white))),
              elevation: 0,
            ),
        ]).paddingSymmetric(vertical: 10, horizontal: 20),
      );
    });
  }
}
