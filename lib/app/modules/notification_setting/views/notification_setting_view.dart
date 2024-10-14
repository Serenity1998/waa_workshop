import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/notification_setting_controller.dart';

class NotificationSettingView extends GetView<NotificationSettingController> {
  Widget notifSetting(index) {
    var _switchValues =
        List.generate(controller.settings.length, (_) => false).obs;
    return Obx(() => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  controller.settings[index],
                  style: TextStyle(color: Color(0xff), fontSize: 16),
                ),
                SizedBox(
                  height: 10,
                  width: 44,
                  child: CupertinoSwitch(
                      value: _switchValues[index],
                      onChanged: (value) {
                        _switchValues[index] = value;
                      },
                      activeColor: Color(0xff7210FF)),
                ),
              ],
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Мэдэгдлүүд".tr,
          style: Get.textTheme.headlineSmall,
        ),
        centerTitle: false,
        elevation: 0,
      ),
      body: ListView.builder(
          shrinkWrap: true,
          itemCount: controller.settings.length,
          itemBuilder: (context, index) {
            return notifSetting(index);
          }),
    );
  }
}
