/*
 * File name: maps_carousel_widget.dart
 * Last modified: 2022.02.26 at 14:50:11
 * Author: SmarterVision - https://codecanyon.net/user/smartervision
 * Copyright (c) 2022
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/e_service_model.dart';
import '../../category/widgets/companies_list_item_widget.dart';
import '../../category/widgets/services_list_item_widget.dart';
import '../controllers/maps_controller.dart';
import 'maps_carousel_loading_widget.dart';

class MapsCarouselWidget extends GetWidget<MapsController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Obx(() {
        RxList<dynamic> data = [].obs;
        if (controller.tabIndex.value == 0) {
          data = controller.eServices;
        } else {
          data = controller.salons;
        }
        if (data.isEmpty) return MapsCarouselLoadingWidget();
        if (controller.selectedItem != null) {
          return controller.tabIndex.value == 0
              ? ServicesListItemWidget(
                  service: EService.fromJson(controller.selectedItem.toJson()))
              : CompaniesListItemWidget(salon: controller.selectedItem);
        }
        return ListView.builder(
            // padding: EdgeInsets.only(bottom: 35, left: 21),
            primary: false,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: data.length,
            itemBuilder: (_, index) {
              var item = data.elementAt(index);

              return controller.tabIndex.value == 0
                  ? ServicesListItemWidget(service: item)
                  : CompaniesListItemWidget(salon: item);
            });
      }),
    );
  }
}
