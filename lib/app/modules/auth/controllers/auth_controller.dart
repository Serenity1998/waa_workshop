import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import '../../../../common/ui.dart';
import '../../../models/user_model.dart';
import '../../../repositories/user_repository.dart';
import '../../../routes/app_routes.dart';
import '../../../services/auth_service.dart';
import '../../../services/firebase_messaging_service.dart';
import '../../root/controllers/root_controller.dart';

class AuthController extends GetxController {
  final Rx<User> currentUser = Get.find<AuthService>().user;
  late GlobalKey<FormState> loginFormKey;
  late GlobalKey<FormState> registerFormKey;
  late GlobalKey<FormState> forgotPasswordFormKey;
  final hidePassword = true.obs;
  final loading = false.obs;
  final smsSent = ''.obs;
  late UserRepository _userRepository;
  RxInt passResetIndex = 0.obs;
  RxInt remainingSeconds = 60.obs;
  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();
  RxBool saveInfo = true.obs;
  final storage = const FlutterSecureStorage();
  Timer timer = Timer(const Duration(seconds: 0), () {});

  AuthController() {
    _userRepository = UserRepository();
  }

  @override
  void onInit() {
    super.onInit();
    getSavedUser();
  }

  Future<Map<String, String>> getSavedUser() async {
    userName.text = await storage.read(key: 'key_username') ?? "";
    password.text = await storage.read(key: 'key_password') ?? "";
    return {"username": userName.text, "password": password.text};
  }

  void login() async {
    Get.focusScope?.unfocus();
    if (loginFormKey.currentState!.validate()) {
      loginFormKey.currentState?.save();
      loading.value = true;
      try {
        await Get.find<FireBaseMessagingService>().setDeviceToken();
        String email = currentUser.value.email.toString();
        String password = currentUser.value.password.toString();
        String? userUid =
            await _userRepository.signInWithEmailAndPassword(email, password);
        if (userUid != null) {
          currentUser.value = await _userRepository.login(currentUser.value);
        }
        await Get.toNamed(Routes.ROOT);
        loading.value = false;
      } catch (e) {
        Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
      } finally {
        loading.value = false;
      }
    }
  }

  void setSaveInfo(bool value) async {
    saveInfo.value = value;
  }

  Future<void> saveLoginInfo(String email, String password) async {
    await storage.write(key: 'key_username', value: email);
    await storage.write(key: 'key_password', value: password);
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      remainingSeconds.value -= 1;
      if (remainingSeconds.value < 0) {
        remainingSeconds.value = 0;
        timer.cancel();
      }
    });
  }

  void register() async {
    Get.focusScope?.unfocus();
    if (registerFormKey.currentState!.validate()) {
      registerFormKey.currentState?.save();
      loading.value = true;
      try {
        await Get.find<FireBaseMessagingService>().setDeviceToken();
        String email = currentUser.value.email.toString();
        String password = currentUser.value.password.toString();
        String? userUid =
            await _userRepository.signUpWithEmailAndPassword(email, password);
        currentUser.value.uid = userUid;
        currentUser.value = await _userRepository.register(currentUser.value);
        if (saveInfo.value) await saveLoginInfo(email, password);
        loading.value = false;
        await Get.toNamed(Routes.ROOT);
      } catch (e) {
        Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
      } finally {
        loading.value = false;
      }
    }
  }

  Future<void> verifyPhone() async {
    try {
      loading.value = true;
      await _userRepository.verifyPhone(smsSent.value);
      await Get.find<FireBaseMessagingService>().setDeviceToken();
      currentUser.value = await _userRepository.register(currentUser.value);
      await _userRepository.signUpWithEmailAndPassword(
          currentUser.value.email!, currentUser.value.apiToken!);
      await Get.find<RootController>().changePage(0);
    } catch (e) {
      Get.back();
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    } finally {
      loading.value = false;
    }
  }

  Future<void> resendOTPCode() async {
    await _userRepository.sendCodeToPhone();
  }

  Future<void> sendResetLink() async {
    Get.focusScope?.unfocus();
    try {
      if (passResetIndex == 0) {
        loading.value = false;
      } else {
        // startTimer();
        await _userRepository.sendResetLinkEmail(currentUser.value);
        loading.value = false;
      }
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    } finally {
      loading.value = false;
    }
  }
}
