import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  var currentPageNotifier = 0.obs;
  PageController pageController =
      PageController(viewportFraction: 1, keepPage: true);
}
