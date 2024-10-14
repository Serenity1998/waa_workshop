import 'package:flutter/material.dart';

class BookingTimeWidget extends StatelessWidget {
  final String? name;
  final Function clicked;
  final bool? checked;

  const BookingTimeWidget(
      {Key? key, this.name, required this.clicked, this.checked})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () {
        clicked();
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Row(
          children: [
            Icon(checked!
                ? Icons.radio_button_checked
                : Icons.radio_button_unchecked),
            SizedBox(
              width: 10,
            ),
            Text('${name}')
          ],
        ),
      ),
    );
  }
}
