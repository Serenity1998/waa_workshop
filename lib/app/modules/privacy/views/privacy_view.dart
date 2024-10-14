import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../global_widgets/block_button_widget.dart';
import '../../global_widgets/main_appbar.dart';
import '../controllers/privacy_controller.dart';

class PrivacySecurityView extends GetView<PrivacySecurityController> {
  Widget notifSetting(index) {
    var _switchValues =
        List.generate(controller.settings.length, (_) => false).obs;
    return Obx(
      () => Padding(
        padding: const EdgeInsets.only(top: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              controller.settings[index],
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            CupertinoSwitch(
                value: _switchValues[index],
                onChanged: (value) {
                  _switchValues[index] = value;
                },
                activeColor: Color(0xff7210FF)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MainAppBar(title: "Аюулгүй байдал".tr),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          children: [
            Container(
              height: 120,
              child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.settings.length,
                  itemBuilder: (context, index) {
                    return notifSetting(index);
                  }),
            ),
            // Container(
            //   padding: const EdgeInsets.symmetric(vertical: 4),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Text(
            //         "Google Authenticator",
            //         style: TextStyle(color: Colors.black, fontSize: 16),
            //       ),
            //       Icon(
            //         Icons.keyboard_arrow_right,
            //         color: Get.theme.focusColor,
            //       )
            //     ],
            //   ),
            // ),
            const SizedBox(height: 35),
            BlockButtonWidget(
                color: Color(0xffF1E7FF),
                text: "ПИН код солих",
                onPressed: () {}),
            const SizedBox(height: 24),
            BlockButtonWidget(
              color: Color(0xffF1E7FF),
              text: "Нууц үг солих",
              onPressed: () => Get.toNamed(Routes.CHANGE_PASSWORD),
            )
          ],
        ));
  }
}
