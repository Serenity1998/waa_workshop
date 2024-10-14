import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class OnboardingControlleer extends GetxController {
  RxDouble pageNumber = 0.0.obs;
  PageController? controller;
}
