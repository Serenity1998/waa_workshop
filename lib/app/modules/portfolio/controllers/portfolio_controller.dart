import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/user_model.dart';
import '../../../repositories/portfolio_repository.dart';

class PortfolioController extends GetxController {
  late PortfolioRepository _repository;
  List<Tab> tabs = [
    Tab(
      text: "Миний CV/Portfolio",
    ),
    Tab(
      text: " Илгээсэн хүсэлт",
    )
  ];

  List<Tab> career_language_tabs = [
    Tab(
      text: "Мэргэжил",
    ),
    Tab(
      text: "Гадаад хэл",
    )
  ];

  List<Tab> skills_tabs = [
    Tab(
      text: "Hard Skill",
    ),
    Tab(
      text: "Soft Skill",
    )
  ];
  var user = new User().obs;
  final portfolio = [].obs;
  late GlobalKey<FormState> introductionForm;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void saveIntroductionForm() async {}

  Future getPortfolioEducation() async {
    try {
      await _repository.getEducationList();
    } catch (e) {
      print(e);
    }
  }
}
