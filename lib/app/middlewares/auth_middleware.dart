import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../routes/app_routes.dart';
import '../services/auth_service.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? authRedirect(String route) {
    final authService = Get.find<AuthService>();

    debugPrint("Auth:::: ${authService.isFirst}");
    // if (!authService.isFirst) {
    //   return RouteSettings(name: Routes.ON_BOARD);
    // }
    if (!authService.isAuth) {
      return RouteSettings(name: Routes.LOGIN);
    }
    return null;
  }
}
