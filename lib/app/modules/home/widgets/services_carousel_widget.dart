/*
 * File name: services_carousel_widget.dart
 * Last modified: 2022.02.10 at 14:56:05
 * Author: SmarterVision - https://codecanyon.net/user/smartervision
 * Copyright (c) 2022
 */

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/ui.dart';
import '../../../models/e_service_model.dart';
import '../../../routes/app_routes.dart';
import '../../global_widgets/duration_chip_widget.dart';

class ServicesCarouselWidget extends StatelessWidget {
  final List<EService> services;

  const ServicesCarouselWidget(
      {Key? key, required List<EService> this.services})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 255,
      child: ListView.builder(
          padding: EdgeInsets.only(bottom: 15),
          primary: false,
          shrinkWrap: false,
          scrollDirection: Axis.horizontal,
          itemCount: services.length,
          itemBuilder: (_, index) {
            var _service = services.elementAt(index);
            return GestureDetector(
              onTap: () {
                Get.toNamed(Routes.E_SERVICE, arguments: {
                  'eService': _service,
                  'heroTag': 'services_carousel'
                });
              },
              child: Container(
                width: 220,
                margin: EdgeInsetsDirectional.only(
                    end: 20, start: index == 0 ? 20 : 0, top: 20, bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  // boxShadow: [
                  //   BoxShadow(
                  //       color: Get.theme.focusColor.withOpacity(0.05),
                  //       blurRadius: 5,
                  //       offset: Offset(0, 5)),
                  // ],
                ),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                      child: CachedNetworkImage(
                        height: 130,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        imageUrl: _service.firstImageUrl,
                        placeholder: (context, url) => Image.asset(
                          'assets/img/loading.gif',
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 100,
                        ),
                        errorWidget: (context, url, error) =>
                            Icon(Icons.error_outline),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 10),
                      height: 80,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Get.theme.primaryColor,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${_service.name}",
                            maxLines: 1,
                            style: Get.textTheme.bodyMedium!
                                .merge(TextStyle(color: Get.theme.hintColor)),
                          ),
                          // Html(
                          //   data: _service.description,
                          //   style: {
                          //     // p tag with text_size
                          //     "p": Style(
                          //       textOverflow: TextOverflow.ellipsis,
                          //       fontSize: FontSize(10),
                          //       fontWeight: FontWeight.w600,
                          //       color: Ui.parseColor(
                          //           Setting().obs.value.secondColor),
                          //     ),
                          //   },
                          // ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              DurationChipWidget(duration: _service.duration!),
                              SizedBox(width: 10),
                              Container(
                                height: 20,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.star_border_outlined,
                                      size: 12,
                                      color: Get.theme.hintColor,
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      '4.5',
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.w400,
                                          color: Get.theme.hintColor,
                                          height: 1.2),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  if (_service.getOldPrice! > 0)
                                    Ui.getPrice(
                                      _service.getOldPrice!,
                                      style: TextStyle(
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.w400,
                                          color: Get.theme.hintColor,
                                          height: 1.2),
                                    ),
                                  Ui.getPrice(
                                    _service.getPrice!,
                                    style: TextStyle(
                                        fontSize: 10.0,
                                        fontWeight: FontWeight.w400,
                                        color: Get.theme.hintColor,
                                        height: 1.2),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          // SizedBox(height: 10),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   crossAxisAlignment: CrossAxisAlignment.end,
                          //   children: [
                          //     Text(
                          //       "Start from".tr,
                          //       style: Get.textTheme.bodySmall,
                          //     ),
                          //     Column(
                          //       crossAxisAlignment: CrossAxisAlignment.end,
                          //       children: [
                          //         if (_service.getOldPrice > 0)
                          //           Ui.getPrice(
                          //             _service.getOldPrice,
                          //             style: Get.textTheme.bodyMedium.merge(
                          //                 TextStyle(
                          //                     color: Get.theme.focusColor,
                          //                     decoration:
                          //                         TextDecoration.lineThrough)),
                          //           ),
                          //         Ui.getPrice(
                          //           _service.getPrice,
                          //           style: Get.textTheme.bodyMedium.merge(
                          //               TextStyle(
                          //                   color: Get
                          //                       .theme.colorScheme.secondary)),
                          //         ),
                          //       ],
                          //     ),
                          //   ],
                          // )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
