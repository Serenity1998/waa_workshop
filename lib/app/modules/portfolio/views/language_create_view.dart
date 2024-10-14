import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../global_widgets/dropdown_widget.dart';
import '../controllers/portfolio_controller.dart';

class LanguageCreatView extends GetView<PortfolioController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Мэдээллээ оруулна уу"),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          color: Get.theme.primaryColor,
        ),
        child: MaterialButton(
          onPressed: () {
            Get.back();
            // Get.toNamed(Routes.PORTFOLIO_EDUCATION);
          },
          height: 58,
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          color: Get.theme.colorScheme.secondary,
          child: Text(
            "Нэмэх".tr,
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
      ),
      body: Form(
        child: ListView(
          primary: true,
          children: [
            DropdownWidget(
              items: [],
              hint: "Хэлний төрлүүдээс сонгоно уу",
              suffixIcon: Image.asset(
                "assets/img_new/ic_dropdown.png",
                width: 25,
                color: Colors.grey.shade600,
              ),
            ),
            DropdownWidget(
              items: [],
              hint: "Түвшингээ бичнэ үү!",
              suffixIcon: Image.asset(
                "assets/img_new/ic_dropdown.png",
                width: 25,
                color: Colors.grey.shade600,
              ),
            ),
            DropdownWidget(
              items: [],
              hint: "Ажилласан туршлага",
              suffixIcon: Image.asset(
                "assets/img_new/ic_dropdown.png",
                width: 25,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
