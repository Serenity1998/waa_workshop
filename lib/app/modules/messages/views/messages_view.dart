/*
 * File name: messages_view.dart
 * Last modified: 2022.02.18 at 19:24:11
 * Author: SmarterVision - https://codecanyon.net/user/smartervision
 * Copyright (c) 2022
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/empty_view.dart';
import '../../global_widgets/notifications_button_widget.dart';
import '../controllers/messages_controller.dart';
import '../widgets/message_item_widget.dart';

class MessagesView extends GetView<MessagesController> {
  Widget conversationsList() {
    return Obx(
      () {
        if (controller.messages.isNotEmpty) {
          var _messages = controller.messages;
          return ListView.separated(
              physics: AlwaysScrollableScrollPhysics(),
              controller: controller.scrollController,
              itemCount: _messages.length,
              separatorBuilder: (context, index) {
                return SizedBox(height: 7);
              },
              shrinkWrap: true,
              primary: false,
              itemBuilder: (context, index) {
                return MessageItemWidget(
                  message: _messages.elementAt(index),
                  onDismissed: (conversation) async {
                    await controller.deleteMessage(_messages.elementAt(index));
                  },
                );
                // }
              });
        } else {
          return EmptyView(
            message: "Та хүссэн бизнес эрхлэгчрүү чат бичээрэй",
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Chats".tr,
          style: Get.textTheme.titleLarge,
        ),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: Container(
          margin: EdgeInsets.only(left: 20),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Get.theme.primaryColor.withOpacity(0.5),
          ),
          child: Image.asset(
            "assets/img_new/ic_logo.png",
            fit: BoxFit.contain,
          ),
        ),
        actions: [NotificationsButtonWidget()],
      ),
      body: RefreshIndicator(
          onRefresh: () async {
            controller.messages.clear();
            // controller.lastDocument = new Rx<DocumentSnapshot>(null);
            await controller.listenForMessages();
          },
          child: conversationsList()),
    );
  }
}
