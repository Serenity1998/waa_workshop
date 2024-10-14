/*
 * File name: book_e_service_controller.dart
 * Last modified: 2022.02.23 at 11:42:19
 * Author: SmarterVision - https://codecanyon.net/user/smartervision
 * Copyright (c) 2022
 */

import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:save_time_customer/app/models/salon_user_model.dart';

import '../../../../common/ui.dart';
import '../../../models/address_model.dart';
import '../../../models/availability_hour_model.dart';
import '../../../models/booking_model.dart';
import '../../../models/coupon_model.dart';
import '../../../models/salon_model.dart';
import '../../../models/setting_model.dart';
import '../../../models/user_model.dart';
import '../../../repositories/booking_repository.dart';
import '../../../repositories/salon_repository.dart';
import '../../../repositories/setting_repository.dart';
import '../../../services/auth_service.dart';
import '../../../services/settings_service.dart';
import '../../global_widgets/tab_bar_widget.dart';

class BookEServiceController extends GetxController {
  RxString bookingTime = "available".obs;
  RxBool atSalon = true.obs;
  final booking = Booking().obs;
  final serviceId = "".obs;
  final salon = Salon().obs;
  final minuteRange = 30.obs;

  RxList next10Days = <DateTime>[].obs;
  final employees = <SalonUser>[].obs;
  final addresses = <Address>[].obs;
  final morningTimes = [].obs;
  final afternoonTimes = [].obs;
  final eveningTimes = [].obs;
  final nightTimes = [].obs;
  final allTimes = <DateTime>[].obs;
  RxBool isLoading = false.obs;
  late BookingRepository _bookingRepository;
  late SalonRepository _salonRepository;
  late SettingRepository _settingRepository;
  DatePickerController datePickerController = DatePickerController();
  final setting = Setting().obs;
  Address get currentAddress => Get.find<SettingsService>().address.value;
  RxInt serviceCount = 1.obs;
  RxString selectedId = "".obs;
  Rx<DateTime> selectedDate = DateTime.now().obs;

  BookEServiceController() {
    _bookingRepository = BookingRepository();
    _salonRepository = SalonRepository();
    _settingRepository = SettingRepository();
  }

  @override
  void onInit() async {
    var arguments = await Get.arguments as Map<String, dynamic>;
    salon.value = await arguments['salon'] as Salon;
    serviceId.value = await arguments['serviceId'] as String;
    minuteRange.value = (arguments['minuteRange'] as int?) ?? 30;
    final booking = (Get.arguments['booking'] as Booking);
    this.booking.value = Booking(
        eServices: booking.eServices,
        salon: booking.salon,
        taxes: booking.salon?.taxes,
        options: booking.options,
        quantity: booking.quantity,
        user: Get.find<AuthService>().user.value,
        coupon: Coupon(),
        bookingAt: DateTime.now());
    await generateNext10Days();
    await getEmployees();
    await getTimes(DateTime.now());
    super.onInit();
  }

  void summarizeBooking() async {
    print("---BOOKING SUMMARIZE---");
    print(booking);
  }

  void selectDate(DateTime date) async {
    selectedDate.value = date;
    await getTimes(date);
  }

  void selectBookingTime(DateTime time) async {
    booking.value.bookingAt = time;
    allTimes.refresh();
  }

  void toggleAtSalon(value) {
    atSalon.value = value;
  }

  TextStyle getTextTheme(bool selected) {
    if (selected) {
      return Get.textTheme.bodyMedium!
          .merge(TextStyle(color: Get.theme.focusColor));
    }
    return Get.textTheme.bodyMedium!;
  }

  Color getColor(bool selected) {
    if (selected) {
      return Get.theme.colorScheme.secondary;
    }
    return Colors.red;
  }

  Future getEmployees() async {
    try {
      if (salon.value.id == null) throw Exception("Salon id not found");
      employees
          .assignAll(await _salonRepository.getSalonEmployees(salon.value.id!));
      if (employees.isNotEmpty) {
        Get.log(employees[0].user?.id ?? "");
        selectedId.value = employees[0].user?.id ?? "";
      }
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }

  Future getAddresses() async {
    try {
      if (Get.find<AuthService>().isAuth) {
        addresses.assignAll(await _settingRepository.getAddresses());
        if (!currentAddress.isUnknown()) {
          addresses.remove(currentAddress);
          addresses.insert(0, currentAddress);
        }
        if (Get.isRegistered<TabBarController>(tag: 'addresses')) {
          Get.find<TabBarController>(tag: 'addresses').selectedId.value =
              addresses.elementAt(0).id.toString();
        }
      }
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }

  AvailabilityHour? isDayAvailable(DateTime date) {
    try {
      var weekDay = DateFormat('EEEE').format(date);
      var available =
          booking.value.salon?.availabilityHours?.firstWhere((element) {
        if (element.day == weekDay.toLowerCase()) {
          return true;
        }
        return false;
      });
      return available;
    } catch (e) {
      debugPrint("isDayAvailable: $e");
      return null;
    }
  }

  Future generateNext10Days() async {
    try {
      DateTime today = DateTime.now();
      for (int i = 0; i < 10; i++) {
        next10Days.add(today.add(Duration(days: i)));
      }
    } catch (e) {
      Get.log(e.toString());
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }

  Future getTimes(DateTime? date) async {
    try {
      allTimes.clear();
      List<dynamic> times = await _salonRepository.getAvailabilityHours(
        salon.value.id.toString(),
        date ?? DateTime.now(),
        serviceId.value,
      );
      if (times.isEmpty) return;

      List<DateTime> dates = times
          .where((time) => time[1] == true)
          .map((time) => DateTime.parse(time.elementAt(0)).toUtc())
          .where((time) {
        DateTime compareTo = DateTime.utc(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
            DateTime.now().hour,
            DateTime.now().minute);
        return time.isAfter(compareTo);
      }).toList();

      dates.sort((a, b) => a.compareTo(b));
      allTimes.addAll(dates);

      debugPrint("___${allTimes.length}_$dates");
    } catch (e) {
      Get.log(e.toString());
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }

  void validateCoupon() async {
    try {
      FocusManager.instance.primaryFocus?.unfocus();
      Coupon _coupon = await _bookingRepository.coupon(booking.value);
      booking.update((val) {
        val?.coupon = _coupon;
      });
      if (_coupon.hasData) {
        Get.showSnackbar(Ui.SuccessSnackBar(
            message: "Coupon code is applied".tr,
            snackPosition: SnackPosition.TOP));
      } else {
        Get.showSnackbar(Ui.ErrorSnackBar(
            message: "Invalid Coupon Code".tr,
            snackPosition: SnackPosition.TOP));
      }
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }

  void selectEmployee(User employee) async {
    booking.update((val) {
      val?.employee = employee;
    });
    // if (booking.value.bookingAt != null) {
    //   await getTimes(date: booking.value.bookingAt);
    // }
  }

  bool isCheckedEmployee(User user) {
    return (booking.value.employee?.id ?? '0') == user.id;
  }

  TextStyle getTitleTheme(User user) {
    if (isCheckedEmployee(user)) {
      return Get.textTheme.bodyMedium!.merge(TextStyle(
          color: Get.theme.colorScheme.secondary, overflow: TextOverflow.clip));
    }
    return Get.textTheme.bodyMedium!;
  }

  TextStyle getSubTitleTheme(User user) {
    if (isCheckedEmployee(user)) {
      return Get.textTheme.bodySmall!
          .merge(TextStyle(color: Get.theme.colorScheme.secondary));
    }
    return Get.textTheme.bodySmall!;
  }
}
