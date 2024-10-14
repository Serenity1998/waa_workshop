import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../common/empty_view.dart';
import '../../../providers/laravel_provider.dart';
import '../../../routes/app_routes.dart';
import '../../account/widgets/account_link_widget.dart';
import '../controllers/portfolio_controller.dart';

class MyPortfolioWidget extends GetView<PortfolioController> {
  MyPortfolioWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (Get.find<LaravelApiClient>().isLoading(task: 'getPortgolio')) {
        return Text("Loading");
      } else if (controller.portfolio.isEmpty) {
        return SingleChildScrollView(
          child: EmptyView(
            buttonTap: () => Get.toNamed(Routes.PORTFOLIO_INTRODUCTION),
            buttonText: "CV/Portfolio үүсгэх",
            message:
                "Та өөрийнхөө cv/portfolio -г үүсгэн шинэ карьераа эхлүүлээрэй!",
          ),
        );
      } else {
        return Expanded(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              child: Column(
                children: [
                  AccountLinkWidget(
                    icon: SvgPicture.asset(
                      "assets/img_new/ic_work.svg",
                      color: Colors.black,
                    ),
                    text: Text("Товч танилцуулга".tr),
                    onTap: (e) {
                      Get.toNamed(Routes.PROFILE);
                    },
                  ),
                  AccountLinkWidget(
                    icon: SvgPicture.asset(
                      "assets/img_new/ic_note.svg",
                      color: Colors.black,
                    ),
                    text: Text("Боловсрол".tr),
                    onTap: (e) {
                      Get.toNamed(Routes.PROFILE);
                    },
                  ),
                  AccountLinkWidget(
                    icon: SvgPicture.asset(
                      "assets/img_new/ic_time.svg",
                      color: Colors.black,
                    ),
                    text: Text("Мэргэжил / Гадаад хэл".tr),
                    onTap: (e) {
                      Get.toNamed(Routes.PROFILE);
                    },
                  ),
                  AccountLinkWidget(
                    icon: SvgPicture.asset(
                      "assets/img_new/ic_discount.svg",
                      color: Colors.black,
                    ),
                    text: Text("Ажилласан туршлага".tr),
                    onTap: (e) {
                      Get.toNamed(Routes.PROFILE);
                    },
                  ),
                  AccountLinkWidget(
                    icon: SvgPicture.asset(
                      "assets/img_new/ic_heart_outlined.svg",
                      color: Colors.black,
                    ),
                    text: Text("Ур чадвар".tr),
                    onTap: (e) {
                      Get.toNamed(Routes.PROFILE);
                    },
                  ),
                  AccountLinkWidget(
                    icon: SvgPicture.asset(
                      "assets/img_new/ic_send.svg",
                      color: Colors.black,
                    ),
                    text: Text("Холбоосууд".tr),
                    onTap: (e) {
                      Get.toNamed(Routes.PROFILE);
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      }
    });
  }
}
