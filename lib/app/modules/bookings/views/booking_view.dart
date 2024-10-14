/*
 * File name: booking_view.dart
 * Last modified: 2022.05.19 at 12:10:11
 * Author: SmarterVision - https://codecanyon.net/user/smartervision
 * Copyright (c) 2022
 */

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../common/helper.dart';
import '../../../../common/ui.dart';
import '../../../models/booking_model.dart';
import '../../../routes/app_routes.dart';
import '../../auth/controllers/auth_controller.dart';
import '../../global_widgets/block_button_widget.dart';
import '../../global_widgets/main_appbar.dart';
import '../controllers/booking_controller.dart';
import '../controllers/bookings_controller.dart';
import '../widgets/booking_actions_widget.dart';
import '../widgets/booking_info.dart';

class BookingView extends GetView<BookingController> {
  @override
  Widget build(BuildContext context) {
    Booking booking = controller.booking.value;
    return Scaffold(
      floatingActionButton: GestureDetector(
        onTap: () {
          Get.toNamed(Routes.BOOKING_TICKET);
        },
        child: Container(
            height: 56,
            width: 56,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                BoxShadow(
                  color: Colors.black45,
                  blurRadius: 8.0,
                ),
              ],
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color(0xff7210FF),
                  Color(0xff9D59FF),
                ],
              ),
            ),
            child: Image.asset(
              'assets/img_new/ic_ticket.png',
              width: 20,
              height: 20,
            )),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartFloat,
      appBar: MainAppBar(title: "${booking.salon?.name}"),
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 25),
            children: [
              BookingInfo(),
              const SizedBox(height: 20),
              Container(
                height: 78,
                padding: EdgeInsets.symmetric(horizontal: 24),
                decoration: Ui.getBoxDecoration(radius: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 13),
                        Text('Холбоо барих',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            )),
                        const SizedBox(height: 5),
                        Text(
                          'Бизнес эрхлэгчдийн \nхолбоо барих холбоосууд',
                          style: TextStyle(
                              fontWeight: FontWeight.w100,
                              color: Colors.black54),
                        ),
                      ],
                    ),
                    const SizedBox(width: 12),
                    GestureDetector(
                      onTap: () {
                        launchUrlString(
                            "tel:${controller.booking.value.salon?.phoneNumber ?? ''}");
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        child: Center(
                          child: SvgPicture.asset(
                            "assets/img_new/ic_call_action.svg",
                            width: 20,
                            height: 20,
                          ),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(56),
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Color(0xff7210FF),
                              Color(0xff9D59FF),
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: controller.startChat,
                      child: Container(
                        height: 50,
                        width: 50,
                        child: Center(
                          child: SvgPicture.asset(
                            "assets/img_new/ic_message_active.svg",
                            width: 25,
                            height: 25,
                            color: Colors.white,
                          ),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(56),
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Color(0xff7210FF),
                              Color(0xff9D59FF),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              expandableNofifier(
                "Тэмдэглэл",
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 22),
                  decoration: Ui.getBoxDecoration(radius: 20, boxShadow: []),
                  child: Column(
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Тэмдэглэл",
                              style: TextStyle(color: Get.theme.focusColor),
                            ),
                            const SizedBox(height: 10),
                            Icon(Icons.keyboard_arrow_down),
                          ]),
                      controller.booking.value.hint != ''
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                  Text(
                                    "${controller.booking.value.hint}",
                                    style: TextStyle(color: Color(0xff616161)),
                                  ),
                                ])
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                  Text(
                                    'Тэмдэглэл хоосон байна',
                                    style: TextStyle(color: Colors.black45),
                                  ),
                                ])
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              expandableNofifier(
                "Захиалгын дэлгэрэнгүй",
                Column(children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 22),
                    child: Column(
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Захиалгын дэлгэрэнгүй",
                                style: TextStyle(color: Get.theme.focusColor),
                              ),
                              const SizedBox(height: 10),
                              Icon(Icons.keyboard_arrow_down),
                            ]),
                        Column(
                          children: [
                            component("Бизнес эрхлэгч",
                                "${booking.salon?.name}", null),
                            component(
                              "Захиалсан огноо",
                              DateFormat(' MMM d, ' 'yyyy ' '| H:m',
                                      Get.locale.toString())
                                  .format(
                                controller.booking.value.createdAt!,
                              ),
                              null,
                            ),
                            component("Захиалгын дугаар", "#" + "${booking.id}",
                                null),
                            component(
                                "Төлбөрийн төлөв",
                                controller.booking.value.payment?.paymentStatus
                                        ?.status ??
                                    '',
                                Colors.red),
                            component(
                                "Төлбөрийн нөхцөл",
                                controller.booking.value.payment?.paymentMethod
                                        ?.getName() ??
                                    '',
                                null),
                          ],
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
              const SizedBox(height: 24),
              expandableNofifier(
                "Таны захиалгууд",
                Column(children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 22),
                    decoration: Ui.getBoxDecoration(radius: 20, boxShadow: []),
                    child: Column(
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Таны захиалгууд",
                                style: TextStyle(color: Get.theme.focusColor),
                              ),
                              const SizedBox(height: 10),
                              Icon(Icons.keyboard_arrow_down),
                            ]),
                        Column(
                          children: [
                            component("${booking.eServices?.first.name}",
                                Ui.currencyFormat(booking.getTotal()), null),
                            component(
                                "Хямдрал",
                                Ui.currencyFormat(booking.coupon!.discount!),
                                Get.theme.focusColor,
                                titleColor: Get.theme.focusColor),
                            Divider(
                              height: 26,
                              thickness: 1.2,
                            ),
                            component("Нийт",
                                Ui.currencyFormat(booking.getTotal()), null),
                          ],
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BookingActionsWidget(),
    );
  }

  Widget expandableNofifier(String title, Widget expanded) {
    return ExpandableNotifier(
      child: ExpandableButton(
        child: Container(
          decoration: Ui.getBoxDecoration(radius: 20),
          child: Column(
            children: [
              Expandable(
                theme: ExpandableThemeData(useInkWell: false),
                collapsed: Container(
                  height: 68,
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          title,
                          style: TextStyle(color: Color(0xff616161)),
                        ),
                        Icon(Icons.keyboard_arrow_right)
                      ]),
                ),
                expanded: expanded,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget component(
    String title,
    String desc,
    Color? mcolor, {
    Color? titleColor,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 22),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
                color: titleColor != null ? titleColor : Color(0xff616161)),
          ),
          Text(
            desc,
            style: TextStyle(
              color: mcolor != null ? mcolor : Color(0xff616161),
              fontFamily: 'Arial',
            ),
          )
        ],
      ),
    );
  }

  Widget buildBlockButtonWidget(BuildContext context) {
    return Container(
      height: 118,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 24),
      decoration: BoxDecoration(
        color: Get.theme.primaryColor,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40), topRight: Radius.circular(40)),
        boxShadow: [
          BoxShadow(
              color: Get.theme.focusColor.withOpacity(0.1),
              blurRadius: 6,
              offset: Offset(0, -2)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 58,
            width: Get.width / 2 - 30,
            child: BlockButtonWidget(
                text: "Цуцлах".tr,
                color: lightPurpleColor,
                onPressed: () {
                  Get.bottomSheet(Container(
                    height: 355,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40),
                        topLeft: Radius.circular(40),
                      ),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              'Захиалга цуцлах',
                              style: Get.textTheme.headlineMedium?.merge(
                                TextStyle(
                                  color: Color(0xffF75555),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Divider(),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              'Та үйлчилгээний захиалгаа цуцлахдаа итгэлтэй байна уу?',
                              style: Get.textTheme.titleSmall!.merge(
                                TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Манай бодлогын дагуу таны төлбөрийн зөвхөн 97%-ийг буцаан авах боломжтой!',
                            style: Get.textTheme.bodyLarge!.merge(
                              TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                          Divider(),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: 58,
                                width: Get.width / 2 - 60,
                                child: BlockButtonWidget(
                                    text: "Буцах".tr,
                                    color: lightPurpleColor,
                                    onPressed: () {
                                      Get.back();
                                    }),
                              ),
                              const SizedBox(width: 10),
                              SizedBox(
                                width: Get.width / 2.2,
                                height: 58,
                                child: BlockButtonWidget(
                                    text: "Захиалгаа цуцлах".tr,
                                    onPressed: () {
                                      Get.back();
                                      controller.cancelBookingService().then((value) =>
                                          Helper.basicAlert(
                                              context,
                                              "Захиалгыг цуцаллаа!",
                                              'Та үйлчилгээний захиалга амжилттай цуцлагдлаа. 97% нь таны дансанд буцаж орно.',
                                              img: "assets/img_new/success.png",
                                              onPressed: () {
                                            Get.back();
                                            Get.find<BookingsController>()
                                                .refreshBookings(statusId: 5);
                                            Get.back();
                                          }));
                                    }),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ));
                }),
          ),
          SizedBox(
            width: Get.width / 2 - 30,
            height: 58,
            child: BlockButtonWidget(text: "Төлбөр төлөх".tr, onPressed: () {}),
          )
        ],
      ),
    );
  }
}
