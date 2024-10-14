/*
 * File name: checkout_controller.dart
 * Last modified: 2022.02.14 at 12:11:45
 * Author: SmarterVision - https://codecanyon.net/user/smartervision
 * Copyright (c) 2022
 */

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../common/helper.dart';
import '../../../../common/ui.dart';
import '../../../models/booking_model.dart';
import '../../../models/payment_method_model.dart';
import '../../../models/payment_model.dart';
import '../../../models/wallet_model.dart';
import '../../../repositories/booking_repository.dart';
import '../../../repositories/payment_repository.dart';
import '../../../routes/app_routes.dart';
import '../../bookings/controllers/bookings_controller.dart';
import '../../global_widgets/tab_bar_widget.dart';
import '../../root/controllers/root_controller.dart';

class CheckoutController extends GetxController {
  late PaymentRepository _paymentRepository;
  late BookingRepository _bookingRepository;
  final paymentsList = <PaymentMethod>[].obs;
  final walletList = <Wallet>[];
  final isLoading = true.obs;
  final booking = Booking().obs;
  Rx<PaymentMethod> selectedPaymentMethod = PaymentMethod().obs;

  CheckoutController() {
    _paymentRepository = PaymentRepository();
    _bookingRepository = BookingRepository();
  }

  @override
  void onInit() async {
    // booking.value = Get.arguments as Booking;
    super.onInit();
  }

  void fetchData() async {
    print("---BOOKING---");
    print(booking.value);
    // await loadPaymentMethodsList();
    // await loadWalletList();
    // selectedPaymentMethod.value =
    //     this.paymentsList.firstWhere((element) => element.isDefault!);
  }

  Future loadPaymentMethodsList() async {
    try {
      paymentsList.assignAll(await _paymentRepository.getMethods());
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }

  Future loadWalletList() async {
    try {
      var _walletIndex = paymentsList.indexWhere(
          (element) => element.route?.toLowerCase() == Routes.WALLET);
      if (_walletIndex > -1) {
        // wallet payment method enabled
        // remove existing wallet method
        var _walletPaymentMethod = paymentsList.removeAt(_walletIndex);
        walletList.assignAll(await _paymentRepository.getWallets());
        // and replace it with new payment method object
        _insertWalletsPaymentMethod(_walletIndex, _walletPaymentMethod);
        paymentsList.refresh();
      }
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    } finally {
      isLoading.value = false;
    }
  }

  void selectPaymentMethod(PaymentMethod paymentMethod) {
    selectedPaymentMethod.value = paymentMethod;
  }

  Future<void> createBooking(Booking _booking, BuildContext context) async {
    try {
      _booking.payment = null;
      await _bookingRepository.add(_booking);
      Helper.basicAlert(
        context,
        "Payment Successful".tr,
        "Захиалга баталгаажуулхаар холбогдоно".tr,
        img: 'assets/icon/splash_save.png',
        onOkText: "My Bookings",
        onPressed: () => Get.find<RootController>().changePage(1),
      );
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }

  Future<void> payBooking(Booking _booking, BuildContext context) async {
    try {
      _booking.payment =
          new Payment(paymentMethod: selectedPaymentMethod.value);
      if (selectedPaymentMethod.value.route != null) {
        Helper.basicAlert(
          context,
          "Payment Successful".tr,
          "Your payment is pending confirmation from the Service Provider".tr,
          img: 'assets/icon/splash_save.png',
          onOkText: "My Bookings",
          onPressed: () => Get.find<RootController>().changePage(1),
        );
      }
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }

  TextStyle getTitleTheme(PaymentMethod paymentMethod) {
    if (paymentMethod == selectedPaymentMethod.value) {
      return Get.textTheme.bodyMedium!
          .merge(TextStyle(color: Get.theme.focusColor));
    } else if (paymentMethod.wallet != null &&
        paymentMethod.wallet!.balance! < booking.value.getTotal()) {
      return Get.textTheme.bodyMedium!
          .merge(TextStyle(color: Get.theme.focusColor));
    }
    return Get.textTheme.bodyMedium!;
  }

  TextStyle getSubTitleTheme(PaymentMethod paymentMethod) {
    if (paymentMethod == selectedPaymentMethod.value) {
      return Get.textTheme.bodySmall!
          .merge(TextStyle(color: Get.theme.focusColor));
    }
    return Get.textTheme.bodySmall!;
  }

  Color? getColor(PaymentMethod paymentMethod) {
    if (paymentMethod == selectedPaymentMethod.value) {
      return Get.theme.colorScheme.secondary;
    }
    return null;
  }

  void _insertWalletsPaymentMethod(
      int _walletIndex, PaymentMethod _walletPaymentMethod) {
    walletList.forEach((_walletElement) {
      paymentsList.insert(
          _walletIndex,
          new PaymentMethod(
            isDefault: _walletPaymentMethod.isDefault,
            id: _walletPaymentMethod.id,
            name: _walletElement.getName(),
            description: _walletElement.balance.toString(),
            logo: _walletPaymentMethod.logo,
            route: _walletPaymentMethod.route,
            wallet: _walletElement,
          ));
    });
  }
}
