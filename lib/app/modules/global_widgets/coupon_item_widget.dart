import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/ui.dart';

class CouponItemWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: Ui.getBoxDecorationLessShadow(),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          SizedBox(
              height: 83,
              width: 83,
              child: Image.asset("assets/img_new/coupon.png")),
          SizedBox(
            width: 15,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Онцгой 25% хямдрал!"),
                Text(
                  'Зөвхөн өнөөдрийнн онцгой хямдрал! "Tiffany med"',
                  style: Get.textTheme.bodySmall,
                )
              ],
            ),
          ),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.radio_button_off_rounded,
                color: Get.theme.focusColor,
              ))
        ],
      ),
    );
  }
}
