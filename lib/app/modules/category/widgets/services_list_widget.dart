import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/empty_view.dart';
import '../../../routes/app_routes.dart';
import '../../../services/auth_service.dart';
import '../../bookings/widgets/bookings_list_loader_widget.dart';
import '../controllers/category_controller.dart';
import 'services_list_item_widget.dart';

class ServicesListWidget extends GetView<CategoryController> {
  const ServicesListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.eServices.isEmpty) {
        return controller.isLoading.value
            ? BookingsListLoaderWidget()
            : EmptyView(title: 'Үйлчилгээ олдсонгүй');
      } else {
        return ListView.builder(
          padding: const EdgeInsets.only(bottom: 10, top: 10),
          primary: false,
          shrinkWrap: true,
          itemCount: controller.eServices.length + 1,
          itemBuilder: ((_, index) {
            if (index == controller.eServices.length) {
              return Obx(() {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Opacity(
                      opacity: controller.isLoading.value ? 1 : 0,
                      child: const CircularProgressIndicator(),
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
                    var _service = controller.eServices.elementAt(index);
                    if (!Get.find<AuthService>().isAuth) {
                      Get.toNamed(Routes.LOGIN);
                    } else {
                      if (_service.isFavorite ?? false) {
                        controller.removeFromFavorite(service: _service);
                      } else {
                        controller.addToFavorite(service: _service);
                      }
                      controller.eServices.refresh();
                    }
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
