import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../common/ui.dart';
import '../../../routes/app_routes.dart';
import '../../global_widgets/block_button_widget.dart';
import '../../global_widgets/circular_loading_widget.dart';
import '../../global_widgets/main_appbar.dart';
import '../controllers/auth_controller.dart';

class ForgotPasswordView extends GetView<AuthController> {
  @override
  Widget build(BuildContext context) {
    controller.forgotPasswordFormKey = new GlobalKey<FormState>();
    return Scaffold(
        appBar: MainAppBar(title: "Нууц үг сэргээх".tr),
        body: Form(
          key: controller.forgotPasswordFormKey,
          child: ListView(
            primary: true,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: SvgPicture.asset("assets/img_new/img_forgot_pass.svg"),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                child: Text(
                  "Таны нууц үгийг шинэчлэхийн тулд бид ямар холбоо барих мэдээллийг ашиглах вэ?",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                ),
              ),
              Obx(() {
                if (controller.loading.isTrue)
                  return CircularLoadingWidget(height: 300);
                else {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: controller.passResetIndex.value == 0
                                      ? Get.theme.focusColor
                                      : Colors.transparent),
                              borderRadius: BorderRadius.circular(20)),
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 80,
                                    width: 80,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 25),
                                    decoration: BoxDecoration(
                                        color:
                                            Get.theme.focusColor.withAlpha(7),
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    child: SvgPicture.asset(
                                        'assets/img_new/ic_message_active.svg',
                                        width: 27,
                                        height: 27),
                                  ),
                                  const SizedBox(width: 20),
                                  Container(
                                    child: Expanded(
                                        child: TextFormField(
                                      onTap: () =>
                                          controller.passResetIndex.value = 0,
                                      validator: (input) =>
                                          !GetUtils.isPhoneNumber(input!)
                                              ? "Зөв дугаар оруулна уу".tr
                                              : null,
                                      onChanged: (input) {
                                        controller.currentUser.value
                                            .phoneNumber = input;
                                        controller.passResetIndex.value = 0;
                                      },
                                      initialValue: controller
                                          .currentUser.value.phoneNumber,
                                      maxLines: 1,
                                      keyboardType: TextInputType.phone,
                                      decoration: InputDecoration(
                                        floatingLabelStyle: TextStyle(
                                            color: Color(0xff757575),
                                            fontSize: 18),
                                        labelStyle: TextStyle(
                                          color: Color(0xff757575),
                                          fontSize: 18,
                                        ),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        labelText: 'Sms-ээр:',
                                        hintText: "+976 88** **00".tr ?? '',
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                      ),
                                    )),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: controller.passResetIndex.value == 1
                                      ? Get.theme.focusColor
                                      : Colors.transparent),
                              borderRadius: BorderRadius.circular(20)),
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 80,
                                    width: 80,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 28),
                                    decoration: BoxDecoration(
                                        color:
                                            Get.theme.focusColor.withAlpha(7),
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    child: Image.asset(
                                        'assets/img_new/ic_email.png',
                                        width: 22,
                                        height: 22),
                                  ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                      child: TextFormField(
                                    validator: (input) =>
                                        !GetUtils.isEmail(input!)
                                            ? "Зөв имэйл оруулна уу".tr
                                            : null,
                                    onTap: () =>
                                        controller.passResetIndex.value = 1,
                                    initialValue:
                                        controller.currentUser.value.email,
                                    maxLines: 1,
                                    keyboardType: TextInputType.emailAddress,
                                    onChanged: (input) {
                                      controller.currentUser.value.email =
                                          input;
                                      controller.passResetIndex.value = 1;
                                    },
                                    decoration: InputDecoration(
                                      labelStyle: TextStyle(
                                        color: Color(0xff757575),
                                        fontSize: 18,
                                      ),
                                      hintMaxLines: 2,
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      labelText: "Имэйлээр:".tr,
                                      hintText: "johndoe@gmail.com".tr ?? '',
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                    ),
                                  )),
                                ],
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  );
                }
              }),
              BlockButtonWidget(
                onPressed: () async {
                  if (controller.currentUser.value.email != null ||
                      controller.currentUser.value.phoneNumber != null) {
                    await controller.sendResetLink();

                    Get.toNamed(Routes.PHONE_VERIFICATION, arguments: {
                      'passResetIndex': controller.passResetIndex.value,
                      'isResettingPassword': true
                    });
                  } else {
                    Get.showSnackbar(
                      Ui.ErrorSnackBar(
                          message: 'Та утасны дугаар эсвэл имэйлээ оруулна уу'),
                    );
                  }
                },
                text: "Үргэлжлүүлэх",
              ).paddingSymmetric(vertical: 10, horizontal: 25),
            ],
          ),
        ));
  }
}
