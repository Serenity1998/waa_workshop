/*
 * File name: custom_pages_view.dart
 * Last modified: 2022.02.18 at 19:24:11
 * Author: SmarterVision - https://codecanyon.net/user/smartervision
 * Copyright (c) 2022
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/ui.dart';
import '../../../providers/laravel_provider.dart';
import '../../global_widgets/main_appbar.dart';
import '../controllers/custom_pages_controller.dart';
import '../widgets/custom_page_loading_widget.dart';

class CustomPagesView extends GetView<CustomPagesController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MainAppBar(
            title: "${controller.customPage.value.title}".tr,
            centerTitle: true),
        body: RefreshIndicator(
          onRefresh: () async {
            Get.find<LaravelApiClient>().forceRefresh();
            controller.refreshCustomPage(showMessage: true);
            Get.find<LaravelApiClient>().unForceRefresh();
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Obx(() {
              if (controller.customPage.value.content!.isEmpty) {
                return CustomPageLoadingWidget();
              } else {
                return const Text("heee");
                // return Padding(
                //   padding: const EdgeInsets.all(20.0),
                //   child: Ui.applyHtml(controller.customPage.value.content!),
                // );
              }
            }),
          ),
        ));
  }
}
