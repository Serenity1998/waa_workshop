import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../global_widgets/circular_button_widget.dart';
import '../controllers/portfolio_controller.dart';
import '../widget/portfolio_item_widget.dart';

class EducationView extends GetView<PortfolioController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Боловсрол")),
      body: ListView(
        children: [
          PortolioItemWidget(
            title: "Бүрэн дунд боловсрол",
            primary: "12 жил",
          ),
          PortolioItemWidget(
            title: "Программист",
            primary: "Бакалавр",
          )
        ],
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          controller.getPortfolioEducation();
          // Get.toNamed(Routes.PORTFOLIO_EDUCATION_CREATE);
        },
        child: Container(
          height: 56,
          width: 56,
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Color(0xff7210FF),
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.black45,
            //     blurRadius: 8.0,
            //   ),
            // ],
            // gradient: LinearGradient(
            //   begin: Alignment.centerLeft,
            //   end: Alignment.centerRight,
            //   colors: [
            //     Color(0xff7210FF),
            //     Color(0xff9D59FF),
            //   ],
            // ),
          ),
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          color: Get.theme.primaryColor,
          // borderRadius: BorderRadius.all(Radius.circular(20)),
          // boxShadow: [
          //   BoxShadow(
          //     color: Get.theme.focusColor.withOpacity(0.1),
          //     blurRadius: 10,
          //     offset: Offset(0, -5),
          //   ),
          // ],
        ),
        child: Row(
          children: [
            // BlockButtonWidget(
            //   text: Icon(
            //     Icons.arrow_back,
            //     color: Color(0xff7210FF),
            //   ),
            //   color: Color(0xffF1E7FF),
            //   onPressed: () {
            //     Get.back();
            //   },
            // ),
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
                // controller.saveIntroductionForm();
                Get.toNamed(Routes.PORTFOLIO_CAREER_LANGUAGE);
              },
              height: 58,
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100)),
              color: Get.theme.colorScheme.secondary,
              child: Text(
                "Үргэлжлүүлэх".tr,
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
