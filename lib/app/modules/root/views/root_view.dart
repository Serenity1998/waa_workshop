import '../../../../helpers/color.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../helpers/global_variables.dart';
import '../../../routes/app_routes.dart';
import '../../../services/auth_service.dart';
import '../../auth/controllers/auth_controller.dart';
import '../../auth/views/login_view.dart';
import '../../global_widgets/main_drawer_widget.dart';
import '../../account/views/account_view.dart';
import '../../bookings/views/bookings_view.dart';
import '../../home/views/home2_view.dart';
import '../../messages/views/messages_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

class MainTab extends StatefulWidget {
  final int indexTab;

  const MainTab({Key? key, required this.indexTab}) : super(key: key);

  @override
  State<MainTab> createState() => _MainTabState();
}

class _MainTabState extends State<MainTab> {
  int _selectedIndex = 0;
  Widget currentPage = HomeView();

  @override
  void initState() {
    super.initState();
    _onItemTapped(widget.indexTab);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 0:
          currentPage = HomeView();
          break;
        case 1:
          if (!Get.find<AuthService>().isAuth) {
            Get.offAll(() => LoginView());
            Get.toNamed(Routes.LOGIN);
          } else {
            currentPage = BookingsView();
          }
          break;
        case 2:
          if (!Get.find<AuthService>().isAuth) {
            Get.offAll(() => LoginView());
            Get.toNamed(Routes.LOGIN);
          } else {
            currentPage = MessagesView();
          }
          break;
        case 3:
          if (!Get.find<AuthService>().isAuth) {
            Get.offAll(() => LoginView());
            Get.toNamed(Routes.LOGIN);
          } else {
            currentPage = AccountView();
          }
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        elevation: 0,
        child: MainDrawerWidget(),
      ),
      body: currentPage,
      extendBody: true,
      bottomNavigationBar: SizedBox(
        height: 80,
        child: AnimatedBottomNavigationBar.builder(
          itemCount: 4,
          tabBuilder: (int index, bool isActive) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 7),
                index == 0
                    ? SvgPicture.asset(
                        "assets/img_new/ic_home${isActive ? "_active" : ""}.svg",
                      )
                    : index == 1
                        ? SvgPicture.asset(
                            "assets/img_new/ic_booking${isActive ? "_active" : ""}.svg",
                          )
                        : index == 2
                            ? SvgPicture.asset(
                                "assets/img_new/ic_message${isActive ? "_active" : ""}.svg",
                              )
                            : SvgPicture.asset(
                                "assets/img_new/ic_profile${isActive ? "_active" : ""}.svg",
                              ),
                const SizedBox(height: 3),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    index == 0
                        ? 'Home'
                        : index == 1
                            ? 'Bookings'.tr
                            : index == 2
                                ? 'Chats'.tr
                                : 'Account'.tr,
                    maxLines: 1,
                    style: TextStyle(
                      color: isActive == true
                          ? CoreColor.primary
                          : CoreColor.formGrey,
                      fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                      fontSize: 9,
                    ),
                  ),
                ),
              ],
            );
          },
          backgroundColor: Colors.grey.shade100.withOpacity(0.5),
          elevation: 0.0,
          activeIndex: _selectedIndex,
          splashSpeedInMilliseconds: 0,
          notchSmoothness: NotchSmoothness.defaultEdge,
          gapLocation: GapLocation.none,
          leftCornerRadius: 25,
          rightCornerRadius: 25,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
