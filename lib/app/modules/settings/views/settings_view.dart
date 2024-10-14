import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../global_widgets/tab_bar_widget.dart';
import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  final _navigatorKey = Get.nestedKey(1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Settings".tr,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          leading: Container(
            margin: EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Get.theme.primaryColor.withOpacity(0.5),
            ),
            child: new IconButton(
              icon: new Icon(Icons.arrow_back,
                  size: 22, color: Get.theme.hintColor),
              onPressed: Get.back,
            ),
          ),
          leadingWidth: 50,
          elevation: 0,
          bottom: TabBarWidget(
            initialSelectedId: 0,
            tag: 'settings',
            tabs: [
              ChipWidget(
                tag: 'settings',
                text: "Languages".tr,
                id: 0,
                onSelected: (id) {
                  controller.changePage(id);
                },
              ),
              ChipWidget(
                tag: 'settings',
                text: "Profile".tr,
                id: 1,
                onSelected: (id) {
                  controller.changePage(id);
                },
              ),
              ChipWidget(
                tag: 'settings',
                text: "Addresses".tr,
                id: 2,
                onSelected: (id) {
                  controller.changePage(id);
                },
              ),
              ChipWidget(
                tag: 'settings',
                text: "Theme Mode".tr,
                id: 3,
                onSelected: (id) {
                  controller.changePage(id);
                },
              )
            ],
          )),
      body: WillPopScope(
        onWillPop: () async {
          if (_navigatorKey!.currentState!.canPop()) {
            _navigatorKey?.currentState?.pop();
            return false;
          }
          return true;
        },
        child: Navigator(
          key: _navigatorKey,
          initialRoute: Routes.SETTINGS_LANGUAGE,
          onGenerateRoute: controller.onGenerateRoute,
        ),
      ),
    );
  }
}
