import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/ui.dart';
import '../../../models/faq_model.dart';
import '../controllers/help_controller.dart';

class FaqItemWidget extends GetWidget<HelpController> {
  final Faq faq;

  FaqItemWidget({Key? key, required this.faq}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          decoration: Ui.getBoxDecoration(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "${this.faq.question}",
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xff212121),
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 3,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Image.asset(
                    "assets/img_new/ic_arrow_down.png",
                    width: 12,
                    height: 12,
                  )
                ],
              ),
              controller.selectedFaq.value == faq.id
                  ? Divider(height: 30, thickness: 1)
                  : SizedBox(),
              controller.selectedFaq.value == faq.id
                  ? Flexible(
                      child: Text(
                        "${this.faq.answer}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff424242),
                        ),
                      ),
                    )
                  : SizedBox()
            ],
          ),
        );
      },
    );
  }
}
