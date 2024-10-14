import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../../../common/ui.dart';
import '../../../models/category_model.dart';
import '../../../models/e_service_model.dart';
import '../../../models/favorite_model.dart';
import '../../../models/salon_model.dart';
import '../../../repositories/e_service_repository.dart';
import '../../../services/auth_service.dart';
import '../../e_service/controllers/e_service_controller.dart';
import '../../favorites/controllers/favorites_controller.dart';
import '../../salon/controllers/salon_controller.dart';

enum CategoryFilter { ALL, AVAILABILITY, RATING, FEATURED, POPULAR }

class CategoryController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final category = Category().obs;
  final selected = Rx<CategoryFilter>(CategoryFilter.ALL);
  final eServices = <EService>[].obs;
  final page = 0.obs;
  final isLoading = true.obs;
  final isDone = false.obs;
  final selectedSubCategory = <String>[].obs;
  late EServiceRepository _eServiceRepository;
  ScrollController scrollController = ScrollController();
  RxString statusType = "Үйлчилгээ".obs;
  Rx<SfRangeValues> priceRange = const SfRangeValues(0.0, 350.0).obs;
  RxInt tabIndex = 0.obs;
  final salons = <Salon>[].obs;
  PageController pageController = PageController();
  late TabController tabController;

  CategoryController() {
    _eServiceRepository = EServiceRepository();
  }

  @override
  Future<void> onInit() async {
    category.value = Get.arguments as Category;
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !isDone.value) {
        loadEServicesOfCategory(
          category.value.id!,
          filter: selected.value,
        );
      }
    });
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      if (tabController.index != tabIndex) {
        tabIndex.value = tabController.index;
      }
    });
    await refreshEServices();
    super.onInit();
  }

  @override
  void onClose() {
    scrollController.dispose();
  }

  Future refreshEServices({bool? showMessage}) async {
    await loadEServicesOfCategory(category.value.id!, filter: selected.value);
    await loadEServicesByCompany(category.value.id!);

    if (showMessage == true) {
      Get.showSnackbar(Ui.SuccessSnackBar(
          message: "List of services refreshed successfully".tr));
    }
  }

  void changeTab() async {
    if (tabIndex == 0) {
      await loadEServicesOfCategory(category.value.id!, filter: selected.value);
    } else {
      await loadEServicesByCompany(category.value.id!);
    }
  }

  bool isSelected(CategoryFilter filter) => selected == filter;

  void toggleSelected(CategoryFilter filter) {
    this.eServices.clear();
    this.page.value = 0;
    if (isSelected(filter)) {
      selected.value = CategoryFilter.ALL;
    } else {
      selected.value = filter;
    }
  }

  void toggleSubCategory(bool value, Category category) {
    this.eServices.clear();
    this.page.value = 0;
    if (value) {
      selectedSubCategory.add(category.id!);
    } else {
      selectedSubCategory.removeWhere((element) => element == category.id);
    }
    print(selectedSubCategory);
  }

  Future loadEServicesByCompany(String categoryId) async {
    try {
      isLoading.value = true;
      isDone.value = false;
      salons.clear();
      page.value++;
      List<Salon> _salons = [];
      _salons = await _eServiceRepository.searchSalons(
        '',
        [categoryId],
        low_price: priceRange.value.start.toInt() * 1000,
        max_price: priceRange.value.end.toInt() * 1000,
        review_rate: 0,
        customer_address: false,
      );
      if (_salons.isNotEmpty) {
        salons.addAll(_salons);
        category.refresh();
        eServices.refresh();
      } else {
        isDone.value = true;
      }
    } catch (e) {
      isDone.value = true;
      Get.showSnackbar(Ui.ErrorSnackBar(message: "${e}"));
    } finally {
      isLoading.value = false;
    }
  }

  Future loadEServicesOfCategory(String categoryId,
      {CategoryFilter? filter}) async {
    try {
      isLoading.value = true;
      isDone.value = false;
      eServices.clear();
      page.value++;
      List<EService> _eServices = [];
      switch (filter) {
        case CategoryFilter.ALL:
          _eServices = await _eServiceRepository.searchServices(
            '',
            [categoryId],
            low_price: priceRange.value.start.toInt() * 1000,
            max_price: priceRange.value.end.toInt() * 1000,
            review_rate: 0,
            customer_address: false,
          );

          break;
        case CategoryFilter.FEATURED:
          _eServices = await _eServiceRepository.getFeatured(categoryId,
              page: page.value);

          break;
        case CategoryFilter.POPULAR:
          _eServices = await _eServiceRepository.getPopular(categoryId,
              page: page.value);
          break;
        case CategoryFilter.RATING:
          _eServices = await _eServiceRepository.getMostRated(categoryId,
              page: page.value);
          break;
        case CategoryFilter.AVAILABILITY:
          _eServices = await _eServiceRepository.getAvailable(categoryId,
              page: page.value);
          break;
        default:
          _eServices = await _eServiceRepository
              .getAllWithPagination(categoryId, page: page.value);
      }
      if (_eServices.isNotEmpty) {
        eServices.addAll(_eServices);
        category.refresh();
        eServices.refresh();
      } else {
        isDone.value = true;
      }
    } catch (e) {
      isDone.value = true;
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    } finally {
      isLoading.value = false;
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

      if (salon != null) {
        Get.lazyPut(() => SalonController());
        final SalonController salonController = Get.find<SalonController>();
        salonController.salon.value = salon;
        salonController.salon.value.isFavorite = true;
        salonController.salon.refresh();
        salons.firstWhere((element) => element.id == salon.id).isFavorite =
            true;
        salons.refresh();
      } else {
        Get.lazyPut(() => EServiceController());
        final EServiceController serviceController =
            Get.find<EServiceController>();
        serviceController.eService.value = service!;
        serviceController.eService.update((val) {
          val?.isFavorite = true;
        });
        serviceController.eService.refresh();
        eServices.firstWhere((element) => element.id == service.id).isFavorite =
            true;
        eServices.refresh();
      }

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

      if (salon != null) {
        Get.lazyPut(() => SalonController());
        final SalonController salonController = Get.find<SalonController>();
        salonController.salon.value = salon;
        salonController.salon.value.isFavorite = true;
        salonController.salon.refresh();
        salons.firstWhere((element) => element.id == salon.id).isFavorite =
            false;
        salons.refresh();
      } else {
        Get.lazyPut(() => EServiceController());
        final EServiceController serviceController =
            Get.find<EServiceController>();
        serviceController.eService.value = service!;
        serviceController.eService.update((val) {
          val?.isFavorite = false;
        });
        serviceController.eService.refresh();
        eServices.firstWhere((element) => element.id == service.id).isFavorite =
            false;
        eServices.refresh();
      }

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
