import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/empty_view.dart';
import '../../../routes/app_routes.dart';
import '../../../services/auth_service.dart';
import '../../bookings/widgets/bookings_list_loader_widget.dart';
import '../../category/widgets/companies_list_item_widget.dart';
import '../../category/widgets/services_list_item_widget.dart';
import '../../favorites/controllers/favorites_controller.dart';
import '../controllers/maps_controller.dart';

class MapsListWidget extends GetView<MapsController> {
  MapsListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return BookingsListLoaderWidget();
      } else if (controller.salons.isEmpty || controller.eServices.isEmpty) {
        return EmptyView(
            message: 'Таны хайлтанд тохирох үйлчилгээ байхгүй байна');
      } else {
        return RefreshIndicator(
          onRefresh: controller.getNearSalons,
          child: Obx(() {
            return PageView(
              onPageChanged: (value) {
                controller.tabIndex.value = value;
                controller.tabController.index = value;
                controller.tabController.animateTo(value);
              },
              controller: controller.pageController,
              children: [
                ListView.builder(
                  padding: EdgeInsets.only(bottom: 10, top: 10),
                  primary: false,
                  shrinkWrap: true,
                  itemCount: controller.eServices.length,
                  itemBuilder: ((_, index) {
                    if (index == controller.eServices.length) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new Center(
                          child: new Opacity(
                            opacity: controller.isLoading.value ? 1 : 0,
                            child: new CircularProgressIndicator(),
                          ),
                        ),
                      );
                    } else {
                      var item = controller.eServices.elementAt(index);

                      return ServicesListItemWidget(
                        service: item,
                        favouriteClicked: () {
                          final favController = Get.put(FavoritesController());
                          var _service = controller.eServices.elementAt(index);
                          if (!Get.find<AuthService>().isAuth) {
                            Get.toNamed(Routes.LOGIN);
                          } else {
                            if (_service.isFavorite ?? false) {
                              favController.removeFromFavorite(
                                  service: _service);
                            } else {
                              favController.addToFavorite(service: _service);
                            }
                          }
                        },
                      );
                    }
                  }),
                ),
                ListView.builder(
                  padding: EdgeInsets.only(bottom: 10, top: 10),
                  primary: false,
                  shrinkWrap: true,
                  itemCount: controller.salons.length,
                  itemBuilder: ((_, index) {
                    if (index == controller.salons.length) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new Center(
                          child: new Opacity(
                            opacity: controller.isLoading.value ? 1 : 0,
                            child: new CircularProgressIndicator(),
                          ),
                        ),
                      );
                    } else {
                      var item = controller.salons.elementAt(index);

                      return CompaniesListItemWidget(
                        salon: item,
                        favouriteClicked: () {
                          final favController = Get.put(FavoritesController());
                          if (!Get.find<AuthService>().isAuth) {
                            Get.toNamed(Routes.LOGIN);
                          } else {
                            if (item.isFavorite ?? false) {
                              favController.removeFromFavorite(salon: item);
                            } else {
                              favController.addToFavorite(salon: item);
                            }
                          }
                        },
                      );
                    }
                  }),
                ),
              ],
            );
          }),
        );
      }
    });
  }
}
