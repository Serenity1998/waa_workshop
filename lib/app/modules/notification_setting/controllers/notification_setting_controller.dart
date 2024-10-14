import 'package:get/state_manager.dart';

class NotificationSettingController extends GetxController {
  RxList<String> settings = [
    "Ерөнхий мэдэгдэл",
    "Дуу",
    "Чичиргээ",
    "Урамшуулал ба хөнгөлөлт",
    "Төлбөр",
    "Буцааж авалт",
    "Апп шинэчлэлтүүд"
  ].obs;
}
