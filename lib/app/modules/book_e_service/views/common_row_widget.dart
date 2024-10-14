import 'package:flutter/material.dart';
import 'package:get/get.dart';

const nameGrayColor = Color(0xFF616161);

class CommonRowWidget extends StatelessWidget {
  final String? name;
  final String? value;
  final Color? nameColor;

  const CommonRowWidget(
      {Key? key, this.name, this.value, this.nameColor = nameGrayColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              "${name}",
              textAlign: TextAlign.start,
              style: Get.textTheme.bodyLarge!
                  .copyWith(color: nameColor, fontSize: 14),
            ),
          ),
          Text(
            '${value}',
            textAlign: TextAlign.end,
            style: Get.textTheme.bodyLarge!.copyWith(
              color: nameColor,
              fontSize: 16,
              fontWeight: FontWeight.w400,
              fontFamily: 'Arial',
            ),
          )
        ],
      ),
    );
  }
}
