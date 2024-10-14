import 'package:get/get.dart';

import '../providers/laravel_provider.dart';

class PortfolioRepository {
  late LaravelApiClient _laravelApiClient;
  PortfolioRepository() {}

  Future getEducationList() {
    _laravelApiClient = Get.find<LaravelApiClient>();
    return _laravelApiClient.getPortfolioEducations();
  }
}
