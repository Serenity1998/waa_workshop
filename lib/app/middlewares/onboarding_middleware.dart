import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes/app_routes.dart';
import '../services/auth_service.dart';

class OnboardingMiddleWare extends GetMiddleware {
  @override
  RouteSettings? onBoardRedirect(String route) {
    final authService = Get.find<AuthService>();

    if (!authService.isFirst) {
      return RouteSettings(name: Routes.ON_BOARD);
    }

    return null;
  }
}
