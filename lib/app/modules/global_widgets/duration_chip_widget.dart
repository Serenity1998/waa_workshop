/*
 * File name: duration_chip_widget.dart
 * Last modified: 2022.02.14 at 10:57:37
 * Author: SmarterVision - https://codecanyon.net/user/smartervision
 * Copyright (c) 2022
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DurationChipWidget extends StatelessWidget {
  const DurationChipWidget({
    Key? key,
    required String duration,
  })  : _duration = duration,
        super(key: key);

  final String _duration;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 20,
          // padding: EdgeInsets.symmetric(horizontal: 10),
          // decoration: BoxDecoration(
          //   color: Get.theme.colorScheme.secondary.withOpacity(0.05),
          //   borderRadius: BorderRadius.all(Radius.circular(32)),
          // ),
          child: Row(
            children: [
              Icon(
                Icons.schedule,
                size: 12,
                color: Get.theme.hintColor,
              ),
              SizedBox(width: 5),
              Text(
                _duration,
                maxLines: 1,
                style: TextStyle(
                    fontSize: 10.0,
                    fontWeight: FontWeight.w400,
                    color: Get.theme.hintColor,
                    height: 1.2),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
