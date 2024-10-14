import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingTicketItem extends StatelessWidget {
  final String? label;
  final String? value;
  final CrossAxisAlignment alignment;

  BookingTicketItem(
      {Key? key,
      this.label,
      this.value,
      this.alignment = CrossAxisAlignment.start})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      crossAxisAlignment: alignment,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null)
          Text(
            "${label}",
            style:
                Get.textTheme.bodyMedium?.merge(TextStyle(color: Colors.grey)),
          ),
        if (value != null)
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              "${value}",
              style: Get.textTheme.titleLarge!
                  .merge(TextStyle(color: Colors.black87)),
            ),
          )
      ],
    );
  }
}
