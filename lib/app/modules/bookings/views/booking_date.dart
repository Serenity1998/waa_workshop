import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/ui.dart';
import '../../../models/booking_model.dart';
import 'package:intl/intl.dart';

class BookingDetailDate extends StatelessWidget {
  final Booking booking;
  final bool finished;

  const BookingDetailDate(
      {Key? key, required this.booking, this.finished = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Container(
      padding: EdgeInsets.all(10),
      decoration: finished ? Ui.bookingDetailContainer() : BoxDecoration(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          finished
              ? Container()
              : Container(
                  padding: EdgeInsets.all(10),
                  decoration: Ui.bookingDetailContainer(
                      color: Colors.white.withOpacity(0.3)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                          DateFormat('HH:mm', Get.locale.toString())
                              .format(booking.bookingAt!),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w100,
                          )),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Text("${booking.bookingAt?.day}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w100,
                            )),
                      ),
                      Text("${booking.bookingAt?.month}-р сар",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w100,
                          )),
                    ],
                  ),
                ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                finished
                    ? Container(
                        width: Get.width - 80,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            finished
                                ? Text("Хаяг ",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w100,
                                    ))
                                : Container(),
                            Container(
                              decoration: Ui.bookingDetailContainer(),
                              padding: EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 10),
                              child: Text(
                                finished
                                    ? "Очиж үйлчлүүүлсэн"
                                    : "Очиж үйлчлүүлнэ",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(
                        decoration: Ui.bookingDetailContainer(),
                        padding:
                            EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                        child: Text(
                          finished ? "Очиж үйлчлүүүлсэн" : "Очиж үйлчлүүлнэ",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    "${booking.address?.address}",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
