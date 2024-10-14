/*
 * File name: booking_controller.dart
 * Last modified: 2022.02.26 at 14:50:11
 * Author: SmarterVision - https://codecanyon.net/user/smartervision
 * Copyright (c) 2022
 */

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../common/helper.dart';
import '../../../../common/ui.dart';
import '../../../models/address_model.dart';
import '../../../models/booking_model.dart';
import '../../../models/booking_status_model.dart';
import '../../../models/message_model.dart';
import '../../../models/user_model.dart';
import '../../../repositories/booking_repository.dart';
import '../../../repositories/salon_repository.dart';
import '../../../routes/app_routes.dart';
import '../../../services/auth_service.dart';
import '../../../services/global_service.dart';
import '../../../services/settings_service.dart';
import '../../auth/controllers/auth_controller.dart';
import 'bookings_controller.dart';

class BookingController extends GetxController {
  late SalonRepository _salonRepository;
  late BookingRepository _bookingRepository;
  final allMarkers = <Marker>[].obs;
  final bookingStatuses = <BookingStatus>[].obs;
  late Timer timer;
  Address get currentAddress => Get.find<SettingsService>().address.value;
  late GoogleMapController mapController;
  final booking = Booking().obs;
  final cameraPosition = new CameraPosition(target: LatLng(0, 0)).obs;
  final salonMarkers = <Marker>[].obs;
  late ScrollController scrollController;

  BookingController() {
    _bookingRepository = BookingRepository();
    _salonRepository = SalonRepository();
  }

  void initScrollController() {
    scrollController = ScrollController();
  }

  @override
  void onInit() async {
    booking.value = Get.arguments as Booking;
    super.onInit();
  }

  @override
  void onReady() async {
    if (Get.find<AuthService>().isAuth) await refreshBooking();
    super.onReady();
  }

  Future refreshBooking({bool showMessage = false}) async {
    await getBooking();
    if (showMessage) {
      Get.showSnackbar(Ui.SuccessSnackBar(
          message: "Booking page refreshed successfully".tr));
    }
  }

  Future<void> getBooking() async {
    if (Get.find<AuthService>().isAuth) {
      booking.value = await _bookingRepository.get(booking.value.id!);
      var marker = await Helper()
          .getSalonMarker(booking.value.salon!, booking.value.address!);
      salonMarkers.add(marker);
    }
  }

  Future<void> onTheWayBookingService() async {
    // final _status = Get.find<BookingsController>()
    //     .getStatusByOrder(Get.find<GlobalService>().global.value.onTheWay);
    // await changeBookingStatus(_status);
  }

  Future<void> readyBookingService() async {
    // final _status = Get.find<BookingsController>()
    //     .getStatusByOrder(Get.find<GlobalService>().global.value.ready);
    // await changeBookingStatus(_status);
  }

  Future<void> startBookingService() async {
    // try {
    //   final _status = Get.find<BookingsController>().getStatusByOrder(Get.find<GlobalService>().global.value.inProgress);
    //   final _booking = new Booking(id: booking.value.id, startAt: DateTime.now(), status: _status);
    //   await _bookingRepository.update(_booking);
    //   booking.update((val) {
    //     val.startAt = _booking.startAt;
    //     val.status = _status;
    //   });
    //   timer = Timer.periodic(Duration(minutes: 1), (t) {
    //     booking.update((val) {
    //       val.duration += (1 / 60);
    //     });
    //   });
    // } catch (e) {
    //   Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    // }
  }

  Future<void> finishBookingService() async {
    // try {
    //   final _status = Get.find<BookingsController>()
    //       .getStatusByOrder(Get.find<GlobalService>().global.value.done);
    //   var _booking = new Booking(
    //       id: booking.value.id, endsAt: DateTime.now(), status: _status);
    //   final result = await _bookingRepository.update(_booking);
    //   booking.update((val) {
    //     val.endsAt = result.endsAt;
    //     val.duration = result.duration;
    //     val.status = _status;
    //   });
    //   timer?.cancel();
    // } catch (e) {
    //   Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    // }
  }

  Future<void> cancelBookingService() async {
    try {
      if (booking.value.status!.order! <
          Get.find<GlobalService>().global.value.done!) {
        final _status = Get.find<BookingsController>()
            .getStatusByOrder(Get.find<GlobalService>().global.value.failed!);
        final _booking =
            new Booking(id: booking.value.id, cancel: true, status: _status);

        await _bookingRepository.update(_booking);
        booking.update((val) {
          val?.cancel = true;
          val?.status = _status;
        });
      }
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }

  String getTime({String separator = ":"}) {
    String hours = "";
    String minutes = "";
    int minutesInt =
        ((booking.value.duration! - booking.value.duration!.toInt()) * 60)
            .toInt();
    int hoursInt = booking.value.duration!.toInt();
    if (hoursInt < 10) {
      hours = "0" + hoursInt.toString();
    } else {
      hours = hoursInt.toString();
    }
    if (minutesInt < 10) {
      minutes = "0" + minutesInt.toString();
    } else {
      minutes = minutesInt.toString();
    }
    return hours + separator + minutes;
  }

  int servicesDuration() {
    int duration = 0;
    booking.value.eServices?.forEach((element) {
      try {
        var time = TimeOfDay(
            hour: int.parse(element.duration!.split(":")[0]),
            minute: int.parse(element.duration!.split(":")[1]));
        duration += time.hour * 60 + time.minute;
      } catch (e) {
        debugPrint("no duration");
      }
    });

    return duration;
  }

  String getServiceNames() {
    String names = "";
    booking.value.eServices?.forEach((element) {
      names = names.length == 0 ? "${element.name}" : "$names\n${element.name}";
    });
    return names;
  }

  Future<void> startChat() async {
    List<User> _employees =
        await _salonRepository.getEmployees(booking.value.salon!.id!);
    _employees = _employees
        .map((e) {
          e.avatar = booking.value.salon?.images?[0];
          return e;
        })
        .toSet()
        .toList();
    Message _message =
        new Message(_employees, name: "${booking.value.salon?.name}");
    Get.toNamed(Routes.CHAT, arguments: _message);
  }

  Future<void> changeBookingStatus(BookingStatus bookingStatus) async {
    try {
      final _booking = new Booking(id: booking.value.id, status: bookingStatus);
      await _bookingRepository.update(_booking);
      booking.update((val) {
        val?.status = bookingStatus;
      });
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }
}
