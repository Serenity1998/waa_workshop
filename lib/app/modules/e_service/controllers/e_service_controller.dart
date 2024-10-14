/*
 * File name: e_service_controller.dart
 * Last modified: 2022.02.11 at 18:41:33
 * Author: SmarterVision - https://codecanyon.net/user/smartervision
 * Copyright (c) 2022
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/ui.dart';
import '../../../models/booking_model.dart';
import '../../../models/e_service_model.dart';
import '../../../models/favorite_model.dart';
import '../../../models/message_model.dart';
import '../../../models/option_group_model.dart';
import '../../../models/option_model.dart';
import '../../../models/user_model.dart';
import '../../../repositories/e_service_repository.dart';
import '../../../routes/app_routes.dart';
import '../../../services/auth_service.dart';
import '../../favorites/controllers/favorites_controller.dart';

class EServiceController extends GetxController {
  final eService = EService().obs;
  final booking = Booking(eServices: [], options: [], quantity: 1).obs;
  final optionGroups = <OptionGroup>[].obs;
  final currentSlide = 0.obs;
  final heroTag = ''.obs;
  late EServiceRepository _eServiceRepository;

  EServiceController() {
    _eServiceRepository = EServiceRepository();
  }

  @override
  void onInit() async {
    var arguments = Get.arguments as Map<String, dynamic>;
    eService.value = arguments['eService'] as EService;
    heroTag.value = arguments['heroTag'] as String;
    await refreshEService();
    super.onInit();
  }

  Future refreshEService({bool showMessage = false}) async {
    await getEService();
    await getOptionGroups();
    await initBooking();
    if (showMessage) {
      Get.showSnackbar(Ui.SuccessSnackBar(
          message: "${eService.value.name}" +
              " " +
              "page refreshed successfully".tr));
    }
  }

  Future getEService() async {
    try {
      eService.value = await _eServiceRepository.get(eService.value.id!);
      booking.value.salon = eService.value.salon;
      booking.value.eServices = [eService.value];
    } catch (e) {
      print(e.toString());
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }

  Future initBooking() async {
    try {
      booking.update((val) {
        val?.salon = eService.value.salon;
        val?.eServices = [eService.value];
      });
    } catch (e) {
      print(e.toString());
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }

  Future getOptionGroups() async {
    try {
      var _optionGroups =
          await _eServiceRepository.getOptionGroups(eService.value.id!);
      optionGroups.assignAll(_optionGroups.map((element) {
        element.options!
            .removeWhere((option) => option.eServiceId != eService.value.id);
        return element;
      }));
    } catch (e) {
      print(e.toString());
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }

  Future addToFavorite(EService service) async {
    try {
      Favorite _favorite = new Favorite(
        eService: service,
        userId: Get.find<AuthService>().user.value.id,
        options: booking.value.options,
      );
      await _eServiceRepository.addFavorite(_favorite);
      eService.value = service;
      eService.update((val) {
        val?.isFavorite = true;
      });

      if (Get.isRegistered<FavoritesController>()) {
        Get.find<FavoritesController>().refreshFavorites();
      }

      Get.showSnackbar(Ui.SuccessSnackBar(
          message: "${service.name}" + " Added to favorite list".tr));
    } catch (e) {
      print(e.toString());
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }

  Future removeFromFavorite(EService service) async {
    try {
      Favorite _favorite = new Favorite(
        eService: service,
        userId: Get.find<AuthService>().user.value.id,
        options: booking.value.options,
      );
      await _eServiceRepository.removeFavorite(_favorite);

      eService.value = service;
      eService.update((val) {
        val?.isFavorite = false;
      });

      if (Get.isRegistered<FavoritesController>()) {
        Get.find<FavoritesController>().refreshFavorites();
      }
      Get.showSnackbar(Ui.SuccessSnackBar(
          message: "${service.name}" + " Removed from favorite list".tr));
    } catch (e) {
      print(e.toString());
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }

  void selectOption(OptionGroup optionGroup, Option option, EService eService) {
    if (eService.enableBooking != null && eService.enableBooking!) {
      booking.update((val) {
        if (val!.options!.contains(option)) {
          val.options!.remove(option);
        } else {
          if (!optionGroup.allowMultiple!) {
            val.options?.removeWhere(
                (element) => element.optionGroupId == optionGroup.id);
          }
          val.options?.add(option);
        }
        if (!val.eServices!.contains(eService)) {
          val.eServices?.add(eService);
        }
      });
    } else {
      Get.showSnackbar(Ui.notificationSnackBar(
          title: "Alert", message: "Service not enabled for booking".tr));
    }
  }

  bool isCheckedOption(Option option) {
    return booking.value.options!.contains(option);
  }

  TextStyle getTitleTheme(Option option) {
    if (isCheckedOption(option)) {
      return Get.textTheme.bodyMedium!
          .merge(TextStyle(color: Get.theme.colorScheme.secondary));
    }
    return Get.textTheme.bodyMedium!;
  }

  TextStyle getSubTitleTheme(Option option) {
    if (isCheckedOption(option)) {
      return Get.textTheme.bodySmall!
          .merge(TextStyle(color: Get.theme.colorScheme.secondary));
    }
    return Get.textTheme.bodySmall!;
  }

  Color? getColor(Option option) {
    if (isCheckedOption(option)) {
      return Get.theme.colorScheme.secondary.withOpacity(0.1);
    }
    return null;
  }

  void startChat() {
    List<User> _employees = eService.value.salon!.employees!.map((e) {
      e.avatar = eService.value.salon?.images![0];
      return e;
    }).toList();
    Message _message =
        new Message(_employees, name: eService.value.salon?.name);
    Get.toNamed(Routes.CHAT, arguments: _message);
  }
}
