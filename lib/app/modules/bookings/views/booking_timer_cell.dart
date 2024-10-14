import 'package:flutter/material.dart';

class BookingTimerCell extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function clicked;

  const BookingTimerCell(
      {Key? key,
      required this.icon,
      required this.title,
      required this.clicked})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => clicked,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Icon(
                icon,
                size: 15,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              title,
              style: TextStyle(color: Colors.white, fontSize: 10),
            )
          ],
        ),
      ),
    );
  }
}
