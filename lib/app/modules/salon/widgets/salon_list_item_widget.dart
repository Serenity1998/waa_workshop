/*
 * File name: services_list_item_widget.dart
 * Last modified: 2022.02.11 at 18:43:34
 * Author: SmarterVision - https://codecanyon.net/user/smartervision
 * Copyright (c) 2022
 */

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/ui.dart';
import '../../../../helpers/color.dart';
import '../../../models/salon_model.dart';
import '../../../routes/app_routes.dart';

class SalonListItemWidget extends StatelessWidget {
  const SalonListItemWidget({
    Key? key,
    required Salon salon,
  })  : _salon = salon,
        super(key: key);

  final Salon _salon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 6, right: 6, bottom: 30),
      padding: const EdgeInsets.only(bottom: 18.0),
      decoration: Ui.getBoxDecoration(radius: 36, boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.08),
          spreadRadius: 6,
          blurRadius: 7,
          offset: const Offset(0, 5),
        )
      ]),
      child: InkWell(
        onTap: () {
          Get.toNamed(Routes.SALON_DETAILS,
              arguments: {'salon': _salon, 'heroTag': 'salon_list_item'});
        },
        child: Column(
          children: [
            Stack(
              alignment: AlignmentDirectional.topStart,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(36),
                      topRight: Radius.circular(36)),
                  child: CachedNetworkImage(
                    height: 170,
                    width: double.maxFinite,
                    fit: BoxFit.cover,
                    imageUrl: _salon.firstImageUrl,
                    placeholder: (context, url) => Image.asset(
                      'assets/img/loading.gif',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 80,
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error_outline),
                  ),
                ),
                Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      decoration: Ui.getLabelBoxDecoration(),
                      margin: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 15),
                      padding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 10),
                      child: Text(
                        _salon.salonLevel?.name ?? '',
                        style: Get.textTheme.labelSmall?.merge(TextStyle(
                            color: CoreColor.white,
                            fontWeight: FontWeight.bold)),
                        maxLines: 3,
                        // textAlign: TextAlign.end,
                      ),
                    ))
              ],
            ),
            Container(
              padding: const EdgeInsets.only(top: 14.0, left: 15, right: 15),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(36)),
                    child: CachedNetworkImage(
                      imageUrl: _salon.firstImageIcon,
                      fit: BoxFit.cover,
                      width: 32,
                      height: 32,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(_salon.name ?? "",
                            style: Get.textTheme.labelMedium),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            Image.asset(
                              'assets/icon/star.png',
                              fit: BoxFit.cover,
                              width: 13,
                              height: 13,
                            ),
                            const SizedBox(width: 5),
                            Text("${_salon.rate ?? 0}",
                                style: Get.textTheme.labelMedium),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    decoration: Ui.getLabelBoxDecoration(
                        radius: 12,
                        color: _salon.available ?? false
                            ? CoreColor.green.withOpacity(0.18)
                            : CoreColor.blue.withOpacity(0.18)),
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                    child: Text(
                      _salon.available ?? false ? 'Open' : 'Closed',
                      style: Get.textTheme.labelSmall?.merge(TextStyle(
                          color: _salon.available ?? false
                              ? CoreColor.green
                              : CoreColor.blue,
                          fontSize: 8,
                          fontWeight: FontWeight.bold)),
                      maxLines: 1,
                      // textAlign: TextAlign.end,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
