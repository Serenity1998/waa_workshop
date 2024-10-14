import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../common/custom_dialog.dart';
import '../../global_widgets/block_button_widget.dart';
import '../../global_widgets/circular_loading_widget.dart';
import '../../global_widgets/main_appbar.dart';
import '../../global_widgets/text_field_widget.dart';
import '../controllers/auth_controller.dart';

class NewPasswordView extends GetView<AuthController> {
  @override
  Widget build(BuildContext context) {
    controller.forgotPasswordFormKey = new GlobalKey<FormState>();
    return Scaffold(
        appBar: MainAppBar(title: "Шинэ нууц үг үүсгэх".tr),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: ListView(
            primary: true,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: SvgPicture.asset("assets/img_new/img_new_password.svg"),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                child: Text(
                  "Шинэ нууц үгээ үүсгэнэ үү",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                ),
              ),
              Obx(() {
                if (controller.loading.isTrue)
                  return CircularLoadingWidget(height: 300);
                else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFieldWidget(
                        isNext: true,
                        labelText: "Password".tr,
                        hintText: "••••••••••••".tr,
                        initialValue:
                            controller.currentUser.value.password.toString(),
                        onSaved: (input) =>
                            controller.currentUser.value.password = input,
                        validator: (input) => input!.length < 3
                            ? "Should be more than 3 characters".tr
                            : null,
                        obscureText: controller.hidePassword.value,
                        iconData: Icons.lock_rounded,
                        keyboardType: TextInputType.visiblePassword,
                        suffixIcon: IconButton(
                          onPressed: () {
                            controller.hidePassword.value =
                                !controller.hidePassword.value;
                          },
                          color: Theme.of(context).focusColor,
                          icon: Icon(
                            controller.hidePassword.value
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                          ),
                        ),
                      ),
                      TextFieldWidget(
                        isNext: true,
                        labelText: "Password".tr,
                        hintText: "••••••••••••".tr,
                        initialValue:
                            controller.currentUser.value.password.toString(),
                        onSaved: (input) =>
                            controller.currentUser.value.password = input,
                        validator: (input) => input!.length < 3
                            ? "Should be more than 3 characters".tr
                            : null,
                        obscureText: controller.hidePassword.value,
                        iconData: Icons.lock_rounded,
                        keyboardType: TextInputType.visiblePassword,
                        suffixIcon: IconButton(
                          onPressed: () {
                            controller.hidePassword.value =
                                !controller.hidePassword.value;
                          },
                          color: Theme.of(context).focusColor,
                          icon: Icon(
                            controller.hidePassword.value
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      BlockButtonWidget(
                        onPressed: () async {
                          showDialog(
                              context: context,
                              builder: (_) => const CustomDialog());
                        },
                        text: "Үргэлжлүүлэх".tr,
                      ).paddingSymmetric(horizontal: 20),
                    ],
                  );
                }
              }),
            ],
          ),
        ));
  }
}
