import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../global_widgets/main_appbar.dart';
import '../controllers/invoice_controller.dart';

class InvoiceView extends GetView<InvoiceController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: "Нэхэмжлэх".tr,
        actions: [
          Image.asset(
            "assets/img_new/ic_location.png",
            width: 24,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 27, left: 20),
            child: Image.asset(
              "assets/img_new/ic_scan.png",
              width: 22,
            ),
          )
        ],
      ),
      body: ListView.builder(
          itemCount: controller.images.length,
          itemBuilder: ((context, index) {
            return Container(
              height: 80,
              padding: EdgeInsets.symmetric(horizontal: 24),
              margin: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        "assets/img_new/${controller.images[index]}.png",
                        width: 32,
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Text(controller.name[index])
                    ],
                  ),
                  Text(
                    'Төлсөн',
                    style: TextStyle(color: Get.theme.focusColor),
                  )
                ],
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Get.theme.highlightColor,
              ),
            );
          })),
    );
  }
}
