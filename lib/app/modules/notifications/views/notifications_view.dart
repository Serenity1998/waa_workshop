import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/empty_view.dart';
import '../../../providers/laravel_provider.dart';
import '../../global_widgets/main_appbar.dart';
import '../controllers/notifications_controller.dart';
import '../widgets/booking_notification_item_widget.dart';
import '../widgets/message_notification_item_widget.dart';
import '../widgets/notification_item_widget.dart';

class NotificationsView extends GetView<NotificationsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(title: "Notifications".tr, centerTitle: true),
      body: Stack(
        children: [
          RefreshIndicator(
            onRefresh: () async {
              Get.find<LaravelApiClient>().forceRefresh();
              await controller.refreshNotifications(showMessage: true);
              Get.find<LaravelApiClient>().unForceRefresh();
            },
            child: ListView(
              primary: true,
              children: <Widget>[
                notificationsList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget notificationsList() {
    return Obx(() {
      var _notifications = controller.notifications;
      if (_notifications.length > 0) {
        return ListView.separated(
            itemCount: _notifications.length,
            separatorBuilder: (context, index) {
              return SizedBox(height: 7);
            },
            shrinkWrap: true,
            primary: false,
            itemBuilder: (context, index) {
              var _notification = controller.notifications.elementAt(index);
              if (_notification.data?['message_id'] != null) {
                return MessageNotificationItemWidget(
                    notification: _notification);
              } else if (_notification.data?['booking_id'] != null) {
                return BookingNotificationItemWidget(
                    notification: _notification);
              } else {
                return NotificationItemWidget(
                  notification: _notification,
                  onDismissed: (notification) {
                    controller.removeNotification(notification);
                  },
                  onTap: (notification) async {
                    await controller.markAsReadNotification(notification);
                  },
                );
              }
            });
      } else {
        return EmptyView(
          title: "Танд одоогоор мэдэгдэл ирээгүй байна",
        );
      }
    });
  }
}
