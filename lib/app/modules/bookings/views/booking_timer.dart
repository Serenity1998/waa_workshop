import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

import '../../../models/booking_model.dart';

class BookingTimer extends StatefulWidget {
  final Booking booking;
  final Function cancel;

  const BookingTimer({Key? key, required this.booking, required this.cancel})
      : super(key: key);

  @override
  State<BookingTimer> createState() => _BookingTimerState();
}

class _BookingTimerState extends State<BookingTimer> {
  int endTime = 100;
  int decreased = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      endTime = widget.booking.bookingAt!.millisecondsSinceEpoch;
    });
  }

  double getProgress() {
    if (DateTime.now().isAfter(widget.booking.bookingAt!)) {
      return 0;
    }

    DateTime created = widget.booking.createdAt!;
    DateTime bookingAt = widget.booking.bookingAt!;

    int start = created.difference(bookingAt).inSeconds;
    var now = DateTime.now().difference(bookingAt).inSeconds;

    var per = now / start;
    return per;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    // if (DateTime.now().isAfter(widget.booking.bookingAt)) {
    //   return Container();
    // }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 100,
          width: 100,
          child: Stack(
            children: [
              Center(
                child: Container(
                  height: 100,
                  width: 100,
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.white.withOpacity(0.3),
                    value: getProgress(),
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                    strokeWidth: 10,
                  ),
                ),
              ),
              Center(
                child: CountdownTimer(
                  endTime: endTime,
                  textStyle: TextStyle(color: Colors.white),
                  widgetBuilder: ((context, time) {
                    // print(time);
                    // setState(() {
                    //   decreased += 1;
                    // });

                    if (time == null) {
                      return Text(
                        "Хугацаа\nдууссан",
                        style: TextStyle(color: Colors.white),
                      );
                    }

                    getProgress();
                    return Text(
                      "${time.days != null && time.days! > 0 ? "${time.days} өдөр\n" : ""} ${time.hours ?? "00"}:${time.min ?? "00"}:${time.sec}",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    );
                  }),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 25,
        ),
        DateTime.now().isAfter(widget.booking.bookingAt!)
            ? Container()
            : Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    // GestureDetector(
                    //   onTap: () {
                    //     widget.cancel();
                    //   },
                    //   child: BookingTimerCell(
                    //     icon: Icons.clear
                    //     title: "Цуцлах",
                    //   ),
                    // ),
                    // SizedBox(
                    //   width: 20,
                    // ),
                    // BookingTimerCell(
                    //   icon: Icons.west,
                    //   title: "Хойшлуулах",
                    // ),
                    // BookingTimerCell(
                    //   icon: Icons.east,
                    //   title: "Урагшлуулах",
                    // )
                  ],
                ),
              )
      ],
    );
  }
}
