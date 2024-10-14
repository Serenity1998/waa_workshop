import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import '../../../routes/app_routes.dart';
import '../../global_widgets/circular_button_widget.dart';
import '../controllers/portfolio_controller.dart';
import '../widget/career_widget.dart';
import '../widget/language_widget.dart';

class CareerLanguageView extends GetView<PortfolioController> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Мэргэжил, Гадаад хэл"),
          bottom: TabBar(
            tabs: controller.career_language_tabs,
            indicatorWeight: 2,
            labelPadding: const EdgeInsets.symmetric(horizontal: 10),
            unselectedLabelColor: Get.theme.disabledColor,
            labelStyle: Get.textTheme.bodyMedium?.merge(TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Get.theme.focusColor)),
            labelColor: Get.theme.focusColor,
            indicator: MaterialIndicator(
              height: 4,
              topLeftRadius: 8,
              topRightRadius: 8,
              color: Get.theme.focusColor,
              horizontalPadding: 8,
              tabPosition: TabPosition.bottom,
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            PortfolioCareerWidget(),
            PortfolioLanguageWidget(),
          ],
        ),
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
                  Get.toNamed(Routes.PORTFOLIO_WORK_HISTORY);
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
      ),
    );
  }
}
