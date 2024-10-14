/*
 * File name: bookings_list_widget.dart
 * Last modified: 2022.08.16 at 14:16:42
 * Author: SmarterVision - https://codecanyon.net/user/smartervision
 * Copyright (c) 2022
 */

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../common/empty_view.dart';
import '../../../providers/laravel_provider.dart';
import '../../../routes/app_routes.dart';
import '../controllers/bookings_controller.dart';
import 'bookings_list_item_widget.dart';
import 'bookings_list_loader_widget.dart';

class BookingsListWidget extends GetView<BookingsController> {
  BookingsListWidget({Key? key}) : super(key: key);

  String formatDate(DateTime dateTime) {
    return DateFormat('EEE d, MMM').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (Get.find<LaravelApiClient>().isLoading(task: 'getBookings') &&
          controller.page.value == 1) {
        return BookingsListLoaderWidget();
      } else if (controller.bookings.isEmpty) {
        return EmptyView(
            title: 'Захиалга байхгүй байна',
            buttonTap: () => Get.toNamed(Routes.CATEGORIES),
            buttonText: 'Шинэ захиалга өгөх',
            message:
                'Танд хүлээгдэж буй захиалга алга. Доорх товчийг дарж шинэ захиалгаа өгнө үү'); // CircularLoadingWidget(height: 300);
      } else {
        return Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  padding: const EdgeInsets.only(
                      top: 10, bottom: 5, left: 15, right: 15),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          formatDate(DateTime.now()),
                          style: context.textTheme.headlineSmall,
                        ),
                      ),
                      InkWell(
                          onTap: () {
                            Get.toNamed(Routes.CATEGORIES);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 10, top: 10, bottom: 10),
                            child: Row(
                              children: [
                                Text("Хүлээгдэж байгаа (4)",
                                    style: context.textTheme.headlineSmall
                                        ?.copyWith(
                                            color: context
                                                .theme.secondaryHeaderColor,
                                            fontWeight: FontWeight.w400)),
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
                ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  primary: false,
                  shrinkWrap: true,
                  itemCount: controller.bookings.length + 1,
                  itemBuilder: ((_, index) {
                    if (index == controller.bookings.length) {
                      return Obx(() {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Opacity(
                              opacity: controller.isLoading.value ? 1 : 0,
                              child: const CircularProgressIndicator(),
                            ),
                          ),
                        );
                      });
                    } else {
                      return BookingsListItemWidget(
                        booking: controller.bookings[index],
                      );
                    }
                  }),
                ),
              ],
            ),
          ),
        );
      }
    });
  }
}
