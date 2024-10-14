import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../global_widgets/main_appbar.dart';
import '../controllers/privacy_controller.dart';

class PrivacyView extends GetView<PrivacyController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(title: "Privacy Policy".tr, centerTitle: true),
      body: RefreshIndicator(
        onRefresh: () async {},
        child: WebViewWidget(controller: controller.webViewController),
      ),
    );
  }
}
