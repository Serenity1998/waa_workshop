/*
 * Copyright (c) 2020 .
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountLinkWidget extends StatelessWidget {
  final Widget icon;
  final Widget text;
  final ValueChanged<void> onTap;

  const AccountLinkWidget({
    Key? key,
    required this.icon,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap('');
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Row(
          children: [
            icon,
            Container(
              margin: EdgeInsets.symmetric(horizontal: 12),
              width: 0,
              height: 24,
              color: Get.theme.focusColor.withOpacity(0.3),
            ),
            Expanded(
              child: text,
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 12,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
