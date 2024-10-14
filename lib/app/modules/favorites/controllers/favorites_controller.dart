import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/ui.dart';
import '../../../models/e_service_model.dart';
import '../../../models/favorite_model.dart';
import '../../../models/salon_model.dart';
import '../../../repositories/e_service_repository.dart';
import '../../../services/auth_service.dart';

class FavoritesController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final favorites = <Favorite>[].obs;
  late EServiceRepository _eServiceRepository;
  RxList<dynamic> salonList = [].obs;
  RxInt tabIndex = 0.obs;
  PageController pageController = PageController();
  late TabController tabController;
  RxList eServices = [].obs;
  RxList salons = [].obs;

  FavoritesController() {
    _eServiceRepository = new EServiceRepository();
  }

  @override
  void onInit() async {
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      if (tabController.index != tabIndex) {
        tabIndex.value = tabController.index;
      }
    });
    await refreshFavorites();
    super.onInit();
  }

  Future refreshFavorites({bool? showMessage}) async {
    await getFavorites();
    if (showMessage == true) {
      Get.showSnackbar(Ui.SuccessSnackBar(
          message: "List of Services refreshed successfully".tr));
    }
  }

  Future getFavorites() async {
    try {
      await _eServiceRepository.getFavorites();
      favorites.assignAll(await _eServiceRepository.getFavorites());
      for (var item in favorites) {
        if (item.salon != null) {
          salons.add(item.salon);
        }
        if (item.eService != null) {
          eServices.add(item.eService);
        }
      }
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }

  Future addToFavorite({Salon? salon, EService? service}) async {
    try {
      Favorite _favorite;
      if (salon != null)
        _favorite = new Favorite(
          salon: salon,
          userId: Get.find<AuthService>().user.value.id,
        );
      else
        _favorite = new Favorite(
          eService: service,
          userId: Get.find<AuthService>().user.value.id,
        );
      await _eServiceRepository.addFavorite(_favorite);

      if (Get.isRegistered<FavoritesController>()) {
        Get.find<FavoritesController>().refreshFavorites();
      }
      if (salon != null) {
        Get.showSnackbar(Ui.SuccessSnackBar(
            message: '${salon.name ?? ''}' + " Added to favorite list".tr));
      } else {
        Get.showSnackbar(Ui.SuccessSnackBar(
            message: '${service?.name ?? ''}' + " Added to favorite list".tr));
      }
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }

  Future removeFromFavorite({Salon? salon, EService? service}) async {
    try {
      Favorite _favorite;
      if (salon != null)
        _favorite = new Favorite(
          salon: salon,
          userId: Get.find<AuthService>().user.value.id,
        );
      else
        _favorite = new Favorite(
          eService: service,
          userId: Get.find<AuthService>().user.value.id,
        );
      await _eServiceRepository.removeFavorite(_favorite);

      if (Get.isRegistered<FavoritesController>()) {
        Get.find<FavoritesController>().refreshFavorites();
      }
      if (salon != null) {
        Get.showSnackbar(Ui.SuccessSnackBar(
            message: '${salon.name ?? ''}' + " Removed from favorite list".tr));
      } else {
        Get.showSnackbar(Ui.SuccessSnackBar(
            message:
                '${service?.name ?? ''}' + " Removed from favorite list".tr));
      }
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }
}
