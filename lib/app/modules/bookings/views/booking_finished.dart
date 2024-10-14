import 'package:flutter/material.dart';

import '../../../../common/ui.dart';
import '../../../models/booking_model.dart';
import 'package:intl/intl.dart';

class BookingFinished extends StatelessWidget {
  final Booking booking;

  const BookingFinished({Key? key, required this.booking}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: Ui.bookingDetailContainer(),
      padding: EdgeInsets.all(10),
      child: Column(children: [
        Row(
          children: [
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Эхэлсэн цаг",
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 12,
                      fontWeight: FontWeight.w100,
                    )),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    "${DateFormat("dd/M/yyyy HH:mm").format(booking.startAt!)}",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                Text("Дууссан цаг",
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 12,
                      fontWeight: FontWeight.w100,
                    )),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    "${DateFormat("dd/M/yyyy HH:mm").format(booking.endsAt!)}",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ],
            )),
            Container(
              padding: EdgeInsets.all(10),
              decoration: Ui.bookingDetailContainer(
                  color: Colors.white.withOpacity(0.3)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Нийт",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w100,
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Text("${booking.duration}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w100,
                        )),
                  ),
                  Text("минут",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w100,
                      )),
                ],
              ),
            ),
          ],
        )
      ]),
    );
  }
}
