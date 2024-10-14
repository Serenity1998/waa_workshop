import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/helper.dart';
import '../../../routes/app_routes.dart';
import '../../global_widgets/block_button_widget.dart';
import '../../global_widgets/main_appbar.dart';
import '../../global_widgets/text_field_widget.dart';
import '../controllers/auth_controller.dart';

class RegisterView extends GetView<AuthController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    controller.registerFormKey = GlobalKey<FormState>();
    return WillPopScope(
      onWillPop: Helper().onWillPop,
      child: Scaffold(
        appBar: MainAppBar(title: "Register".tr),
        body: Form(
          key: controller.registerFormKey,
          child: ListView(
            primary: true,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 60, left: 20, right: 20, bottom: 20),
                child: Text(
                  "Шинэ бүртгэл\nүүсгэх",
                  style: Get.theme.textTheme.displayMedium!
                      .merge(const TextStyle(fontSize: 28)),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 30),
                  TextFieldWidget(
                    isNext: true,
                    labelText: "Email Address".tr,
                    hintText: "Email Address".tr,
                    initialValue: controller.currentUser.value.email.toString(),
                    onChanged: (input) =>
                        controller.currentUser.value.email = input,
                    validator: (input) => !input!.contains('@')
                        ? "Should be a valid email".tr
                        : null,
                    iconData: Icon(Icons.email_rounded,
                            color: Theme.of(context).focusColor)
                        .icon,
                    isFirst: false,
                    isLast: false,
                  ),
                  Obx(() {
                    return TextFieldWidget(
                      isNext: false,
                      labelText: "Password".tr,
                      hintText: "Password".tr,
                      initialValue:
                          controller.currentUser.value.password.toString(),
                      onChanged: (input) =>
                          controller.currentUser.value.password = input,
                      validator: (input) => input!.length < 3
                          ? "Should be more than 3 characters".tr
                          : null,
                      obscureText: controller.hidePassword.value,
                      iconData: Icon(Icons.lock_outline,
                              color: Theme.of(context).focusColor)
                          .icon,
                      keyboardType: TextInputType.visiblePassword,
                      isLast: true,
                      isFirst: false,
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
                            color: Theme.of(context).focusColor),
                      ),
                    );
                  }),
                  Obx(
                    () => GestureDetector(
                      onTap: () {
                        controller.saveInfo.value = !controller.saveInfo.value;
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Checkbox(
                            value: controller.saveInfo.value,
                            onChanged: (value) {
                              controller.saveInfo.value =
                                  !controller.saveInfo.value;
                            },
                          ),
                          Text(
                            'Сануулах'.tr,
                            style: Get.textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: Get.width,
                    child: BlockButtonWidget(
                      onPressed: () {
                        controller.register();
                      },
                      text: "Register".tr,
                    ).paddingOnly(top: 15, bottom: 5, right: 20, left: 20),
                  ),
                ],
              )
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                direction: Axis.vertical,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: InkWell(
                        onTap: () {
                          Get.toNamed(Routes.LOGIN);
                        },
                        child: Text("You already have an account?".tr)
                            .paddingOnly(bottom: 10)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
