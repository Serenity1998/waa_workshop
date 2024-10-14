import 'package:flutter/material.dart';

import '../../../../common/ui.dart';
import '../../../models/booking_model.dart';
import '../../../models/e_service_model.dart';

class BookingDetailPrice extends StatelessWidget {
  final Booking booking;

  const BookingDetailPrice({Key? key, required this.booking}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: Ui.bookingDetailContainer(),
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(0),
              shrinkWrap: true,
              itemCount: booking.eServices!.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Захиалгын дэлгэрэнгүй",
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 12,
                            fontWeight: FontWeight.w100,
                          )),
                      Text("Үнэ",
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 12,
                            fontWeight: FontWeight.w100,
                          )),
                    ],
                  );
                }

                EService service = booking.eServices![index - 1];
                return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${service.name}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          )),
                      Text("${service.price}₮",
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 12,
                            fontWeight: FontWeight.w100,
                          ))
                    ]);
              }),
          SizedBox(
            height: 15,
          ),
          Text("Нийт үнэ",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              )),
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            Text("${booking.payment?.amount}₮",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ))
          ])
        ],
      ),
    );
  }
}
