import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDialog extends StatelessWidget {
  final String? title;
  final String? text;
  const CustomDialog({Key? key, this.title, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(24.0))),
      content: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(30)),
        height: Get.height * 0.5,
        width: Get.width * 0.7,
        child: Column(
          children: [
            Image.asset(
              'assets/img_new/img_logo_big.png',
              width: 185,
              height: 180,
            ),
            Spacer(),
            Text(
              title ?? 'Баяр хүргэе!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Get.theme.focusColor,
              ),
            ),
            Spacer(),
            Text(
              text ??
                  'Таны хүсэлт амжилттай бүртгэгдлээ. Та хэдхэн секундын дараа нүүр хуудас руу шилжих болно.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            Spacer(),
            Image.asset('assets/img_new/img_loading_circle.png',
                width: 60, height: 60),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
