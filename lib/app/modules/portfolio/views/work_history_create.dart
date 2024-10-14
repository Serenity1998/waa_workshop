import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../global_widgets/dropdown_widget.dart';
import '../../global_widgets/text_field_widget.dart';
import '../controllers/portfolio_controller.dart';

class WorkHistoryCreateView extends GetView<PortfolioController> {
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
            TextFieldWidget(
              validator: (input) =>
                  input!.length < 3 ? "Should be more than 3 letters".tr : null,
              initialValue: '',
              hintText: "Ажилласан компани".tr,
              labelText: "Ажилласан компани".tr,
            ),
            TextFieldWidget(
              validator: (input) =>
                  input!.length < 3 ? "Should be more than 3 letters".tr : null,
              initialValue: '',
              hintText: "Албан тушаал".tr,
              labelText: "Албан тушаал".tr,
            ),
            TextFieldWidget(
              validator: (input) =>
                  input!.length < 3 ? "Should be more than 3 letters".tr : null,
              initialValue: '',
              hintText: "Тухайн компаниас ойлгож авсан туршлага, мэдлэг".tr,
              labelText: "Тухайн компаниас ойлгож авсан туршлага, мэдлэг".tr,
            ),
            Container(
              height: 24,
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Одоо ажиллаж байгаа"),
                  Transform.scale(
                    scale: 0.8,
                    child: CupertinoSwitch(
                      value: true,
                      onChanged: (value) {},
                      activeColor: Color(0xff7210FF),
                    ),
                  )
                ],
              ),
            ),
            DropdownWidget(
              items: [],
              hint: "Ажилд орсон огноо",
              suffixIcon: Image.asset(
                "assets/img_new/ic_dropdown.png",
                width: 25,
                color: Colors.grey.shade600,
              ),
            ),
            DropdownWidget(
              items: [],
              hint: "Ажлаас гарсан огноо",
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
