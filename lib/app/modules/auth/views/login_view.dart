import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/helper.dart';
import '../../../routes/app_routes.dart';
import '../../global_widgets/block_button_widget.dart';
import '../../global_widgets/text_field_widget.dart';
import '../../root/controllers/root_controller.dart';
import '../controllers/auth_controller.dart';

class LoginView extends GetView<AuthController> {
  @override
  Widget build(BuildContext context) {
    controller.loginFormKey = new GlobalKey<FormState>();
    return WillPopScope(
      onWillPop: Helper().onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Login".tr,
            style: Get.textTheme.titleLarge!
                .merge(TextStyle(color: context.theme.primaryColor)),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
          elevation: 0,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back,
                size: 17, color: Get.theme.hintColor),
            onPressed: () => Get.find<RootController>().changePageOutRoot(0),
          ),
        ),
        body: Form(
            key: controller.loginFormKey,
            child: FutureBuilder(
                future: controller.getSavedUser(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}',
                        style: Get.theme.textTheme.displayMedium!
                            .merge(TextStyle(fontSize: 16)));
                  } else {
                    return ListView(
                      primary: true,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 40, left: 20, right: 20, bottom: 20),
                          child: Text(
                            "Өөрийн хаягаар\nнэвтрэх",
                            style: Get.theme.textTheme.displayMedium!
                                .merge(TextStyle(fontSize: 32)),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            TextFieldWidget(
                              isNext: true,
                              labelText: "Email Address".tr,
                              hintText: "johndoe@gmail.com".tr,
                              onSaved: (input) =>
                                  controller.currentUser.value.email = input,
                              validator: (input) => !input!.contains('@')
                                  ? "Should be a valid email".tr
                                  : null,
                              iconData: Icons.email_rounded,
                              controller: controller.userName,
                              initialValue: snapshot.data?['username'],
                            ),
                            Obx(() {
                              return TextFieldWidget(
                                isNext: true,
                                labelText: "Password".tr,
                                hintText: "••••••••••••".tr,
                                onSaved: (input) => controller
                                    .currentUser.value.password = input,
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
                                controller: controller.password,
                                initialValue: snapshot.data?['password'],
                              );
                            }),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: InkWell(
                                    onTap: () {
                                      Get.toNamed(Routes.FORGOT_PASSWORD);
                                    },
                                    child: Text("Forgot Password?".tr,
                                        style: TextStyle(
                                            color: Get.theme.hintColor)),
                                  ),
                                ),
                              ],
                            ).paddingSymmetric(horizontal: 20),
                            Obx(
                              () => Container(
                                width: double.infinity,
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        print('here');
                                      },
                                      child: Checkbox(
                                        value: controller.saveInfo.value,
                                        onChanged: (value) {
                                          controller.setSaveInfo(value!);
                                        },
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        activeColor: Get.theme.focusColor,
                                        side: BorderSide(
                                            color: Get.theme.focusColor,
                                            width: 2),
                                      ),
                                    ),
                                    Text(
                                      'Сануулах',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            BlockButtonWidget(
                              onPressed: () {
                                controller.login();
                              },
                              text: "Нэвтрэх".tr,
                            ).paddingSymmetric(vertical: 10, horizontal: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                    onTap: () {
                                      Get.toNamed(Routes.REGISTER);
                                    },
                                    child:
                                        Text("You don't have an account?".tr)),
                              ],
                            ).paddingSymmetric(vertical: 20),
                          ],
                        )
                      ],
                    );
                  }
                })),
      ),
    );
  }
}
