/*
 * File name: profile_view.dart
 * Last modified: 2022.08.18 at 20:21:38
 * Author: SmarterVision - https://codecanyon.net/user/smartervision
 * Copyright (c) 2022
 */

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../global_widgets/circular_loading_widget.dart';
import '../../global_widgets/main_appbar.dart';
import '../../global_widgets/phone_field_widget.dart';
import '../../global_widgets/text_field_widget.dart';
import '../controllers/profile_controller.dart';
import '../widgets/delete_account_widget.dart';

class ProfileView extends GetView<ProfileController> {
  final bool hideAppBar;

  ProfileView({this.hideAppBar = false}) {
    // controller.profileForm = new GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    controller.profileForm = new GlobalKey<FormState>();
    return Scaffold(
        appBar: MainAppBar(title: 'Профайл засах'),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: BoxDecoration(
            color: Get.theme.primaryColor,
            borderRadius: BorderRadius.all(Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                  color: Get.theme.focusColor.withOpacity(0.1),
                  blurRadius: 10,
                  offset: Offset(0, -5)),
            ],
          ),
          child: MaterialButton(
            onPressed: () {
              controller.saveProfileForm();
            },
            height: 58,
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100)),
            color: Get.theme.colorScheme.secondary,
            child: Text("Шинэчлэх".tr,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                )),
            elevation: 0,
            highlightElevation: 0,
            hoverElevation: 0,
            focusElevation: 0,
          ),
        ),
        body: Obx(() {
          if (!controller.user.value.hasData) {
            return CircularLoadingWidget();
          } else {
            return Form(
                key: controller.profileForm,
                child: ListView(
                  children: [
                    Center(
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Container(
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(60)),
                              child: CachedNetworkImage(
                                height: 120,
                                width: 120,
                                fit: BoxFit.cover,
                                imageUrl:
                                    controller.user.value.avatar?.thumb ?? '',
                                placeholder: (context, url) => Image.asset(
                                  'assets/img/loading.gif',
                                  fit: BoxFit.cover,
                                  height: 120,
                                ),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error_outline),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 5, bottom: 5),
                            child: Image.asset(
                              "assets/img_new/ic_edit.png",
                              width: 25,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFieldWidget(
                      onSaved: (input) => controller.user.value.name = input,
                      validator: (input) => input!.length < 3
                          ? "Should be more than 3 letters".tr
                          : null,
                      initialValue: controller.user.value.name,
                      hintText: "John Doe".tr,
                      labelText: "Full Name".tr,
                      iconData: Icons.person_outline,
                    ),
                    TextFieldWidget(
                      onSaved: (input) => controller.user.value.email = input,
                      validator: (input) => !input!.contains('@')
                          ? "Should be a valid email"
                          : null,
                      initialValue: controller.user.value.email,
                      hintText: "johndoe@gmail.com",
                      labelText: "Email".tr,
                      iconData: null,
                      suffixIcon: Icon(
                        Icons.email_outlined,
                        color: Colors.black,
                      ),
                    ),
                    PhoneFieldWidget(
                      labelText: "Phone Number".tr,
                      hintText: "223 665 7896".tr,
                      initialCountryCode:
                          controller.user.value.getPhoneNumber().countryISOCode,
                      initialValue:
                          controller.user.value.getPhoneNumber().number,
                      onSaved: (phone) {
                        controller.user.value.phoneNumber =
                            phone?.completeNumber;
                      },
                      suffix: controller.user.value.verifiedPhone!
                          ? Text(
                              "Verified".tr,
                              style: Get.textTheme.bodySmall!
                                  .merge(TextStyle(color: Colors.green)),
                            )
                          : Text(
                              "Not Verified".tr,
                              style: Get.textTheme.bodySmall!
                                  .merge(TextStyle(color: Colors.redAccent)),
                            ),
                    ),
                    TextFieldWidget(
                      onSaved: (input) => controller.user.value.address = input,
                      validator: (input) => input!.length < 3
                          ? "Should be more than 3 letters".tr
                          : null,
                      initialValue: controller.user.value.address,
                      hintText: "123 Street, City 136, State, Country".tr,
                      labelText: "Address".tr,
                      iconData: Icons.map_outlined,
                    ),
                    TextFieldWidget(
                      onSaved: (input) => controller.user.value.bio = input,
                      initialValue: controller.user.value.bio,
                      hintText: "Your short biography here".tr,
                      labelText: "Short Biography".tr,
                      iconData: Icons.article_outlined,
                    ),
                    // GestureDetector(
                    //   onTap: () {
                    //     Get.toNamed(Routes.CHANGE_PASSWORD);
                    //   },
                    //   child: Container(
                    //     child: TextFieldWidget(
                    //       initialValue: "Нууц үг солих",
                    //       enabled: false,
                    //       suffixIcon: Icon(Icons.chevron_right),
                    //       iconData: Icons.article_outlined,
                    //     ),
                    //   ),
                    // ),
                    DeleteAccountWidget(),
                  ],
                ));
          }
        }));
    // Scaffold(
    //     appBar: hideAppBar
    //         ? null
    //         : AppBar(
    //             title: Text(
    //               "Profile".tr,
    //               style: context.textTheme.titleLarge,
    //             ),
    //             centerTitle: true,
    //             backgroundColor: Colors.transparent,
    //             automaticallyImplyLeading: false,
    //             leading: new IconButton(
    //               icon: new Icon(Icons.arrow_back_ios,
    //                   color: Get.theme.hintColor),
    //               onPressed: Get.back,
    //             ),
    //             elevation: 0,
    //           ),
    //     bottomNavigationBar: Container(
    //       padding: EdgeInsets.symmetric(vertical: 10),
    //       decoration: BoxDecoration(
    //         color: Get.theme.primaryColor,
    //         borderRadius: BorderRadius.only(
    //             topLeft: Radius.circular(20), topRight: Radius.circular(20)),
    //         boxShadow: [
    //           BoxShadow(
    //               color: Get.theme.focusColor.withOpacity(0.1),
    //               blurRadius: 10,
    //               offset: Offset(0, -5)),
    //         ],
    //       ),
    //       child: Row(
    //         children: [
    //           Expanded(
    //             child: MaterialButton(
    //               onPressed: () {
    //                 controller.saveProfileForm();
    //               },
    //               padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
    //               shape: RoundedRectangleBorder(
    //                   borderRadius: BorderRadius.circular(10)),
    //               color: Get.theme.colorScheme.secondary,
    //               child: Text("Save".tr,
    //                   style: Get.textTheme.bodyMedium
    //                       .merge(TextStyle(color: Get.theme.primaryColor))),
    //               elevation: 0,
    //               highlightElevation: 0,
    //               hoverElevation: 0,
    //               focusElevation: 0,
    //             ),
    //           ),
    //           SizedBox(width: 10),
    //           MaterialButton(
    //             onPressed: () {
    //               controller.resetProfileForm();
    //             },
    //             padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
    //             shape: RoundedRectangleBorder(
    //                 borderRadius: BorderRadius.circular(10)),
    //             color: Get.theme.hintColor.withOpacity(0.1),
    //             child: Text("Reset".tr, style: Get.textTheme.bodyMedium),
    //             elevation: 0,
    //             highlightElevation: 0,
    //             hoverElevation: 0,
    //             focusElevation: 0,
    //           ),
    //         ],
    //       ).paddingSymmetric(vertical: 10, horizontal: 20),
    //     ),
    //     body: Form(
    //       key: controller.profileForm,
    //       child: ListView(
    //         primary: true,
    //         children: [
    //           Text("Profile details".tr, style: Get.textTheme.headlineSmall)
    //               .paddingOnly(top: 25, bottom: 0, right: 22, left: 22),
    //           Text("Change the following details and save them".tr,
    //                   style: Get.textTheme.bodySmall)
    //               .paddingSymmetric(horizontal: 22, vertical: 5),
    //           Obx(() {
    //             return ImageFieldWidget(
    //               label: "Image".tr,
    //               field: 'avatar',
    //               tag: controller.profileForm.hashCode.toString(),
    //               initialImage: controller.avatar.value,
    //               uploadCompleted: (uuid) {
    //                 controller.avatar.value = new Media(id: uuid);
    //               },
    //               reset: (uuid) {
    //                 controller.avatar.value =
    //                     new Media(thumb: controller.user.value.avatar.thumb);
    //               },
    //             );
    //           }),
    //           TextFieldWidget(
    //             onSaved: (input) => controller.user.value.name = input,
    //             validator: (input) => input.length < 3
    //                 ? "Should be more than 3 letters".tr
    //                 : null,
    //             initialValue: controller.user.value.name,
    //             hintText: "John Doe".tr,
    //             labelText: "Full Name".tr,
    //             iconData: Icons.person_outline,
    //           ),
    //           TextFieldWidget(
    //             onSaved: (input) => controller.user.value.email = input,
    //             validator: (input) =>
    //                 !input.contains('@') ? "Should be a valid email" : null,
    //             initialValue: controller.user.value.email,
    //             hintText: "johndoe@gmail.com",
    //             labelText: "Email".tr,
    //             iconData: Icons.alternate_email,
    //           ),
    //           PhoneFieldWidget(
    //             labelText: "Phone Number".tr,
    //             hintText: "223 665 7896".tr,
    //             initialCountryCode:
    //                 controller.user.value.getPhoneNumber()?.countryISOCode,
    //             initialValue: controller.user.value.getPhoneNumber()?.number,
    //             onSaved: (phone) {
    //               return controller.user.value.phoneNumber =
    //                   phone.completeNumber;
    //             },
    //             suffix: controller.user.value.verifiedPhone
    //                 ? Text(
    //                     "Verified".tr,
    //                     style: Get.textTheme.bodySmall
    //                         .merge(TextStyle(color: Colors.green)),
    //                   )
    //                 : Text(
    //                     "Not Verified".tr,
    //                     style: Get.textTheme.bodySmall
    //                         .merge(TextStyle(color: Colors.redAccent)),
    //                   ),
    //           ),
    //           TextFieldWidget(
    //             onSaved: (input) => controller.user.value.address = input,
    //             validator: (input) => input.length < 3
    //                 ? "Should be more than 3 letters".tr
    //                 : null,
    //             initialValue: controller.user.value.address,
    //             hintText: "123 Street, City 136, State, Country".tr,
    //             labelText: "Address".tr,
    //             iconData: Icons.map_outlined,
    //           ),
    //           TextFieldWidget(
    //             onSaved: (input) => controller.user.value.bio = input,
    //             initialValue: controller.user.value.bio,
    //             hintText: "Your short biography here".tr,
    //             labelText: "Short Biography".tr,
    //             iconData: Icons.article_outlined,
    //           ),
    //           Text("Change password".tr, style: Get.textTheme.headlineSmall)
    //               .paddingOnly(top: 25, bottom: 0, right: 22, left: 22),
    //           Text(
    //                   "Fill your old password and type new password and confirm it"
    //                       .tr,
    //                   style: Get.textTheme.bodySmall)
    //               .paddingSymmetric(horizontal: 22, vertical: 5),
    //           Obx(() {
    //             // TODO verify old password
    //             return TextFieldWidget(
    //               labelText: "Old Password".tr,
    //               hintText: "••••••••••••".tr,
    //               onSaved: (input) => controller.oldPassword.value = input,
    //               onChanged: (input) => controller.oldPassword.value = input,
    //               validator: (input) => input.length > 0 && input.length < 3
    //                   ? "Should be more than 3 letters".tr
    //                   : null,
    //               initialValue: controller.oldPassword.value,
    //               obscureText: controller.hidePassword.value,
    //               iconData: Icons.lock_outline,
    //               keyboardType: TextInputType.visiblePassword,
    //               suffixIcon: IconButton(
    //                 onPressed: () {
    //                   controller.hidePassword.value =
    //                       !controller.hidePassword.value;
    //                 },
    //                 color: Theme.of(context).focusColor,
    //                 icon: Icon(controller.hidePassword.value
    //                     ? Icons.visibility_outlined
    //                     : Icons.visibility_off_outlined),
    //               ),
    //               isFirst: true,
    //               isLast: false,
    //             );
    //           }),
    //           Obx(() {
    //             return TextFieldWidget(
    //               labelText: "New Password".tr,
    //               hintText: "••••••••••••".tr,
    //               onSaved: (input) => controller.newPassword.value = input,
    //               onChanged: (input) => controller.newPassword.value = input,
    //               validator: (input) {
    //                 if (input.length > 0 && input.length < 3) {
    //                   return "Should be more than 3 letters".tr;
    //                 } else if (input != controller.confirmPassword.value) {
    //                   return "Passwords do not match".tr;
    //                 } else {
    //                   return null;
    //                 }
    //               },
    //               initialValue: controller.newPassword.value,
    //               obscureText: controller.hidePassword.value,
    //               iconData: Icons.lock_outline,
    //               keyboardType: TextInputType.visiblePassword,
    //               isFirst: false,
    //               isLast: false,
    //             );
    //           }),
    //           Obx(() {
    //             return TextFieldWidget(
    //               labelText: "Confirm New Password".tr,
    //               hintText: "••••••••••••".tr,
    //               onSaved: (input) => controller.confirmPassword.value = input,
    //               onChanged: (input) =>
    //                   controller.confirmPassword.value = input,
    //               validator: (input) {
    //                 if (input.length > 0 && input.length < 3) {
    //                   return "Should be more than 3 letters".tr;
    //                 } else if (input != controller.newPassword.value) {
    //                   return "Passwords do not match".tr;
    //                 } else {
    //                   return null;
    //                 }
    //               },
    //               initialValue: controller.confirmPassword.value,
    //               obscureText: controller.hidePassword.value,
    //               iconData: Icons.lock_outline,
    //               keyboardType: TextInputType.visiblePassword,
    //               isFirst: false,
    //               isLast: true,
    //             );
    //           }),
    //           DeleteAccountWidget(),
    //         ],
    //       ),
    //     ));
  }
}
