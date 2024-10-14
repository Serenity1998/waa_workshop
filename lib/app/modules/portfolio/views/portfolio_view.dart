import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import '../controllers/portfolio_controller.dart';
import '../widget/my_portfolio_widget.dart';

class PortfolioView extends GetView<PortfolioController> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Миний CV/Portfolio"),
      ),
      body: Column(
        children: [
          DefaultTabController(
            length: 2,
            child: TabBar(
              tabs: controller.tabs,
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
          MyPortfolioWidget(),
        ],
      ),
    );
  }
}
