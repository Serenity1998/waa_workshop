import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../global_widgets/text_field_widget.dart';
import '../controllers/profile_controller.dart';

class ChangePasswordView extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Нууц үг солих"),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 48),
        child: MaterialButton(
          onPressed: () {
            controller.saveProfileForm();
          },
          height: 45,
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          color: Get.theme.colorScheme.secondary,
          child: Text("Хадгалах".tr,
              style: Get.textTheme.bodyMedium!
                  .merge(TextStyle(color: Colors.white))),
          elevation: 0,
          highlightElevation: 0,
          hoverElevation: 0,
          focusElevation: 0,
        ),
      ),
      body: ListView(
        children: [
          Obx(() {
            // TODO verify old password
            return TextFieldWidget(
              labelText: "Old Password".tr,
              hintText: "••••••••••••".tr,
              onSaved: (input) => controller.oldPassword.value = input!,
              onChanged: (input) => controller.oldPassword.value = input,
              validator: (input) => input!.length > 0 && input.length < 3
                  ? "Should be more than 3 letters".tr
                  : null,
              initialValue: controller.oldPassword.value,
              obscureText: controller.hidePassword.value,
              iconData: Icons.lock_outline,
              keyboardType: TextInputType.visiblePassword,
              suffixIcon: IconButton(
                onPressed: () {
                  controller.hidePassword.value =
                      !controller.hidePassword.value;
                },
                color: Theme.of(context).focusColor,
                icon: Icon(controller.hidePassword.value
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined),
              ),
              isFirst: true,
              isLast: false,
            );
          }),
          Obx(() {
            return TextFieldWidget(
              labelText: "New Password".tr,
              hintText: "••••••••••••".tr,
              onSaved: (input) => controller.newPassword.value = input!,
              onChanged: (input) => controller.newPassword.value = input,
              validator: (input) {
                if (input!.length > 0 && input.length < 3) {
                  return "Should be more than 3 letters".tr;
                } else if (input != controller.confirmPassword.value) {
                  return "Passwords do not match".tr;
                } else {
                  return null;
                }
              },
              initialValue: controller.newPassword.value,
              obscureText: controller.hidePassword.value,
              iconData: Icons.lock_outline,
              keyboardType: TextInputType.visiblePassword,
              isFirst: false,
              isLast: false,
            );
          }),
          Obx(() {
            return TextFieldWidget(
              labelText: "Confirm New Password".tr,
              hintText: "••••••••••••".tr,
              onSaved: (input) => controller.confirmPassword.value = input!,
              onChanged: (input) => controller.confirmPassword.value = input,
              validator: (input) {
                if (input!.length > 0 && input.length < 3) {
                  return "Should be more than 3 letters".tr;
                } else if (input != controller.newPassword.value) {
                  return "Passwords do not match".tr;
                } else {
                  return null;
                }
              },
              initialValue: controller.confirmPassword.value,
              obscureText: controller.hidePassword.value,
              iconData: Icons.lock_outline,
              keyboardType: TextInputType.visiblePassword,
              isFirst: false,
              isLast: true,
            );
          }),
        ],
      ),
    );
  }
}
