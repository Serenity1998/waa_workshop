import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/empty_view.dart';
import '../../../routes/app_routes.dart';
import '../../../services/auth_service.dart';
import '../../bookings/widgets/bookings_list_loader_widget.dart';
import '../controllers/category_controller.dart';
import 'companies_list_item_widget.dart';

class CompaniesListWidget extends GetView<CategoryController> {
  CompaniesListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.salons.isEmpty) {
        return controller.isLoading.value
            ? BookingsListLoaderWidget()
            : EmptyView(title: 'Компани олдсонгүй');
      } else {
        return ListView.builder(
          padding: EdgeInsets.only(bottom: 10, top: 10),
          primary: false,
          shrinkWrap: true,
          itemCount: controller.salons.length + 1,
          itemBuilder: ((_, index) {
            if (index == controller.salons.length) {
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
              var salonValue = controller.salons.elementAt(index);
              return CompaniesListItemWidget(
                salon: salonValue,
                favouriteClicked: () {
                  if (!Get.find<AuthService>().isAuth) {
                    Get.toNamed(Routes.LOGIN);
                  } else {
                    if (salonValue.isFavorite ?? false) {
                      controller.removeFromFavorite(salon: salonValue);
                    } else {
                      controller.addToFavorite(salon: salonValue);
                    }
                    controller.salons.refresh();
                  }
                },
              );
            }
          }),
        );
      }
    });
  }
}
