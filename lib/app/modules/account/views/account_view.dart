import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../common/qr_scanner.dart';
import '../../../routes/app_routes.dart';
import '../../../services/auth_service.dart';
import '../../root/controllers/root_controller.dart';
import '../controllers/account_controller.dart';
import '../widgets/account_link_widget.dart';
import '../widgets/logout_bottomsheet.dart';

class AccountView extends GetView<AccountController> {
  @override
  Widget build(BuildContext context) {
    var _currentUser = Get.find<AuthService>().user;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Profile".tr,
            style: Get.textTheme.titleLarge,
          ),
          centerTitle: false,
          leading: GestureDetector(
            onTap: () => Scaffold.of(context).openDrawer(),
            child: Container(
              margin: EdgeInsets.only(left: 20),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Get.theme.primaryColor.withOpacity(0.5),
              ),
              child: Image.asset("assets/img_new/ic_logo.png"),
            ),
          ),
          elevation: 0,
          actions: [
            GestureDetector(
              onTap: () {
                Get.toNamed(Routes.MAPS);
              },
              child: Image.asset(
                "assets/img_new/ic_location.png",
                width: 24,
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.to(QrScanner());
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 27, left: 20),
                child: Image.asset(
                  "assets/img_new/ic_scan.png",
                  width: 22,
                ),
              ),
            )
          ],
        ),
        body: ListView(
          primary: true,
          children: [
            Obx(() {
              return Column(
                children: [
                  Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(60)),
                      child: CachedNetworkImage(
                        height: 120,
                        width: 120,
                        fit: BoxFit.cover,
                        imageUrl: _currentUser.value.avatar?.thumb ?? '',
                        placeholder: (context, url) => Image.asset(
                          'assets/img/loading.gif',
                          fit: BoxFit.cover,
                          height: 120,
                        ),
                        errorWidget: (context, url, error) =>
                            Icon(Icons.error_outline),
                      ),
                    ),
                  ),
                  Container(
                    width: Get.width,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 20, left: 20, right: 20),
                      child: Column(
                        children: [
                          Text(
                            _currentUser.value.name ?? '',
                            style: Get.textTheme.titleLarge,
                          ),
                          const SizedBox(height: 10),
                          Text(_currentUser.value.email ?? '',
                              style: Get.textTheme.titleLarge!
                                  .merge(TextStyle(fontSize: 14))),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Divider(
                color: Color(0xffEEEEEE),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 30,
              ),
              child: Column(
                children: [
                  AccountLinkWidget(
                    icon: SvgPicture.asset(
                      "assets/img_new/ic_account.svg",
                      color: Colors.black,
                    ),
                    text: Text("Профайл засах".tr),
                    onTap: (e) {
                      Get.toNamed(Routes.PROFILE);
                    },
                  ),
                  AccountLinkWidget(
                      icon: SvgPicture.asset(
                          "assets/img_new/ic_star_portfolio.svg",
                          color: Colors.black),
                      text: Text("Миний CV/Portfolio".tr),
                      onTap: (e) {
                        Get.toNamed(Routes.PORTFOLIO);
                      }),
                  // AccountLinkWidget(
                  //   icon: SvgPicture.asset(
                  //     "assets/img_new/ic_notification.svg",
                  //     color: Colors.black,
                  //   ),
                  //   text: Text("Notifications".tr),
                  //   onTap: (e) {
                  //     Get.toNamed(Routes.NOTIFICATION_SETTING);
                  //   },
                  // ),
                  AccountLinkWidget(
                    icon: SvgPicture.asset(
                      "assets/img_new/ic_wallet.svg",
                      color: Colors.black,
                    ),
                    text: Text("Нэхэмжлэх".tr),
                    onTap: (e) {
                      Get.toNamed(Routes.INVOICE);
                    },
                  ),
                  AccountLinkWidget(
                    icon: SvgPicture.asset(
                      "assets/img_new/ic_shield.svg",
                      color: Colors.black,
                    ),
                    text: Text("Аюулгүй байдал".tr),
                    onTap: (e) {
                      Get.toNamed(Routes.PRIVACYSECURITY);
                    },
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  AccountLinkWidget(
                    icon: SvgPicture.asset(
                      "assets/img_new/ic_more_circle.svg",
                      color: Colors.black,
                    ),
                    text: Text("Languages".tr),
                    onTap: (e) {
                      Get.toNamed(Routes.SETTINGS_LANGUAGE);
                    },
                  ),
                  AccountLinkWidget(
                    icon: SvgPicture.asset(
                      "assets/img_new/ic_show.svg",
                      color: Colors.black,
                    ),
                    text: Text("Theme Mode".tr),
                    onTap: (e) {
                      Get.toNamed(Routes.SETTINGS_THEME_MODE);
                    },
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
              child: Column(
                children: [
                  AccountLinkWidget(
                    icon: SvgPicture.asset(
                      "assets/img_new/ic_lock.svg",
                      color: Colors.black,
                    ),
                    text: Text("Нууцлалын бодлого".tr),
                    onTap: (e) async {
                      // Get.toNamed(Routes.PRIVACY);
                      await Get.toNamed(Routes.CUSTOM_PAGES,
                          arguments: Get.find<RootController>().customPages[0]);
                    },
                  ),
                  AccountLinkWidget(
                    icon: SvgPicture.asset(
                      "assets/img_new/ic_lock.svg",
                      color: Colors.black,
                    ),
                    text: Text("Үйлчилгээний нөхцөл".tr),
                    onTap: (e) async {
                      // Get.toNamed(Routes.PRIVACY);
                      await Get.toNamed(Routes.CUSTOM_PAGES,
                          arguments: Get.find<RootController>().customPages[1]);
                    },
                  ),
                  AccountLinkWidget(
                    icon: SvgPicture.asset(
                      "assets/img_new/ic_faq.svg",
                      color: Colors.black,
                    ),
                    text: Text("Тусламжийн төв".tr),
                    onTap: (e) {
                      Get.toNamed(Routes.HELP);
                    },
                  ),
                  AccountLinkWidget(
                    icon: Container(
                      height: 25,
                      width: 25,
                      child: SvgPicture.asset(
                        "assets/img_new/ic_logout.svg",
                        color: Colors.red,
                        fit: BoxFit.contain,
                      ),
                    ),
                    text: Text("Logout".tr),
                    onTap: (e) async {
                      Get.bottomSheet(LogoutBottomsheet(
                        onYes: () async {
                          await Get.find<AuthService>().removeCurrentUser();
                          Get.back();
                          await Get.find<RootController>().changePage(0);
                        },
                      ));
                      // await Get.find<AuthService>().removeCurrentUser();
                      // Get.find<RootController>().changePage(0);
                    },
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
