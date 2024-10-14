import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' show DateFormat;

import '../../../../common/ui.dart';
import '../../../models/notification_model.dart' as model;

class NotificationItemWidget extends StatelessWidget {
  NotificationItemWidget(
      {Key? key,
      required this.notification,
      required this.onDismissed,
      required this.onTap,
      this.icon})
      : super(key: key);
  final model.Notification notification;
  final ValueChanged<model.Notification> onDismissed;
  final ValueChanged<model.Notification> onTap;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(this.notification.hashCode.toString()),
      background: Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Align(
          alignment: Alignment.centerRight,
          child: Icon(
            Icons.delete_outline,
            color: Colors.red,
            size: 30,
          ),
        ),
      ),
      onDismissed: (direction) {
        onDismissed(this.notification);
        Get.showSnackbar(
            Ui.SuccessSnackBar(message: "The notification is deleted".tr));
      },
      child: GestureDetector(
        onTap: () {
          onTap(notification);
        },
        child: Container(
          padding: EdgeInsets.all(15),
          height: 110,
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Color(0xff04060f).withAlpha(5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 63,
                height: 63,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: [
                          notification.read!
                              ? Get.theme.focusColor.withOpacity(0.6)
                              : Get.theme.focusColor.withOpacity(1),
                          notification.read!
                              ? Get.theme.focusColor.withOpacity(0.1)
                              : Get.theme.focusColor.withOpacity(0.2),
                          // Get.theme.focusColor.withOpacity(0.2),
                        ])),
                child: notification.image != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: CachedNetworkImage(
                          imageUrl: "${notification.image}",
                          fit: BoxFit.cover,
                          errorWidget: ((context, url, error) =>
                              icon ?? Icon(Icons.alarm)),
                        ),
                      )
                    : icon ??
                        Icon(
                          Icons.notifications_outlined,
                          color: Get.theme.scaffoldBackgroundColor,
                          size: 38,
                        ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    notification.salon!.containsKey("name")
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  "${notification.salon?["name"]}",
                                  style: TextStyle(
                                    fontWeight: notification.read!
                                        ? FontWeight.w300
                                        : FontWeight.w600,
                                    color: Colors.black87,
                                    fontSize: 16,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                DateFormat('y.MM.dd | HH:mm',
                                        Get.locale.toString())
                                    .format(this.notification.createdAt!),
                                style: Get.textTheme.bodySmall!
                                    .merge(TextStyle(color: Colors.black87)),
                              ),
                            ],
                          )
                        : Container(),
                    Text(
                      this.notification.getMessage(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Color(0xff616161),
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
