/*
 * File name: book_e_service_view.dart
 * Last modified: 2022.03.11 at 23:35:29
 * Author: SmarterVision - https://codecanyon.net/user/smartervision
 * Copyright (c) 2022
 */

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:save_time_customer/app/modules/book_e_service/views/salon_employee_widget.dart';
import 'package:save_time_customer/app/modules/book_e_service/widgets/date_list_item_widget.dart';
import 'package:save_time_customer/helpers/color.dart';

import '../../../../common/helper.dart';
import '../../../../common/ui.dart';
import '../../../models/booking_model.dart';
import '../../../providers/laravel_provider.dart';
import '../../../routes/app_routes.dart';
import '../../global_widgets/block_button_widget.dart';
import '../../global_widgets/main_appbar.dart';
import '../controllers/book_e_service_controller.dart';

class BookEServiceView extends GetView<BookEServiceController> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MainAppBar(title: "Book the Service".tr),
        bottomNavigationBar: buildBlockButtonWidget(controller.booking.value),
        body: RefreshIndicator(
            onRefresh: () async {
              Get.find<LaravelApiClient>().forceRefresh();
              controller.onInit();
              Get.find<LaravelApiClient>().unForceRefresh();
            },
            child: CustomScrollView(
              shrinkWrap: true,
              controller: scrollController,
              slivers: [
                SliverToBoxAdapter(
                  child: Wrap(
                    children: [
                      Container(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Ажилтан сонгох".tr,
                                style: context.textTheme.headlineSmall,
                              ),
                            ),
                            InkWell(
                                onTap: () {
                                  Get.toNamed(Routes.CATEGORIES);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, top: 10, bottom: 10),
                                  child: SvgPicture.asset(
                                      'assets/icon/category.svg',
                                      width: 18),
                                )),
                          ],
                        ),
                      ),
                      Obx(() {
                        return Container(
                            margin: const EdgeInsets.only(
                                left: 14.0, right: 17, top: 6),
                            child: Stack(
                              children: [
                                CarouselSlider(
                                  options: CarouselOptions(
                                      enableInfiniteScroll: false,
                                      autoPlay: true,
                                      disableCenter: false,
                                      padEnds: false,
                                      height: 170,
                                      autoPlayInterval:
                                          const Duration(seconds: 7),
                                      viewportFraction: 0.86),
                                  items: controller.employees.map((slide) {
                                    return SalonEmployeeItem(
                                      employee: slide,
                                    );
                                  }).toList(),
                                ),
                              ],
                            ));
                      }),
                      Container(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Өдрөө сонгоно уу!".tr,
                                style: context.textTheme.headlineSmall,
                              ),
                            ),
                            InkWell(
                                onTap: () {
                                  Get.toNamed(Routes.CATEGORIES);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, top: 10, bottom: 10),
                                  child: SvgPicture.asset(
                                      'assets/img_new/calendar.svg',
                                      width: 18),
                                )),
                          ],
                        ),
                      ),
                      Obx(() {
                        return Container(
                            margin: const EdgeInsets.only(
                                left: 14.0, right: 17, top: 6),
                            child: Stack(
                              children: [
                                CarouselSlider(
                                  options: CarouselOptions(
                                      enableInfiniteScroll: false,
                                      disableCenter: false,
                                      padEnds: false,
                                      height: 90,
                                      autoPlayInterval:
                                          const Duration(seconds: 7),
                                      viewportFraction: 0.18),
                                  items: controller.next10Days.map((slide) {
                                    return DateListItemWidget(
                                      onSelect: () {
                                        controller.selectDate(slide);
                                      },
                                      selected:
                                          controller.selectedDate.value.day ==
                                                  slide.day
                                              ? true
                                              : false,
                                      dateTime: slide,
                                    );
                                  }).toList(),
                                ),
                              ],
                            ));
                      }),
                      Container(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 40, bottom: 20),
                        child: Text(
                          "Цагаа сонгоно уу!".tr,
                          style: context.textTheme.headlineSmall,
                        ),
                      ),
                      Obx(() {
                        return GridView.builder(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio:
                                        ((context.width - 40) / 2) / 40,
                                    crossAxisSpacing: 8,
                                    mainAxisSpacing: 8),
                            itemCount: controller.allTimes.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                  key: UniqueKey(),
                                  onTap: () => controller.selectBookingTime(
                                      controller.allTimes[index]),
                                  child: Container(
                                      height: 40,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 20),
                                      decoration: BoxDecoration(
                                        color: controller
                                                    .booking.value.bookingAt ==
                                                controller.allTimes[index]
                                            ? CoreColor.primary
                                            : CoreColor.white,
                                        border: Border.all(
                                          color: CoreColor.primary,
                                        ),
                                        borderRadius: BorderRadius.circular(80),
                                      ),
                                      child: Row(
                                        children: [
                                          convertDateTimeToTime(
                                              controller.allTimes[index],
                                              context)
                                        ],
                                      )));
                            });
                      })
                    ],
                  ),
                )
              ],
            )));
  }

  void validateNow() {
    var availeble = controller.isDayAvailable(DateTime.now());

    if (availeble == null) {
      Get.showSnackbar(Ui.ErrorSnackBar(
          message: "Таны сонгосон өдөр энэ байгууллага хаалттай байна.".tr));
      return;
    }

    var time =
        TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute);
    var start = availeble.timeOfDay(availeble.startAt!);
    var end = availeble.timeOfDay(availeble.endAt!);

    if (Helper.minTimeDay(time) < Helper.minTimeDay(end) ||
        Helper.minTimeDay(time) > Helper.minTimeDay(start)) {
      Get.showSnackbar(Ui.ErrorSnackBar(
          message:
              "${DateFormat('d, MMMM y HH:mm', Get.locale.toString()).format(DateTime.now())} -ны цагт салон хаалттай байна"
                  .tr));
      return;
    }

    controller.booking.value.bookingAt = DateTime.now();
    controller.bookingTime.value = "now";
  }

  Widget serviceNumberWidget() {
    return Container(
      decoration: Ui.getBoxDecorationLessShadow(),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Үйлчилгээний тоо"),
                Text(
                  "Үйлчилгээний нийт тоогоор төлбөр\nнэмэгдэнэ",
                  style: Get.textTheme.bodySmall,
                )
              ],
            ),
          ),
          Row(
            children: [
              Ui.addButton(() {
                if (controller.serviceCount.value > 1) {
                  controller.serviceCount.value -= 1;
                }
              }, icon: Icons.remove),
              Obx(() {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text("${controller.serviceCount.value}"),
                );
              }),
              Ui.addButton(
                () {
                  controller.serviceCount.value += 1;
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget buildBlockButtonWidget(Booking _booking) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
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
      child: Obx(() {
        return BlockButtonWidget(
          text: "Үргэлжлүүлэх".tr,
          onPressed: (controller.booking.value.bookingAt != null)
              ? () async {
                  controller.summarizeBooking();
                  Get.toNamed(Routes.BOOKING_SUMMARY);
                }
              : () {
                  if (controller.booking.value.bookingAt == null) {
                    Get.showSnackbar(Ui.defaultSnackBar(
                        message: "Захиалгын огноо цаг сонгоно уу".tr));
                  }
                },
        );
      }),
    );
  }

  Widget convertDateTimeToTime(DateTime dateTime, BuildContext context) {
    String formattedTime = DateFormat.Hm().format(dateTime);
    String endTime = DateFormat.Hm()
        .format(dateTime.add(Duration(minutes: controller.minuteRange.value)));
    return Text('$formattedTime-$endTime',
        style: context.textTheme.headlineSmall?.merge(TextStyle(
          color: controller.booking.value.bookingAt == dateTime
              ? CoreColor.white
              : CoreColor.primary,
        )));
  }
}
