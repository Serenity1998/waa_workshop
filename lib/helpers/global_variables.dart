import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
// import 'package:get_storage/get_storage.dart';

class GlobalVariables {
  static bool loginError = false;
  static String platformName = "";
  static String deviceName = "";


  static String deviceIp = "";
  static String serialNo = "";

  static double gWidth = Get.width;
  static double gHeight = Get.height;
  static GetStorage gStorage = GetStorage();
  static String deviceToken = "";
  static bool saveLogin = false;
  static bool bioAuthenticate = false;
  static bool authBool = false;

  /// user information data start
  static int id = 0;
  static String name = '';
  static RxString email = ''.obs;
  static List salons = [];
  static String phoneNumber = '';
  static String phoneVerify = '';
  static String emailVerify = '';
  static dynamic customField;
  static bool hasMedia = false;
  static List roles = [];
  static List media = [];
}
