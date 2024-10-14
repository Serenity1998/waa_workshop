import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../global_widgets/coupon_item_widget.dart';

class MyCouponsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Таны хямдралууд"),
      ),
      floatingActionButton: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
        width: Get.width - 30,
        height: 50,
        child: ElevatedButton(
          onPressed: () {},
          child: Text("Урамшуулал ашиглах"),
        ),
      ),
      body: ListView.builder(
          itemCount: 5,
          itemBuilder: (ctx, index) {
            return CouponItemWidget();
          }),
    );
  }
}
