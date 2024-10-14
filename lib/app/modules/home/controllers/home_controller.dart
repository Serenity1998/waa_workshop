/*
 * File name: home_controller.dart
 * Last modified: 2022.02.06 at 16:15:29
 * Author: SmarterVision - https://codecanyon.net/user/smartervision
 * Copyright (c) 2022
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/ui.dart';
import '../../../models/address_model.dart';
import '../../../models/category_model.dart';
import '../../../models/e_service_model.dart';
import '../../../models/favorite_model.dart';
import '../../../models/salon_model.dart';
import '../../../models/slide_model.dart';
import '../../../models/user_model.dart';
import '../../../repositories/category_repository.dart';
import '../../../repositories/e_service_repository.dart';
import '../../../repositories/salon_repository.dart';
import '../../../repositories/slider_repository.dart';
import '../../../services/auth_service.dart';
import '../../../services/settings_service.dart';
import '../../favorites/controllers/favorites_controller.dart';
import '../../root/controllers/root_controller.dart';

class HomeController extends GetxController {
  late CategoryRepository _categoryRepository;
  late SalonRepository _salonRepository;
  late EServiceRepository _eServiceRepository;

  Rx<User> currentUser = Get.find<AuthService>().user;
  Rx<Category> selectedCategory = Category().obs;

  final addresses = <Address>[].obs;
  final slider = <Slide>[].obs;
  final currentSlide = 0.obs;
  final featured = <Category>[].obs;

  final salons = <Salon>[].obs;
  final categories = <Category>[].obs;
  final eServices = <EService>[].obs;

  final page = 0.obs;
  RxBool loading = false.obs;
  late ScrollController scrollController;
  final isDone = false.obs;

  HomeController() {
    _categoryRepository = CategoryRepository();
    _salonRepository = SalonRepository();
    _eServiceRepository = EServiceRepository();
  }

  @override
  Future<void> onInit() async {
    await refreshHome();
    super.onInit();
  }

  Future refreshHome({bool showMessage = false}) async {
    await getCategories();
    await getRecommendedSalons();
    await getEservices();
    if (showMessage) {
      Get.showSnackbar(
          Ui.SuccessSnackBar(message: "Home page refreshed successfully".tr));
    }
  }

  Address get currentAddress {
    return Get.find<SettingsService>().address.value;
  }

  Future getCategories() async {
    try {
      categories.assignAll(await _categoryRepository.getAllWithSubCategories());
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }

  Future getRecommendedSalons() async {
    try {
      salons.assignAll(await _salonRepository.getRecommended());
      Get.log(salons.toString());
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }

  Future getEservices() async {
    try {
      eServices.assignAll(await _eServiceRepository
          .getLatestWithPagination(selectedCategory.value.id ?? "0"));
      Get.log(eServices.toString());
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }
}
