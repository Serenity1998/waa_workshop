import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class PrivacySecurityController extends GetxController {
  RxList<String> settings = [
    "Сануулах",
    "Face ID",
  ].obs;
}
