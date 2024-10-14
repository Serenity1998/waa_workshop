/*
 * File name: bookings_list_item_widget.dart
 * Last modified: 2022.02.26 at 14:50:11
 * Author: SmarterVision - https://codecanyon.net/user/smartervision
 * Copyright (c) 2022
 */

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:save_time_customer/helpers/color.dart';
import '../../../../common/ui.dart';
import '../../../models/booking_model.dart';
import '../../../routes/app_routes.dart';

class BookingsListItemWidget extends StatelessWidget {
  BookingsListItemWidget({Key? key, required Booking booking})
      : _booking = booking,
        super(key: key);
  final Booking _booking;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_booking.atSalon!) {
          Get.toNamed(Routes.BOOKING_AT_SALON, arguments: _booking);
        } else {
          Get.toNamed(Routes.BOOKING, arguments: _booking);
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Container(
          padding:
              const EdgeInsets.only(top: 20, left: 20, bottom: 20, right: 10),
          margin: const EdgeInsets.only(left: 5),
          decoration: Ui.getBoxDecoration(
              radius: 32,
              color: Colors.white,
              border: Border.all(color: Colors.white, width: 1)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_booking.salon?.logo != '')
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.white, width: 1)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      height: 120,
                      width: 114,
                      fit: BoxFit.cover,
                      imageUrl: "${_booking.salon?.logo}",
                      placeholder: (context, url) => Image.asset(
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
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.white, width: 1)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      alignment: Alignment.center,
                      width: 120,
                      height: 114,
                      decoration: BoxDecoration(color: Get.theme.focusColor),
                      child: Text(
                        "${_booking.salon?.name![0]}",
                        style: TextStyle(color: Colors.white, fontSize: 36),
                      ),
                    ),
                  ),
                ),
              const SizedBox(width: 12),
              Expanded(
                child: Opacity(
                  opacity: _booking.cancel! ? 0.3 : 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                            color: Get.theme.focusColor,
                            borderRadius: BorderRadius.circular(5)),
                        child: Text(
                          "${_booking.status != null ? _booking.status?.status : ""}",
                          style: Get.textTheme.bodyLarge?.merge(
                            TextStyle(
                              color: CoreColor.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ),
                      Text("${_booking.salon?.name}",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                          maxLines: 3),
                      Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.calendar_month_outlined,
                                color: CoreColor.primary,
                                size: 20,
                              ),
                              const SizedBox(width: 5),
                              Flexible(
                                child: Text(
                                  "${DateFormat("yyy/MM/dd").format(_booking.bookingAt!)} | ${DateFormat("HH:mm").format(_booking.bookingAt!)}",
                                  style: TextStyle(
                                      color: CoreColor.primary,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                              )
                            ],
                          )),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
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
                                  fontSize: 14, color: Get.theme.disabledColor),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // BookingOptionsPopupMenuWidget(booking: _booking),
            ],
          ),
        ),
      ),
    );
  }
}
