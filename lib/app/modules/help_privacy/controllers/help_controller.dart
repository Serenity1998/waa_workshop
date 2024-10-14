import 'package:get/get.dart';
import '../../../../common/ui.dart';
import '../../../models/faq_category_model.dart';
import '../../../models/faq_model.dart';
import '../../../models/message_model.dart';
import '../../../models/user_model.dart';
import '../../../repositories/faq_repository.dart';
import '../../../repositories/salon_repository.dart';
import '../../../routes/app_routes.dart';

class HelpController extends GetxController {
  late FaqRepository _faqRepository;
  final faqCategories = <FaqCategory>[].obs;
  late SalonRepository _salonRepository;
  final faqs = <Faq>[].obs;
  RxInt selectedIndex = 0.obs;
  RxString selectedFaq = "-1".obs;
  List<String> contact = [
    "Харилцагчийн төв",
    "Website",
    "Facebook",
    "Instagram",
    "Twitter",
  ];
  List<String> link = [
    "https://customer.com",
    "https://savetime.mn",
    "https://facebook.com/savetimeworld",
    "https://instagram.com/savetimeworld?igshid=YmMyMTA2M2Y=",
    "https://google.com"
  ];
  List<String> contactIcon = [
    "ic_earphone",
    "ic_website",
    "ic_facebook",
    "ic_insta",
    "ic_twitter",
  ];
  HelpController() {
    _faqRepository = new FaqRepository();
    _salonRepository = new SalonRepository();
  }

  @override
  Future<void> onInit() async {
    await refreshFaqs();
    super.onInit();
  }

  Future refreshFaqs({bool? showMessage, String? categoryId}) async {
    getFaqCategories().then((value) async {
      await getFaqs(categoryId: categoryId);
    });
    if (showMessage == true) {
      Get.showSnackbar(Ui.SuccessSnackBar(
          message: "List of faqs refreshed successfully".tr));
    }
  }

  Future getFaqs({String? categoryId}) async {
    try {
      if (categoryId == null) {
        faqs.assignAll(
            await _faqRepository.getFaqs(faqCategories.elementAt(0).id!));
      } else {
        faqs.assignAll(await _faqRepository.getFaqs(categoryId));
      }
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }

  Future getFaqCategories() async {
    try {
      faqCategories.assignAll(await _faqRepository.getFaqCategories());
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }

  Future<void> startChat() async {
    final salon = await _salonRepository.get('220');
    List<User> _employees = salon.employees!.map((e) {
      e.avatar = salon.images?[0];
      return e;
    }).toList();
    Message _message = new Message(_employees, name: salon.name);
    Get.toNamed(Routes.CHAT, arguments: _message);
  }
}
