import 'package:flutter/material.dart';
import 'package:get/get.dart';

// import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../common/helper.dart';
import '../../../models/setting_model.dart';
import '../../../routes/app_routes.dart';
import '../../../services/settings_service.dart';
import '../../global_widgets/block_button_widget.dart';
import '../../global_widgets/circular_loading_widget.dart';
import '../../global_widgets/main_appbar.dart';
import '../controllers/auth_controller.dart';

class PhoneVerificationView extends GetView<AuthController> {
  final Setting _settings = Get.find<SettingsService>().setting.value;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: Helper().onWillPop,
      child: Scaffold(
        appBar: MainAppBar(
          title:
              (Get.arguments != null && Get.arguments['isResettingPassword'] ??
                          false) ==
                      true
                  ? 'Нууц үг сэргээх'
                  : "Phone Verification".tr,
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Obx(() {
            String text =
                "We sent the OTP code to your phone, please check it and enter below";
            if (Get.arguments != null) {
              if (Get.arguments['isResettingPassword'] == true) {
                if (Get.arguments['passResetIndex'] == 0) {
                  text =
                      'Таны ${controller.currentUser.value.phoneNumber} дугаар луу явуулсан кодыг оруулна уу';
                } else if (Get.arguments['passResetIndex'] == 1) {
                  text =
                      'Таны ${controller.currentUser.value.email} имэйл рүү явуулсан кодыг оруулна уу';
                }
              }
            }
            if (controller.loading.isTrue) {
              return CircularLoadingWidget(height: 300);
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(),
                  Text(
                    '$text'.tr,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff212121),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  const SizedBox(height: 20),
                  Obx(() {
                    return Text(
                      '${Get.put(AuthController()).remainingSeconds.value} секундын дараа код дахин илгээх боломжтой',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff212121),
                      ),
                      textAlign: TextAlign.center,
                    );
                  }),
                  const SizedBox(height: 20),
                  BlockButtonWidget(
                    onPressed: () async {
                      if (Get.arguments != null &&
                          (Get.arguments['isResettingPassword'] ?? false) ==
                              true)
                        Get.toNamed(Routes.NEW_PASSWORD);
                      else
                        await controller.verifyPhone();
                    },
                    text: "Verify".tr,
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () async {
                      if (Get.arguments &&
                          (Get.arguments['isResettingPassword'] ?? false) ==
                              true) {
                        controller.sendResetLink();
                      } else
                        controller.resendOTPCode();
                    },
                    child: Text(
                      "Код дахин илгээх".tr,
                      textAlign: TextAlign.center,
                      style: Get.textTheme.titleLarge!.merge(
                          TextStyle(color: Get.theme.colorScheme.secondary)),
                    ),
                  ),
                  Spacer(),
                ],
              );
            }
          }),
        ),
      ),
    );
  }
}
