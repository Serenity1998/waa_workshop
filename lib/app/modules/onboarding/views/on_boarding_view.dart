import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../../services/auth_service.dart';
import '../../global_widgets/block_button_widget.dart';
import '../controllers/onboarding_controller.dart';
import 'on_boarding_item.dart';

class OnboardingView extends GetView<OnboardingControlleer> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    controller.controller = PageController();
    return Scaffold(
      floatingActionButton: Container(
        width: Get.width - 45,
        margin: EdgeInsets.only(right: 10),
        child: Obx(() {
          return BlockButtonWidget(
            color: Get.theme.focusColor,
            text: controller.pageNumber.value == 2 ? "Эхэлцгээе!" : "Дараагийн",
            onPressed: () {
              if (controller.pageNumber.value < 2) {
                controller.pageNumber.value += 1;
                controller.controller?.animateToPage(
                    controller.pageNumber.value.toInt(),
                    duration: Duration(milliseconds: 2),
                    curve: Curves.easeInOut);
              } else {
                Get.find<AuthService>().setFirst();
                Get.offAllNamed(Routes.ROOT);
              }
            },
          );
        }),
      ),
      body: Stack(
        children: [
          PageView(
            controller: controller.controller,
            onPageChanged: (val) =>
                (controller.pageNumber.value = val.toDouble()),
            children: [
              OnboardingItem(
                info: "Бид танд мэргэжлийн\nүйлчилгээг санал\nболгож байна",
                image: "onboarding-1",
              ),
              OnboardingItem(
                info:
                    "Хамгийн сайн үр дүн,\nсэтгэл ханамж нь\nбидний зорилго юм",
                image: "onboarding-2",
              ),
              OnboardingItem(
                info: "Таны цагийг хэмнэх\nхамгийн оновчтой\nшийдэл",
                image: "onboarding-3",
              )
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(bottom: 130),
              child: Obx(() {
                return DotsIndicator(
                  dotsCount: 3,
                  position: controller.pageNumber.value.toInt(),
                  decorator: DotsDecorator(
                    size: const Size.square(9.0),
                    activeSize: const Size(32.0, 9.0),
                    activeColor: Get.theme.focusColor,
                    activeShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                );
              }),
            ),
          )
        ],
      ),
    );
  }
}
