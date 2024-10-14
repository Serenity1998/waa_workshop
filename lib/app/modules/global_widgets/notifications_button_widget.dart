import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/app_routes.dart';
import '../../services/auth_service.dart';
import '../notifications/controllers/notifications_controller.dart';
import '../root/controllers/root_controller.dart';

class NotificationsButtonWidget extends GetView<RootController> {
  const NotificationsButtonWidget({
    this.iconColor,
    this.labelColor,
    Key? key,
  }) : super(key: key);

  final Color? iconColor;
  final Color? labelColor;

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (Get.find<AuthService>().isAuth == true) {
          try {
            Get.put(NotificationsController()).getNotifications().then((value) {
              Get.toNamed(Routes.NOTIFICATIONS);
            });
          } catch (e) {
            Get.toNamed(Routes.NOTIFICATIONS);
          }
        } else {
          Get.toNamed(Routes.LOGIN);
        }
      },
      child: Container(
        height: 35,
        width: 35,
        margin: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Stack(
            alignment: AlignmentDirectional.topEnd,
            children: <Widget>[
              Image.asset(
                "assets/img_new/ic_notification.png",
                width: 28,
              ),
              // Container(
              //   child: Obx(() {
              //     return Center(
              //       child: Text(
              //         controller.notificationsCount.value.toString(),
              //         textAlign: TextAlign.center,
              //         style: Get.textTheme.bodySmall?.merge(
              //           TextStyle(
              //             color: Colors.white,
              //             fontSize: 8,
              //             height: 1.4,
              //           ),
              //         ),
              //       ),
              //     );
              //   }),
              //   padding: EdgeInsets.all(0),
              //   decoration: BoxDecoration(
              //     color: Get.theme.focusColor,
              //     borderRadius: BorderRadius.all(
              //       Radius.circular(10),
              //     ),
              //   ),
              //   constraints: BoxConstraints(
              //       minWidth: 12, maxWidth: 12, minHeight: 12, maxHeight: 12),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
