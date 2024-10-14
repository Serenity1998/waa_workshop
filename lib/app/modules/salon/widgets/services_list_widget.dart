/*
 * File name: services_list_widget.dart
 * Last modified: 2022.08.16 at 12:29:00
 * Author: SmarterVision - https://codecanyon.net/user/smartervision
 * Copyright (c) 2022
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/empty_view.dart';
import '../../../providers/laravel_provider.dart';
import '../../../routes/app_routes.dart';
import '../../../services/auth_service.dart';
import '../../category/widgets/services_list_item_widget.dart';
import '../../favorites/controllers/favorites_controller.dart';
import '../controllers/salon_e_services_controller.dart';
import 'services_list_loader_widget.dart';

class ServicesListWidget extends GetView<SalonEServicesController> {
  ServicesListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (Get.find<LaravelApiClient>().isLoading(tasks: [
            'getSalonEServices',
            'getSalonPopularEServices',
            'getSalonMostRatedEServices',
            'getSalonAvailableEServices',
            'getSalonFeaturedEServices'
          ], task: '') &&
          controller.page == 1) {
        return ServicesListLoaderWidget();
      } else if (controller.eServices.isEmpty) {
        return EmptyView(title: 'Одоогоор үйлчилгээ байхгүй байна.');
      } else {
        return ListView.builder(
          padding: EdgeInsets.only(bottom: 10, top: 10),
          primary: false,
          shrinkWrap: true,
          itemCount: controller.eServices.length + 1,
          itemBuilder: ((_, index) {
            if (index == controller.eServices.length) {
              return Obx(() {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Center(
                    child: new Opacity(
                      opacity: controller.isLoading.value ? 1 : 0,
                      child: new CircularProgressIndicator(),
                    ),
                  ),
                );
              });
            } else {
              return Obx(() {
                var _service = controller.eServices.elementAt(index);
                return ServicesListItemWidget(
                  service: _service,
                  favouriteClicked: () {
                    if (!Get.find<AuthService>().isAuth) {
                      Get.toNamed(Routes.LOGIN);
                    } else {
                      if (_service.isFavorite ?? false) {
                        Get.put(FavoritesController())
                            .removeFromFavorite(service: _service);
                      } else {
                        Get.put(FavoritesController())
                            .addToFavorite(service: _service);
                      }
                    }
                    controller.eServices.refresh();
                  },
                );
              });
            }
          }),
        );
      }
    });
  }
}
