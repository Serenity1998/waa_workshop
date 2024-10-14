import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import '../../../../common/ui.dart';
import '../../bookings/controllers/booking_controller.dart';
import 'package:share_plus/share_plus.dart';

import '../../global_widgets/main_appbar.dart';

class BookingTicket extends GetView<BookingController> {
  Widget component(
    String? title, {
    String? desc,
    Color? valueColor,
    Widget? child,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "${title}",
            style: TextStyle(fontSize: 16),
          ),
          child == null
              ? Text(
                  "${desc}",
                  style: TextStyle(
                    color: valueColor != null ? valueColor : Color(0xff424242),
                    fontSize: 16,
                  ),
                )
              : child
        ],
      ),
    );
  }

  prepareQrImage() async {
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    final ts = DateTime.now().millisecondsSinceEpoch.toString();
    String path = '$tempPath/$ts.png';

    var file = await File(path).writeAsBytes(base64Decode(
      controller.booking.value.qr.toString(),
    ).buffer.asUint8List());
    return file;
  }

  saveToGallery() async {
    final success = await ImageGallerySaver.saveImage(base64Decode(
      controller.booking.value.qr.toString(),
    ).buffer.asUint8List());

    if (success!) {
      Get.showSnackbar(Ui.SuccessSnackBar(
          message: 'Амжилттай хадгалагдлаа. Та зургийн цомгоо шалгана уу.'));
    } else {
      Get.showSnackbar(
          Ui.ErrorSnackBar(message: 'Амжилтгүй боллоо, дахин оролдоно уу'));
    }
  }

  popUpButton() {
    return PopupMenuButton(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      onSelected: (item) {
        if (item == 'download') saveToGallery();
        if (item == 'share') share();
      },
      itemBuilder: (context) {
        var list = <PopupMenuEntry<Object>>[];
        list.add(
          PopupMenuItem(
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 10,
              children: [
                Image.asset('assets/img_new/ic_share.png',
                    width: 20, height: 20),
                Text('Хуваалцах', style: TextStyle(color: Get.theme.hintColor)),
              ],
            ),
            value: "share",
          ),
        );
        list.add(
          PopupMenuItem(
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 10,
              children: [
                Image.asset('assets/img_new/ic_download.png',
                    width: 20, height: 20),
                Text(
                  'Тасалбар татах',
                  style: TextStyle(color: Get.theme.hintColor),
                ),
              ],
            ),
            value: "download",
          ),
        );

        return list;
      },
      child: Padding(
        padding: EdgeInsets.only(right: 5),
        child: Image.asset('assets/img_new/ic_more_circle.png',
            width: 20, height: 20),
      ),
    );
  }

  void share() async {
    String qrPath = await prepareQrImage();
    if (qrPath.isNotEmpty) {
      try {
        await Share.shareXFiles([XFile(qrPath)]);
      } catch (e) {}
    } else {
      Get.showSnackbar(
          Ui.ErrorSnackBar(message: 'Амжилтгүй боллоо, дахин оролдоно уу'));
    }
  }

  String formatTimeOfDay(TimeOfDay tod) {
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm(); //"6:00 AM"
    return format.format(dt);
  }

  @override
  Widget build(BuildContext context) {
    final format = DateFormat.jm();
    var createdAtTime = format.format(controller.booking.value.createdAt!);
    var createdAt = DateFormat(' MMM d, ' 'yyyy', Get.locale.toString())
        .format(controller.booking.value.createdAt!);
    String createdAtValue = '$createdAt | $createdAtTime';
    var bookingAtTime = format.format(controller.booking.value.bookingAt!);
    var bookingAt = DateFormat(' MMM d, ' 'yyyy', Get.locale.toString())
        .format(controller.booking.value.bookingAt!);
    String bookingAtValue = '$bookingAt | $bookingAtTime';

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: MainAppBar(
        title: "Тасалбар",
        actions: [
          Container(
              padding:
                  const EdgeInsets.only(right: 15, left: 10, top: 5, bottom: 5),
              child: popUpButton())
        ],
      ),
      floatingActionButton: GestureDetector(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            height: 58,
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: Get.theme.focusColor,
              boxShadow: [
                BoxShadow(
                    color: Get.theme.focusColor.withOpacity(0.3),
                    blurRadius: 20,
                    offset: Offset(0, 2)),
                BoxShadow(
                    color: Get.theme.focusColor.withOpacity(0.2),
                    blurRadius: 10,
                    offset: Offset(0, 3))
              ],
            ),
            child: Text(
              'Тасалбар татах',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Get.theme.primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
          ),
          onTap: saveToGallery),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      key: key,
      body: Container(
        height: double.infinity,
        color: Get.theme.primaryColor,
        width: double.infinity,
        padding:
            const EdgeInsets.only(top: 20, right: 20, left: 20, bottom: 40),
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Image.memory(
                base64Decode(controller.booking.value.qr.toString()),
                width: 170,
                height: 170,
                scale: 0.5,
              ),
              alignment: Alignment.center,
            ),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.only(bottom: 20),
              decoration: Ui.getBoxDecoration(radius: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Захиалгын дэлгэрэнгүй",
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Get.theme.focusColor),
                  ),
                  const SizedBox(height: 10),
                  component("Бизнес эрхлэгч",
                      desc: controller.booking.value.salon?.name),
                  component("Ажилтан",
                      desc: controller.booking.value.employee?.name),
                  component("Захиалсан огноо",
                      desc: createdAtValue, valueColor: Get.theme.focusColor),
                  component("Захиалгын дугаар",
                      desc: "#" + controller.booking.value.id.toString()),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.only(bottom: 50),
              decoration: Ui.getBoxDecoration(radius: 20),
              child: Column(
                children: [
                  component('Огноо', desc: bookingAtValue),
                  component('Гүйлгээний ID',
                      child: Row(
                        children: [
                          Text(
                            "${controller.booking.value.payment != null ? controller.booking.value.payment?.id : '0'}",
                            style: TextStyle(fontSize: 16),
                          ),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: () {
                              Clipboard.setData(
                                new ClipboardData(
                                  text: controller.booking.value.payment!.id
                                      .toString(),
                                ),
                              );
                              Get.showSnackbar(Ui.SuccessSnackBar(
                                  message: 'Амжилттай хууллаа!'));
                            },
                            child: Image.asset('assets/img_new/ic_copy.png',
                                width: 22, height: 22),
                          )
                        ],
                      )),
                  component('Статус',
                      child: Container(
                        child: Text(
                          controller.booking.value.status!.status.toString(),
                          style: TextStyle(
                              fontSize: 12, color: Get.theme.focusColor),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Get.theme.focusColor.withAlpha(7)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                      )),
                  component("Төлбөрийн төлөв",
                      desc: controller
                              .booking.value.payment?.paymentStatus?.status ??
                          '',
                      valueColor: controller.booking.value.payment
                                  ?.paymentStatus?.order ==
                              0
                          ? Color(0xff4ADE80)
                          : Get.theme.focusColor),
                  component("Төлбөрийн нөхцөл",
                      desc: controller.booking.value.payment?.paymentMethod
                              ?.getName() ??
                          ''),
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }
}

class MySeparator extends StatelessWidget {
  const MySeparator({Key? key, this.height = 1, this.color = Colors.black})
      : super(key: key);
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 5.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
        );
      },
    );
  }
}
