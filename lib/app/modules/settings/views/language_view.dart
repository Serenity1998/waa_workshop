/*
 * File name: language_view.dart
 * Last modified: 2022.08.16 at 12:12:50
 * Author: SmarterVision - https://codecanyon.net/user/smartervision
 * Copyright (c) 2022
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../providers/laravel_provider.dart';
import '../../../services/translation_service.dart';
import '../../global_widgets/main_appbar.dart';
import '../controllers/language_controller.dart';
import '../widgets/languages_loader_widget.dart';

class LanguageView extends GetView<LanguageController> {
  final bool hideAppBar;

  LanguageView({this.hideAppBar = false});

  @override
  Widget build(BuildContext context) {
    print(Get.find<TranslationService>().getLocale());
    return Scaffold(
        appBar: MainAppBar(title: "Languages".tr),
        body: ListView(
          primary: true,
          children: [
            Obx(() {
              if (Get.find<LaravelApiClient>()
                  .isLoading(task: 'getTranslations')) {
                return LanguagesLoaderWidget();
              }
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: TranslationService.languages.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        print(Get.find<TranslationService>().getLocale());
                        print(
                            "TranslationService.languages[index] ${TranslationService.languages[index]}");
                        controller
                            .updateLocale(TranslationService.languages[index]);
                      },
                      child: Container(
                        height: 60,
                        margin: EdgeInsets.symmetric(horizontal: 24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(TranslationService.languages[index].tr,
                                style: Get.textTheme.bodyMedium!
                                    .merge(TextStyle(fontSize: 16))),
                            Icon(
                              TranslationService.languages[index] ==
                                      Get.find<TranslationService>()
                                          .getLocale()
                                          .toString()
                                  ? Icons.radio_button_checked
                                  : Icons.radio_button_unchecked,
                              color: Get.theme.focusColor,
                            ),
                          ],
                        ),
                      ),
                    );
                  });
              //  Container(
              //   padding: EdgeInsets.symmetric(vertical: 5),
              //   margin: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
              //   // decoration: Ui.getBoxDecoration(),
              //   child: Column(
              //     children: List.generate(TranslationService.languages.length,
              //         (index) {
              //       var _lang = TranslationService.languages.elementAt(index);
              //       return RadioListTile(
              //         value: _lang,
              //         groupValue: Get.locale.toString(),
              //         activeColor: Get.theme.colorScheme.secondary,
              //         onChanged: (value) {
              //           controller.updateLocale(value);
              //         },
              //         title: Text(_lang.tr, style: Get.textTheme.bodyMedium),
              //       );
              //     }).toList(),
              //   ),
              // );
            })
          ],
        ));
  }
}
