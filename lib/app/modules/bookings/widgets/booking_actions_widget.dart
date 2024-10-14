import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/helper.dart';
import '../../../routes/app_routes.dart';
import '../../../services/global_service.dart';
import '../../global_widgets/block_button_widget.dart';
import '../controllers/booking_controller.dart';
import '../controllers/bookings_controller.dart';

class BookingActionsWidget extends GetView<BookingController> {
  const BookingActionsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _booking = controller.booking;
    return Obx(() {
      if (_booking.value.status == null) {
        return SizedBox(height: 0);
      }
      if (_booking.value.status?.order ==
          Get.find<GlobalService>().global.value.onTheWay) {
        return SizedBox(height: 0);
      } else {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: Get.theme.primaryColor,
            boxShadow: [
              BoxShadow(
                  color: Get.theme.focusColor.withOpacity(0.1),
                  blurRadius: 6,
                  offset: Offset(0, -2)),
            ],
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
          child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            if (_booking.value.status?.order ==
                Get.find<GlobalService>().global.value.received)
              // Expanded(
              //     child: BlockButtonWidget(
              //         text: Stack(
              //           alignment: AlignmentDirectional.centerEnd,
              //           children: [
              //             SizedBox(
              //               width: double.infinity,
              //               child: Text(
              //                 "Waiting".tr,
              //                 textAlign: TextAlign.center,
              //                 style: Get.textTheme.titleLarge.merge(
              //                   TextStyle(color: Colors.white),
              //                 ),
              //               ),
              //             ),
              //           ],
              //         ),
              //         color: Color(0xFFFFB800),
              //         onPressed: () {
              //           controller.onTheWayBookingService();
              //         })),
              Expanded(
                child: BlockButtonWidget(
                  text: "Төлбөр төлөх".tr,
                  onPressed: () =>
                      Get.toNamed(Routes.CHECKOUT, arguments: _booking.value),
                ),
              ),
            if (_booking.value.status?.order ==
                    Get.find<GlobalService>().global.value.done &&
                _booking.value.payment == null)
              Expanded(
                child: BlockButtonWidget(
                  text: "Төлбөр төлөх".tr,
                  onPressed: () =>
                      Get.toNamed(Routes.CHECKOUT, arguments: _booking.value),
                ),
              ),
            if (_booking.value.status?.order ==
                Get.find<GlobalService>().global.value.ready)
              Expanded(
                  child: BlockButtonWidget(
                      text: "Start".tr,
                      textColor: Get.theme.primaryColor,
                      color: Colors.white,
                      onPressed: () {
                        controller.startBookingService();
                      })),
            if (_booking.value.status?.order ==
                Get.find<GlobalService>().global.value.inProgress)
              Expanded(
                child: BlockButtonWidget(
                    text: "Finish".tr,
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
                    onPressed: () {
                      Get.toNamed(Routes.RATING, arguments: _booking.value);
                    }),
              ),
            SizedBox(width: 10),
            if (!_booking.value.cancel! &&
                _booking.value.status!.order! <
                    Get.find<GlobalService>().global.value.onTheWay!)
              Expanded(
                child: BlockButtonWidget(
                    text: "Цуцлах".tr,
                    color: Color(0xffF1E7FF),
                    onPressed: () {
                      Helper.basicBottomSheet(
                        'Буцах',
                        'Захиалга цуцлах',
                        () => Get.back(),
                        () {
                          Get.back();
                          controller.cancelBookingService().then((value) =>
                              Helper.basicAlert(context, "Захиалгыг цуцаллаа!",
                                  'Та үйлчилгээний захиалга амжилттай цуцлагдлаа. 97% нь таны дансанд буцаж орно.',
                                  img: "assets/img_new/success.png",
                                  onPressed: () {
                                Get.back();
                                Get.find<BookingsController>()
                                    .refreshBookings(statusId: 5);
                                Get.back();
                              }));
                        },
                        'Захиалга цуцлах',
                        Column(
                          children: [
                            // Divider(),
                            const SizedBox(height: 20),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                'Та үйлчилгээний захиалгаа цуцлахдаа итгэлтэй байна уу?',
                                style: Get.textTheme.titleSmall!
                                    .merge(TextStyle(color: Colors.black)),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                'Манай бодлогын дагуу таны төлбөрийн зөвхөн 97%-ийг буцаан авах боломжтой!',
                                style: Get.textTheme.bodyLarge!
                                    .merge(TextStyle(color: Colors.black)),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Divider(),
                          ],
                        ),
                      );
                    }),
              ),
          ]).paddingSymmetric(vertical: 10, horizontal: 20),
        );
      }
    });
  }
}
