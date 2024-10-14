import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/ui.dart';
import '../../global_widgets/block_button_widget.dart';
import '../controllers/account_controller.dart';

class LogoutBottomsheet extends GetWidget<AccountController> {
  final Function? onYes;

  LogoutBottomsheet({this.onYes});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 256,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40))),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 35, bottom: 20),
            child: Text(
              "Гарах",
              style: TextStyle(fontSize: 20, color: Color(0xffF75555)),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Divider(),
          ),
          const SizedBox(height: 20),
          const Text(
            "Та гарахдаа итгэлтэй байна уу?",
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                SizedBox(
                  width: Get.width / 2 - 31,
                  child: BlockButtonWidget(
                      color: lightPurpleColor,
                      textColor: Get.theme.focusColor,
                      text: "Буцах",
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                ),
                const SizedBox(width: 12),
                SizedBox(
                  width: Get.width / 2 - 31,
                  child: BlockButtonWidget(
                      text: "Тийм, Гарах",
                      onPressed: () {
                        if (onYes != null) {
                          onYes!();
                        }
                      }),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
