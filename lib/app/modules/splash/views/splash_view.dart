import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../global_widgets/block_button_widget.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  Widget _image(String imgFile) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment(1, 1),
          colors: <Color>[Color(0xFF02D6FC), Color(0xFF8B1345)],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            "assets/img/$imgFile",
            height: Get.height * 0.6,
            width: Get.width,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          alignment: Alignment.center,
          children: [
            Obx(
              () => Positioned(
                bottom: 100,
                child: DotsIndicator(
                  dotsCount: 3,
                  position: controller.currentPageNotifier.toInt(),
                  decorator: DotsDecorator(
                      color: Color(0xff02E9FC),
                      size: const Size.square(8.0),
                      activeSize: const Size(25.0, 8.0),
                      activeShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0)),
                      activeColor: Colors.blue),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: PageView(
                  controller: controller.pageController,
                  onPageChanged: (index) {
                    controller.currentPageNotifier.value = index;
                  },
                  children: [
                    Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 50, bottom: 25),
                          child: _image('img1.jpeg'),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Text(
                            'Таны онлайн хувийн салон',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 50, bottom: 25),
                          child: _image('img2.jpeg'),
                        ),
                        Text(
                          'Зөвхөн танд зориулсан уян хатан ажлын цагийн хуваарь',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 50, bottom: 25),
                          child: _image('img3.jpeg'),
                        ),
                        Text(
                          'Өөрийн уран бүтээлээ\nдэлхийд харуул!',
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ]),
            ),
            Obx(
              () => Positioned(
                bottom: 40,
                right: 20,
                left: 20,
                child: Container(
                  height: 45,
                  width: MediaQuery.of(context).size.width,
                  child: BlockButtonWidget(
                    color: null,
                    onPressed: () async {
                      if (controller.currentPageNotifier < 3 - 1) {
                        controller.pageController.nextPage(
                            curve: Curves.ease,
                            duration: Duration(milliseconds: 100));
                      } else {
                        // controller.setIsFirst(false);
                        // await Get.offNamedUntil(Routes.LOGIN, (Route route) {
                        //   if (route.settings.name == Routes.LOGIN) {
                        //     return true;
                        //   }
                        //   return false;
                        // });
                      }
                    },
                    text: controller.currentPageNotifier == 2
                        ? "Нэвтрэх"
                        : "Дараах".tr,
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
