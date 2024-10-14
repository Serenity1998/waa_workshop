import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/empty_view.dart';
import '../../../models/e_service_model.dart';
import '../../../models/salon_model.dart';
import '../../category/widgets/companies_list_item_widget.dart';
import '../../category/widgets/services_list_item_widget.dart';
import '../controllers/search_controller.dart';

class SearchListWidget extends StatelessWidget {
  SearchListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final controller = Get.find<SearchControllerCustom>();
      if (controller.eServices.isEmpty) {
        return EmptyView();
      } else {
        return Column(
          children: [
            Obx(() {
              List<String> categoriesName = controller.selectedCategoriesName;

              return Container(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text:
                              '"${(controller.textEditingController.text.isNotEmpty) ? controller.textEditingController.text : categoriesName.join(' ')}" ',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Get.theme.focusColor),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'хайлтын үр дүн',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Get.theme.hintColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      '${controller.eServices.length} олдсон',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Get.theme.focusColor,
                      ),
                    )
                  ],
                ),
              );
            }),
            ListView.builder(
              padding: EdgeInsets.only(bottom: 10, top: 10),
              primary: false,
              shrinkWrap: true,
              itemCount: controller.eServices.length,
              itemBuilder: ((_, index) {
                EService item = controller.eServices.elementAt(index);
                Salon? salon;

                if (!Get.find<SearchControllerCustom>().isService.value) {
                  Map<String, dynamic> value = item.toJson();
                  salon = Salon.fromJson(value);
                }

                return Get.find<SearchControllerCustom>().isService.value
                    ? ServicesListItemWidget(service: item)
                    : CompaniesListItemWidget(salon: salon);
              }),
            ),
          ],
        );
      }
    });
  }
}
