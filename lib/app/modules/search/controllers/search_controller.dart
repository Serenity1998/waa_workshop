/*
 * File name: search_controller.dart
 * Last modified: 2022.02.18 at 19:24:11
 * Author: SmarterVision - https://codecanyon.net/user/smartervision
 * Copyright (c) 2022
 */

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import '../../../../common/ui.dart';
import '../../../models/category_model.dart';
import '../../../models/e_service_model.dart';
import '../../../models/salon_model.dart';
import '../../../providers/laravel_provider.dart';
import '../../../repositories/category_repository.dart';
import '../../../repositories/e_service_repository.dart';

class SearchControllerCustom extends GetxController
    with GetSingleTickerProviderStateMixin {
  final heroTag = "".obs;
  final categories = <Category>[].obs;
  final mainCategories = <Category>[].obs;
  RxBool hasSubCategory = false.obs;
  late Category currentCategory;
  final selectedCategories = <String>[].obs;
  final selectedCategoriesName = <String>[].obs;
  RxBool isService = true.obs;
  RxBool autoFocus = true.obs;
  late TabController tabController;
  RxInt tabIndex = 0.obs;
  late PageController pageController;
  RxString searchValue = ''.obs;
  late TextEditingController textEditingController;

  final eServices = <EService>[].obs;
  final salons = <Salon>[].obs;
  late EServiceRepository _eServiceRepository;
  late CategoryRepository _categoryRepository;
  RxList<int> starList = [5, 4, 3, 2, 1].obs;
  RxInt star = 0.obs;
  RxBool isCustomerAddress = false.obs;
  late LaravelApiClient laravelApiClient;
  Rx<SfRangeValues> priceRange = SfRangeValues(0.0, 350.0).obs;
  RxList<int> selectedRates = <int>[].obs;
  RxList searchHistory = [].obs;
  late Timer debounce;

  SearchControllerCustom() {
    _eServiceRepository = new EServiceRepository();
    _categoryRepository = new CategoryRepository();
    textEditingController = new TextEditingController();
  }

  @override
  void onInit() async {
    tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    tabController.addListener(() {
      if (tabController.index != tabIndex) {
        tabIndex.value = tabController.index;
      }
    });
    pageController = PageController(initialPage: 0);
    pageController.addListener(() {
      pageController.animateToPage(tabController.index,
          duration: Duration(milliseconds: 0), curve: Curves.easeIn);
    });
    await refreshSearch();
    await getSearchHistory();
    super.onInit();
  }

  @override
  void onReady() {
    heroTag.value = Get.arguments?.toString() ?? '';
    super.onReady();
  }

  @override
  void onClose() {
    debounce.cancel();
    pageController.dispose();
    tabController.dispose();
    eServices.clear();
    salons.clear();
    super.onClose();
  }

  void clearPreviousData() {
    star.value = 0;
    priceRange = SfRangeValues(0.0, 350.0).obs;
    isCustomerAddress.value = false;
    eServices.clear();
    salons.clear();
  }

  Future refreshSearch({bool? showMessage}) async {
    await getCategories();
    await searchEServices();
    if (showMessage == true) {
      Get.showSnackbar(Ui.SuccessSnackBar(
          message: "List of services refreshed successfully".tr));
    }
  }

  Future getSearchHistory() async {
    searchHistory.value = await Get.put(LaravelApiClient()).getSearchHistory();
    searchHistory.value = searchHistory.reversed.toList();
  }

  Future searchEServices({String? keywords}) async {
    // if (debounce.isActive == false) debounce.cancel();
    // debounce = Timer(const Duration(milliseconds: 400), () async {
    //   try {
    //     if (selectedCategories.isEmpty) {
    //       eServices.assignAll((await _eServiceRepository.searchServices(
    //         keywords!,
    //         categories.map((element) => element.id!).toList(),
    //         low_price: priceRange.value.start.toInt() * 1000,
    //         max_price: priceRange.value.end.toInt() * 1000,
    //         review_rate: star.value,
    //         customer_address: isCustomerAddress.value,
    //       )));
    //     } else {
    //       eServices.assignAll(await _eServiceRepository.searchServices(
    //         keywords!,
    //         selectedCategories.toList(),
    //         low_price: priceRange.value.start.toInt() * 1000,
    //         max_price: priceRange.value.end.toInt() * 1000,
    //         review_rate: star.value,
    //         customer_address: isCustomerAddress.value,
    //       ));
    //     }
    //   } catch (e) {
    //     Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    //   }
    // });
  }

  Future searchSalons({String? keywords}) async {
    if (debounce.isActive == false) debounce.cancel();
    debounce = Timer(const Duration(milliseconds: 400), () async {
      try {
        if (selectedCategories.isEmpty) {
          salons.assignAll((await _eServiceRepository.searchSalons(
            keywords!,
            categories.map((element) => element.id!).toList(),
            low_price: priceRange.value.start.toInt() * 1000,
            max_price: priceRange.value.end.toInt() * 1000,
            review_rate: star.value,
            customer_address: isCustomerAddress.value,
          )));
        } else {
          salons.assignAll(await _eServiceRepository.searchSalons(
            keywords!,
            selectedCategories.toList(),
            low_price: priceRange.value.start.toInt() * 1000,
            max_price: priceRange.value.end.toInt() * 1000,
            review_rate: star.value,
            customer_address: isCustomerAddress.value,
          ));
        }
      } catch (e) {
        Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
      }
    });
  }

  Future getCategories() async {
    try {
      categories.assignAll(await _categoryRepository.getAllParents());
      mainCategories.assignAll(await _categoryRepository.getAllParents());
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }

  bool isSelectedCategory(Category category) {
    return selectedCategories.contains(category.id);
  }

  void toggleCategory(bool value, Category category) {
    if (!selectedCategories.contains(category.id)) {
      selectedCategories.add(category.id!);
      selectedCategoriesName.add(category.name!);
    } else {
      selectedCategories.removeWhere((element) => element == category.id);
      selectedCategoriesName.removeWhere((element) => element == category.name);
    }
  }

  void clear() {
    // currentCategory = null;
    tabIndex.value = 0;
    eServices.clear();
    selectedCategories.clear();
    selectedCategoriesName.clear();
    textEditingController.clear();
  }
}
