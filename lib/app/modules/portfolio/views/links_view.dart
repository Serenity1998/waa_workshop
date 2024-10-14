import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../global_widgets/circular_button_widget.dart';
import '../../global_widgets/text_field_widget.dart';
import '../controllers/portfolio_controller.dart';

class LinksView extends GetView<PortfolioController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Холбоосууд"),
      ),
      body: ListView(
        children: [
          TextFieldWidget(
            labelText: "Facebook".tr,
          ),
          TextFieldWidget(
            labelText: "Instagram".tr,
          ),
          TextFieldWidget(
            labelText: "Twitter".tr,
          ),
          TextFieldWidget(
            labelText: "Github".tr,
          ),
          TextFieldWidget(
            labelText: "Artstation".tr,
          ),
          TextFieldWidget(
            labelText: "Behance.net".tr,
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          color: Get.theme.primaryColor,
        ),
        child: Row(
          children: [
            CircularButtonWidget(
              icon: Icon(
                Icons.arrow_back,
                color: Color(0xff7210FF),
              ),
              color: Color(0xffF1E7FF),
              onPressed: () {
                Get.back();
              },
            ),
            SizedBox(
              width: 12,
            ),
            MaterialButton(
              minWidth: Get.width / 1.4,
              onPressed: () {
                // register
                // controller.saveIntroductionForm();
              },
              height: 58,
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100)),
              color: Get.theme.colorScheme.secondary,
              child: Text(
                "Хадгалах".tr,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              elevation: 0,
              highlightElevation: 0,
              hoverElevation: 0,
              focusElevation: 0,
            ),
          ],
        ),
      ),
    );
  }
}
