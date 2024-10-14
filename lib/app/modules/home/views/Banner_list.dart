import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';
import '../controllers/home_controller.dart';

class BannerList extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 20),
          itemCount: controller.slider.length,
          itemBuilder: (context, index) {
            var slide = controller.slider[index];
            return GestureDetector(
              onTap: () {
                if (slide.salon != null) {
                  Get.toNamed(Routes.SALON, arguments: {
                    'salon': slide.salon,
                    'heroTag': 'salon_slide_item'
                  });
                } else if (slide.eService != null) {
                  Get.toNamed(Routes.E_SERVICE, arguments: {
                    'eService': slide.eService,
                    'heroTag': 'slide_item'
                  });
                }
              },
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32)),
                clipBehavior: Clip.hardEdge,
                elevation: 0,
                child: CachedNetworkImage(
                  width: Get.width - 60,
                  height: 181,
                  fit: BoxFit.fill,
                  imageUrl: "${controller.slider[index].image?.url}",
                  placeholder: (context, url) => Image.asset(
                    'assets/img/loading.gif',
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                  errorWidget: (context, url, error) =>
                      Icon(Icons.error_outline),
                ),
              ),
            );
          }),
    );
  }
}
