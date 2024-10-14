import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../global_widgets/dropdown_widget.dart';
import '../../global_widgets/main_appbar.dart';
import '../../global_widgets/phone_field_widget.dart';
import '../../global_widgets/text_field_widget.dart';
import '../controllers/portfolio_controller.dart';

class IntroductionCreateView extends GetView<PortfolioController> {
  @override
  Widget build(BuildContext context) {
    // var _currentUser = Get.find<AuthService>().user;

    return Scaffold(
      appBar: MainAppBar(
        title: "Таны танилцуулга",
      ),
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
            // controller.saveIntroductionForm();
            Get.toNamed(Routes.PORTFOLIO_EDUCATION);
          },
          height: 58,
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          color: Get.theme.colorScheme.secondary,
          child: Text(
            "Үргэлжлүүлэх".tr,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          elevation: 0,
          highlightElevation: 0,
          hoverElevation: 0,
          focusElevation: 0,
        ),
      ),
      body: Form(
        key: controller.introductionForm,
        child: ListView(
          primary: true,
          children: [
            Center(
              child: Stack(alignment: Alignment.bottomRight, children: [
                Container(
                  margin: EdgeInsets.all(10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(60)),
                    child: CachedNetworkImage(
                      height: 120,
                      width: 120,
                      fit: BoxFit.cover,
                      imageUrl: 'http://via.placeholder.com/200x150',
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
              ]),
            ),
            SizedBox(
              height: 15,
            ),
            TextFieldWidget(
              onSaved: (input) => controller.user.value.name = input,
              validator: (input) =>
                  input!.length < 3 ? "Should be more than 3 letters".tr : null,
              initialValue: controller.user.value.name,
              hintText: "John Doe".tr,
              labelText: "Full Name".tr,
            ),
            TextFieldWidget(
              onSaved: (input) => controller.user.value.name = input,
              validator: (input) =>
                  input!.length < 3 ? "3-с урт тэмдэгт байна." : null,
              initialValue: controller.user.value.name,
              hintText: "Өөрийн намтараа оруулна уу",
              labelText: "Товц намтар",
            ),
            TextFieldWidget(
              onSaved: (input) => controller.user.value.email = input,
              validator: (input) =>
                  !input!.contains('@') ? "Should be a valid email" : null,
              initialValue: controller.user.value.email,
              hintText: "johndoe@gmail.com",
              labelText: "Email".tr,
            ),
            PhoneFieldWidget(
              labelText: "Phone Number".tr,
              hintText: "223 665 7896".tr,
              initialCountryCode:
                  controller.user.value.getPhoneNumber().countryISOCode,
              initialValue: controller.user.value.getPhoneNumber().number,
              onSaved: (phone) {
                controller.user.value.phoneNumber = phone?.completeNumber;
              },
            ),
            DropdownWidget(
              items: [],
              hint: "Ажлын байрны төрөл",
              suffixIcon: Image.asset(
                "assets/img_new/ic_dropdown.png",
                width: 25,
                color: Colors.grey.shade600,
              ),
            ),
            DropdownWidget(
              items: [],
              hint: "АБ тодорхойлолт (нябо, инженер, хөгжүүлэгч...)",
              suffixIcon: Image.asset(
                "assets/img_new/ic_dropdown.png",
                width: 25,
                color: Colors.grey.shade600,
              ),
            ),
            DropdownWidget(
              items: [],
              hint: "Ажиллах цаг",
              suffixIcon: Image.asset(
                "assets/img_new/ic_dropdown.png",
                width: 25,
                color: Colors.grey.shade600,
              ),
            ),
            DropdownWidget(
              items: [],
              hint: "Хүсэмжит цалин",
              suffixIcon: Image.asset(
                "assets/img_new/ic_dropdown.png",
                width: 25,
                color: Colors.grey.shade600,
              ),
            )
          ],
        ),
      ),
    );
  }
}
