/*
 * File name: salon_controller.dart
 * Last modified: 2022.02.12 at 21:57:18
 * Author: SmarterVision - https://codecanyon.net/user/smartervision
 * Copyright (c) 2022
 */

import 'salon_awards_controller.dart';
import 'salon_experiences_controller.dart';
import 'salon_reviews_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../common/helper.dart';
import '../../../../common/ui.dart';
import '../../../models/category_model.dart';
import '../../../models/favorite_model.dart';
import '../../../models/message_model.dart';
import '../../../models/salon_model.dart';
import '../../../models/user_model.dart';
import '../../../repositories/e_service_repository.dart';
import '../../../repositories/salon_repository.dart';
import '../../../routes/app_routes.dart';
import '../../../services/auth_service.dart';
import '../../favorites/controllers/favorites_controller.dart';
import '../../global_widgets/tab_bar_widget.dart';
import '../views/salon_awards_view.dart';
import '../views/salon_details_view.dart';
import '../views/salon_e_services_view.dart';
import '../views/salon_experiences_view.dart';
import '../views/salon_galleries_view.dart';
import '../views/salon_reviews_view.dart';
import 'salon_e_services_controller.dart';

class SalonController extends GetxController {
  var salon = Salon().obs;
  final currentSlide = 0.obs;
  var currentIndex = 0.obs;
  PageController pageController = PageController();

  RxBool loading = false.obs;

  final salonMarkers = <Marker>[].obs;

  List<Widget> pages = [
    const SalonDetailsView(),
    SalonEServicesView(),
    SalonGalleriesView(),
    SalonReviewsView(),
    SalonAwardsView(),
    SalonExperiencesView(),
  ];

  String heroTag = "";
  late SalonRepository _salonRepository;
  late EServiceRepository _eServiceRepository;

  SalonController() {
    _salonRepository = SalonRepository();
    _eServiceRepository = EServiceRepository();
  }

  @override
  Future<void> onInit() async {
    Map<String, dynamic> arguments;
    arguments = Get.arguments as Map<String, dynamic>;
    salon.value = arguments['salon'];
    heroTag = arguments['heroTag'] as String;

    if (Get.isRegistered<TabBarController>(tag: 'salon')) {
      Get.find<TabBarController>(tag: 'salon').selectedId.value = '0';
    }
    currentIndex.value = 0;
    await initialize();
    super.onInit();
  }

  Future<void> initialize() async {
    await refreshSalon();
    Get.put(SalonEServicesController());
    Get.put(SalonReviewsController());
    Get.put(SalonAwardsController());
    Get.put(SalonExperiencesController());
    loading.value = true;
  }

  Widget get currentPage => pages[currentIndex.value];

  void changePage(int index) {
    currentIndex.value = index;
    pageController.animateTo(
      double.parse(index.toString()),
      duration: const Duration(microseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  Future refreshSalon({bool showMessage = false}) async {
    await getSalon();
    if (showMessage) {
      Get.showSnackbar(Ui.SuccessSnackBar(
          message:
              "${salon.value.name}" + " " + "page refreshed successfully".tr));
    }
  }

  Future getSalon() async {
    try {
      var distance = salon.value.distance;
      if (salon.value.id == null) {
        throw Exception("Salon id not found");
      }
      salon.value = await _salonRepository.get(salon.value.id ?? "");
      salon.value.distance = distance;
      var marker =
          await Helper().getSalonMarker(salon.value, salon.value.address);
      salonMarkers.add(marker);
    } catch (e) {
      Get.log(e.toString());
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }

  void startChat() {
    List<User> _employees = salon.value.employees!.map((e) {
      e.avatar = salon.value.images?[0];
      return e;
    }).toList();
    Message _message = new Message(_employees, name: salon.value.name);
    Get.toNamed(Routes.CHAT, arguments: _message);
  }

  Future addToFavorite(Salon _salon) async {
    try {
      Favorite favorite = Favorite(
        salon: _salon,
        userId: Get.find<AuthService>().user.value.id,
      );
      await _eServiceRepository.addFavorite(favorite);
      salon.value = _salon;
      salon.update((val) {
        val?.isFavorite = true;
      });

      if (Get.isRegistered<FavoritesController>()) {
        Get.find<FavoritesController>().refreshFavorites();
      }

      Get.showSnackbar(Ui.SuccessSnackBar(
          message: "${_salon.name}${" Added to favorite list".tr}"));
    } catch (e) {
      Get.log(e.toString());
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }

  Future removeFromFavorite(Salon _salon) async {
    try {
      Favorite favorite = Favorite(
        salon: _salon,
        userId: Get.find<AuthService>().user.value.id,
      );
      await _eServiceRepository.removeFavorite(favorite);

      salon.value = _salon;
      salon.update((val) {
        val?.isFavorite = false;
      });

      if (Get.isRegistered<FavoritesController>()) {
        Get.find<FavoritesController>().refreshFavorites();
      }
      Get.showSnackbar(Ui.SuccessSnackBar(
          message: "${_salon.name}${" Removed from favorite list".tr}"));
    } catch (e) {
      Get.log(e.toString());
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }
}
