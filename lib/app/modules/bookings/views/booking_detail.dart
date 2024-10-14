import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../common/ui.dart';
import '../../../models/booking_model.dart';
import '../controllers/booking_controller.dart';

class BookingDetail extends StatelessWidget {
  final Booking booking;

  const BookingDetail({Key? key, required this.booking}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration:
          Ui.bookingDetailContainer(color: Colors.white.withOpacity(0.2)),
      margin: EdgeInsets.only(top: 20, left: 20, right: 20),
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Contact".tr,
                  style: Get.textTheme.bodyMedium!
                      .merge(TextStyle(color: Colors.white)),
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        launchUrlString(
                            "mailto:info@savetime.mn?subject=${booking.salon?.email}");
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 10),
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(50)),
                        child: Center(
                          child: SizedBox(
                              height: 24,
                              width: 24,
                              child: Image.asset(
                                  'assets/img/ic_secured_letter.png')),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        var controller = Get.put(BookingController());
                        controller.startChat();
                      },
                      child: Container(
                        width: 36,
                        height: 36,
                        margin: const EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(50)),
                        child: Center(
                          child: SizedBox(
                              height: 24,
                              width: 24,
                              child:
                                  Image.asset('assets/img/ic_messenger.png')),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        launchUrlString(
                            "tel:${booking.salon?.phoneNumber ?? ''}");
                      },
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(50)),
                        child: Center(
                          child: SizedBox(
                              height: 24,
                              width: 24,
                              child: Image.asset('assets/img/Phone.png')),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Text("Ажилтан",
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 12,
                fontWeight: FontWeight.w100,
              )),
          SizedBox(
            height: 5,
          ),
          Text(
            "${booking.employee != null ? booking.employee?.name : "-"}",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
