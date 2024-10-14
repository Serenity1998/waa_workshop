/*
 * File name: salon_details_view.dart
 * Last modified: 2022.05.19 at 12:10:11
 * Author: SmarterVision - https://codecanyon.net/user/smartervision
 * Copyright (c) 2022
 */

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:readmore/readmore.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../common/map.dart';
import '../../../../common/ui.dart';
import '../../global_widgets/circular_loading_widget.dart';
import '../../global_widgets/salon_availability_badge_widget.dart';
import '../controllers/salon_controller.dart';
import '../widgets/availability_hour_item_widget.dart';
import '../widgets/salon_til_widget.dart';

class SalonDetailsView extends GetView<SalonController> {
  const SalonDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var salon = controller.salon.value;
      return Wrap(
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: ReadMoreText(
                "${salon.description}",
                trimLines: 2,
                colorClickableText: Get.theme.focusColor,
                trimMode: TrimMode.Line,
                trimCollapsedText: 'Цааш унших...',
                trimExpandedText: ' Хураах...',
                style: const TextStyle(
                    color: Color(0xff424242), fontWeight: FontWeight.w400),
                moreStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Get.theme.focusColor),
              )),
          buildContactUs(),
          buildAddress(context),
          buildAvailabilityHours(),
        ],
      );
    });
  }

  Padding buildContactUs() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: Get.width * 0.6 - 30,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Холбоо барих',
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(height: 4),
                Text(
                  'Бизнес эрхлэгчийн холбоо барих холбоосууд',
                  style: TextStyle(color: Color(0xff616161), fontSize: 12),
                )
              ],
            ),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  controller.startChat();
                },
                child: Container(
                  height: 56,
                  width: 56,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(56),
                      color: Color(0xffF1E7FF).withAlpha(70)),
                  child: Center(
                    child: SvgPicture.asset(
                      "assets/img_new/ic_message_active.svg",
                      width: 20,
                      height: 20,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 13),
              GestureDetector(
                onTap: () {
                  launchUrlString(
                      "tel:${controller.salon.value.phoneNumber ?? ''}");
                },
                child: Container(
                  height: 56,
                  width: 56,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(56),
                      color: const Color(0xffF1E7FF).withAlpha(70)),
                  child: Center(
                      child: Image.asset(
                    "assets/img_new/call.png",
                    width: 19,
                  )),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Container buildAddress(context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: Ui.getBoxDecoration(),
      child: (controller.loading.value == false)
          ? Shimmer.fromColors(
              baseColor: Colors.grey.withOpacity(0.15),
              highlightColor: Colors.grey[200]!.withOpacity(0.1),
              child: Container(
                width: double.infinity,
                height: 220,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            )
          : (controller.salon.value.address == null)
              ? const SizedBox(height: 0)
              : Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: MapsUtil.getStaticMaps(
                          controller.salon.value.address?.getLatLng() ??
                              const LatLng(47.918189, 106.917636)),
                    ).paddingOnly(bottom: 50),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      decoration: BoxDecoration(
                        color: Get.theme.primaryColor,
                        borderRadius: const BorderRadius.vertical(
                            bottom: Radius.circular(10)),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Location".tr,
                                    style: Get.textTheme.titleSmall),
                                const SizedBox(height: 5),
                                Text(
                                    "${controller.salon.value.address?.address}",
                                    style: Get.textTheme.bodySmall),
                              ],
                            ),
                          ),
                          MaterialButton(
                            onPressed: () {
                              MapsUtil.openMapsSheet(
                                  context,
                                  controller.salon.value.address?.getLatLng() ??
                                      const LatLng(47.918189, 106.917636),
                                  "${controller.salon.value.name}");
                            },
                            height: 44,
                            minWidth: 44,
                            padding: EdgeInsets.zero,
                            shape: const CircleBorder(),
                            color: Get.theme.colorScheme.secondary
                                .withOpacity(0.2),
                            elevation: 0,
                            child: Icon(
                              Icons.directions_outlined,
                              color: Get.theme.colorScheme.secondary,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
    );
  }

  SalonTilWidget buildAvailabilityHours() {
    return SalonTilWidget(
      title: Text("Availability".tr, style: Get.textTheme.titleSmall),
      content: (controller.loading.value == false)
          ? CircularLoadingWidget(height: 150)
          : ListView.separated(
              padding: EdgeInsets.zero,
              primary: false,
              shrinkWrap: true,
              itemCount: controller.salon.value
                  .groupedAvailabilityHours()
                  .entries
                  .length,
              separatorBuilder: (context, index) {
                return const Divider(height: 16, thickness: 0.8);
              },
              itemBuilder: (context, index) {
                var availabilityHour = controller.salon.value
                    .groupedAvailabilityHours()
                    .entries
                    .elementAt(index);
                var data = controller.salon.value
                    .getAvailabilityHoursData(availabilityHour.key);
                return AvailabilityHourItemWidget(
                    availabilityHour: availabilityHour, data: data);
              },
            ),
      actions: [
        SalonAvailabilityBadgeWidget(salon: controller.salon.value),
      ],
    );
  }
}
