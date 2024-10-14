/*
 * File name: booking_view.dart
 * Last modified: 2022.05.19 at 12:10:11
 * Author: SmarterVision - https://codecanyon.net/user/smartervision
 * Copyright (c) 2022
 */

import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../common/map.dart';
import '../../../../common/ui.dart';
import '../../../../helpers/color.dart';
import '../../../models/booking_model.dart';
import '../../../providers/laravel_provider.dart';
import '../../../services/global_service.dart';
import '../../global_widgets/block_button_widget.dart';
import '../controllers/booking_controller.dart';
import '../widgets/booking_actions_widget.dart';
import '../widgets/booking_at_salon_actions_widget.dart';
import '../widgets/booking_row_widget.dart';
import '../widgets/booking_til_widget.dart';
import '../widgets/booking_title_bar_widget.dart';
import '../widgets/payment_details_widget_booking.dart';
import 'booking_detail.dart';
import 'booking_timer.dart';

class BookingViewNew extends GetView<BookingController> {
  @override
  Widget build(BuildContext context) {
    controller.initScrollController();
    return Scaffold(
      body: RefreshIndicator(
          onRefresh: () async {
            Get.find<LaravelApiClient>().forceRefresh();
            controller.refreshBooking(showMessage: true);
            Get.find<LaravelApiClient>().unForceRefresh();
          },
          child: CustomScrollView(
            primary: true,
            shrinkWrap: false,
            slivers: <Widget>[
              SliverAppBar(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  pinned: true,
                  title: const Text('Үйлчилгээ'),
                  leading: IconButton(
                    icon: Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Get.theme.primaryColor.withOpacity(0.5),
                      ),
                      child: Icon(Icons.arrow_back,
                          size: 18, color: Get.theme.hintColor),
                    ),
                    onPressed: Get.back,
                  )),
              SliverToBoxAdapter(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Container(
                          padding: const EdgeInsets.only(
                              top: 20, left: 20, bottom: 20, right: 10),
                          margin: const EdgeInsets.only(left: 5),
                          decoration: Ui.getBoxDecoration(
                              radius: 32,
                              color: Colors.white,
                              border:
                                  Border.all(color: Colors.white, width: 1)),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (controller.booking.value.salon?.logo !=
                                      '')
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: Colors.white, width: 1)),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: CachedNetworkImage(
                                          height: 120,
                                          width: 114,
                                          fit: BoxFit.cover,
                                          imageUrl:
                                              "${controller.booking.value.salon?.logo}",
                                          placeholder: (context, url) =>
                                              Image.asset(
                                            'assets/img/loading.gif',
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                            height: 66,
                                          ),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error_outline),
                                        ),
                                      ),
                                    )
                                  else
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: Colors.white, width: 1)),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(22),
                                        child: Container(
                                          alignment: Alignment.center,
                                          width: 120,
                                          height: 114,
                                          decoration: BoxDecoration(
                                              color: Get.theme.focusColor),
                                          child: Text(
                                            "${controller.booking.value.salon?.name![0]}",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 36),
                                          ),
                                        ),
                                      ),
                                    ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Opacity(
                                      opacity: controller.booking.value.cancel!
                                          ? 0.3
                                          : 1,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                              "${controller.booking.value.salon?.name}",
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600),
                                              maxLines: 3),
                                          Container(
                                              margin: const EdgeInsets.only(
                                                  top: 10),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons
                                                        .calendar_month_outlined,
                                                    color: CoreColor.primary,
                                                    size: 20,
                                                  ),
                                                  const SizedBox(width: 5),
                                                  Flexible(
                                                    child: Text(
                                                      "${DateFormat("yyy/MM/dd").format(controller.booking.value.bookingAt!)} | ${DateFormat("HH:mm").format(controller.booking.value.bookingAt!)}",
                                                      style: TextStyle(
                                                          color:
                                                              CoreColor.primary,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  )
                                                ],
                                              )),
                                          Container(
                                            margin: EdgeInsets.only(top: 10),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                SvgPicture.asset(
                                                  'assets/img_new/ic_star.svg',
                                                  color: Colors.amber,
                                                  width: 15,
                                                  height: 15,
                                                ),
                                                const SizedBox(width: 5),
                                                Text(
                                                  'Биечлэн | ирнэ',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Get
                                                          .theme.disabledColor),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            margin:
                                                const EdgeInsets.only(top: 10),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 6),
                                            decoration: BoxDecoration(
                                                color: Get.theme.focusColor,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: Text(
                                              "${controller.booking.value.status != null ? controller.booking.value.status?.status : ""}",
                                              style: Get.textTheme.bodyLarge
                                                  ?.merge(
                                                TextStyle(
                                                  color: CoreColor.white,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 10,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  // BookingOptionsPopupMenuWidget(booking: _booking),
                                ],
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 7, vertical: 25),
                                height: 0.5,
                                decoration:
                                    BoxDecoration(color: CoreColor.formGrey),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Ажилтан',
                                        style: Get.textTheme.bodyMedium),
                                    Text('Х.Мандахбаяр',
                                        style: Get.textTheme.bodyMedium),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Байршил',
                                        style: Get.textTheme.bodyMedium),
                                    Text('201, Parkside district, Ulaanbaatar',
                                        style: Get.textTheme.bodyMedium),
                                  ],
                                ),
                              )
                            ],
                          )),
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                          top: 20, left: 20, bottom: 20, right: 10),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      decoration: Ui.getBoxDecoration(
                          radius: 32,
                          color: Colors.white,
                          border: Border.all(color: Colors.white, width: 1)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Холбоо барих".tr,
                                  style: Get.textTheme.headlineSmall,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                    'Бизнес эрхлэгчийн холбоо барих холбоосууд',
                                    style: Get.textTheme.bodySmall)
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  width: 56,
                                  height: 56,
                                  decoration: BoxDecoration(
                                      color: CoreColor.primary,
                                      borderRadius: BorderRadius.circular(50)),
                                  child: Center(
                                    child: SizedBox(
                                        height: 24,
                                        width: 24,
                                        child: Image.asset(
                                            'assets/img/Phone.png')),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  width: 56,
                                  height: 56,
                                  decoration: BoxDecoration(
                                      color: CoreColor.primary,
                                      borderRadius: BorderRadius.circular(50)),
                                  child: Center(
                                    child: SizedBox(
                                        height: 24,
                                        width: 24,
                                        child: Image.asset(
                                            'assets/img/ic_secured_letter.png')),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                        padding: const EdgeInsets.only(
                            top: 20, left: 20, bottom: 20, right: 10),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        decoration: Ui.getBoxDecoration(
                            radius: 32,
                            color: Colors.white,
                            border: Border.all(color: Colors.white, width: 1)),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Захиалгын дэлгэрэнгүй".tr,
                                  style: Get.textTheme.headlineSmall,
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Бизнес эрхлэгч".tr,
                                  style: Get.textTheme.headlineSmall,
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    controller.booking.value.salon?.name ?? "",
                                    textAlign: TextAlign.end,
                                    style: Get.textTheme.headlineSmall,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Захиалсан огноо".tr,
                                  style: Get.textTheme.headlineSmall,
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    "${DateFormat("MMMEd", "mn").format(controller.booking.value.bookingAt!)} | ${DateFormat("Hm").format(controller.booking.value.bookingAt!)}",
                                    textAlign: TextAlign.end,
                                    style: Get.textTheme.headlineSmall,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Захиалгын дугаар".tr,
                                  style: Get.textTheme.headlineSmall,
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    "#${controller.booking.value.id.toString()}",
                                    textAlign: TextAlign.end,
                                    style: Get.textTheme.headlineSmall,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Төлөв".tr,
                                  style: Get.textTheme.headlineSmall,
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    controller.booking.value.status?.status ??
                                        "",
                                    textAlign: TextAlign.end,
                                    style: Get.textTheme.headlineSmall,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Нийт".tr,
                                  style: Get.textTheme.headlineSmall,
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    Ui.currencyFormat(
                                        controller.booking.value.getTotal()),
                                    textAlign: TextAlign.end,
                                    style: Get.textTheme.headlineSmall,
                                  ),
                                )
                              ],
                            ),
                          ],
                        )),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
