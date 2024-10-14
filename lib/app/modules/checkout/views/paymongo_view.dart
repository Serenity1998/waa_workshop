import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../global_widgets/main_appbar.dart';
import '../controllers/paymongo_controller.dart';

class PayMongoViewWidget extends GetView<PayMongoController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(title: "PayMongo Payment".tr, centerTitle: true),
      body: Stack(
        children: <Widget>[
          Obx(() {
            return WebViewWidget(
              controller: controller.webViewController,
            );
          }),
          Obx(() {
            if (controller.progress.value < 1) {
              return SizedBox(
                height: 3,
                child: LinearProgressIndicator(
                  backgroundColor:
                      Get.theme.colorScheme.secondary.withOpacity(0.2),
                ),
              );
            } else {
              return SizedBox();
            }
          })
        ],
      ),
    );
  }
}
