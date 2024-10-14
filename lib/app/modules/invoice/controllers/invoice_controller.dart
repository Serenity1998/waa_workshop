import 'package:get/get.dart';

class InvoiceController extends GetxController {
  RxList<String> images = ["qpay", "monpay", "socialpay"].obs;
  RxList<String> name = [
    "“Ажилчин зөгий” ХХК",
    "Сайн сонсогч Б.Даваахүү",
    "Хуульч Б.Билгүүн"
  ].obs;
}
