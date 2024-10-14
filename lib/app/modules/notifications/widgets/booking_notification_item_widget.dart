import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/helper.dart';
import '../../../models/notification_model.dart' as model;
import '../../../repositories/booking_repository.dart';
import '../../../routes/app_routes.dart';
import '../../bookings/controllers/booking_controller.dart';
import '../controllers/notifications_controller.dart';
import 'notification_item_widget.dart';

class BookingNotificationItemWidget extends GetView<NotificationsController> {
  BookingNotificationItemWidget({Key? key, required this.notification})
      : super(key: key);
  final model.Notification notification;

  @override
  Widget build(BuildContext context) {
    return NotificationItemWidget(
      notification: notification,
      onDismissed: (notification) {
        controller.removeNotification(notification);
      },
      icon: Icon(
        Icons.assignment_outlined,
        color: Get.theme.scaffoldBackgroundColor,
        size: 34,
      ),
      onTap: (notification) async {
        Helper.basicLoader();
        final bookingController = Get.put(BookingController());
        bookingController.booking.value = await BookingRepository()
            .get(notification.data!['booking_id'].toString());
        Get.back();
        Get.toNamed(Routes.BOOKING_AT_SALON);

        await controller.markAsReadNotification(notification);
      },
    );
  }
}
