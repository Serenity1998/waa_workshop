import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/helper.dart';
import '../../../../common/ui.dart';
import '../../../models/booking_model.dart';
import '../../../models/booking_status_model.dart';
import '../../../repositories/booking_repository.dart';
import '../../../services/global_service.dart';
import '../../auth/controllers/auth_controller.dart';

class BookingsController extends GetxController {
  late BookingRepository _bookingsRepository;

  final bookings = <Booking>[].obs;
  final bookingSorted = <Map<String, dynamic>>[].obs;
  final bookingStatuses = <BookingStatus>[].obs;
  RxInt bookingStatusesLength = 0.obs;
  final page = 0.obs;
  final firstLevelPage = 0.obs;
  final isLoading = true.obs;
  final isDone = false.obs;
  RxInt currentStatus = 1.obs;
  List<Tab> tabs = [];
  List<Tab> firstLeveltabs = [
    const Tab(text: "Шууд захиалга"),
    const Tab(text: "Цаг захиалга")
  ];
  List<Widget> widgets = [];

  late ScrollController scrollController;
  final PageController pageController = PageController();
  BookingsController() {
    _bookingsRepository = new BookingRepository();
  }

  @override
  Future<void> onInit() async {
    Get.lazyPut(() => AuthController());
    firstLevelPage.value = 0;
    await getBookingStatuses();
    refreshBookings(statusId: 1);
    changeTab(0);
    super.onInit();
  }

  Future refreshBookings({bool showMessage = false, int? statusId}) async {
    changeTab(statusId);
    if (showMessage) {
      await getBookingStatuses();
      Get.showSnackbar(Ui.SuccessSnackBar(
          message: "Bookings page refreshed successfully".tr));
    }
  }

  void initScrollController() {
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !isDone.value) {
        loadBookingsOfStatus(statusId: currentStatus.value);
      }
    });
  }

  void changeFirstLevelTab(int value) async {
    firstLevelPage.value = value;
    if (value == 1) changeTab(0);
  }

  void changeTab(dynamic statusId) async {
    bookings.clear();
    currentStatus.value = statusId ?? currentStatus.value;
    page.value = 0;
    await loadBookingsOfStatus(statusId: currentStatus.value);
  }

  BookingStatus getCurrentStatus() {
    return bookingStatuses
        .firstWhere((element) => element.id == currentStatus.value);
  }

  Future getBookingStatuses() async {
    try {
      bookingStatuses.assignAll(await _bookingsRepository.getStatuses());
      tabs.clear();
      for (var item in bookingStatuses) {
        tabs.add(Tab(
          text: item.status,
        ));
      }
      bookingStatusesLength.value = tabs.length;
      // bookingStatuses.insert(
      //     0, BookingStatus(id: "0", status: "Бүгд", order: 0));
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }

  BookingStatus getStatusByOrder(int order) {
    return bookingStatuses.firstWhere((s) => s.order == order, orElse: () {
      Get.showSnackbar(
          Ui.ErrorSnackBar(message: "Booking status not found".tr));
      return BookingStatus();
    });
  }

  Future loadBookingsOfStatus({required int statusId}) async {
    try {
      isLoading.value = true;
      isDone.value = false;
      page.value++;
      List<Booking> _bookings = [];
      if (bookingStatuses.isNotEmpty) {
        _bookings =
            await _bookingsRepository.all(statusId + 1, page: page.value);
      }
      if (_bookings.isNotEmpty) {
        bookings.addAll(_bookings);
        sortBookings();
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

  void sortBookings() {
    if (bookings.length == 0) {
      return;
    }
    bookingSorted.clear();
    bookings.forEach((element) {
      var at = Helper().MY_DATE_FORMAT.format(element.bookingAt!);
      try {
        bookingSorted.firstWhere((mapEl) {
          if (mapEl["data"] == at) {
            List<Booking> m = mapEl["bookings"];
            m.add(element);
            mapEl["bookings"] = m;
            return true;
          }
          return false;
        });
      } catch (e) {
        bookingSorted.add({
          "data": at,
          "bookings": [element]
        });
      }
    });
  }

  Future<void> cancelBookingService(Booking booking) async {
    try {
      if (booking.status!.order! <
          Get.find<GlobalService>().global.value.onTheWay!) {
        final _status =
            getStatusByOrder(Get.find<GlobalService>().global.value.failed!);
        final _booking =
            new Booking(id: booking.id, cancel: true, status: _status);
        await _bookingsRepository.update(_booking);
        bookings.removeWhere((element) => element.id == booking.id);
      }
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }
}
