/*
 * File name: slide_item_widget.dart
 * Last modified: 2022.02.04 at 18:23:47
 * Author: SmarterVision - https://codecanyon.net/user/smartervision
 * Copyright (c) 2022
 */

import 'dart:math' as math;

import '../../../../helpers/color.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/ui.dart';

class SlideItemWidget extends StatelessWidget {
  final dynamic slide;

  const SlideItemWidget({
    required this.slide,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            // if (slide.salon != null) {
            //   Get.toNamed(Routes.SALON, arguments: {
            //     'salon': slide.salon,
            //     'heroTag': 'salon_slide_item'
            //   });
            // } else if (slide.eService != null) {
            //   Get.toNamed(Routes.E_SERVICE, arguments: {
            //     'eService': slide.eService,
            //     'heroTag': 'slide_item'
            //   });
            // }
          },
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            clipBehavior: Clip.hardEdge,
            elevation: 0,
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(
                  Directionality.of(context) == TextDirection.rtl
                      ? math.pi
                      : 0),
              child: CachedNetworkImage(
                width: double.infinity,
                height: 181,
                fit: BoxFit.cover,
                imageUrl: "${slide['media'].length >= 1 ? slide['media'][0]['url'] : 'https://fakeimg.pl/240x80'}",
                placeholder: (context, url) => Image.asset(
                  'assets/img/loading.gif',
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
                errorWidget: (context, url, error) => Icon(Icons.error_outline),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 60,
          left: 20,
          child: Container(
              alignment: Ui.getAlignmentDirectional(slide['text_position']),
              child: SizedBox(
                width: Get.width / 2.5,
                child: Column(
                  children: [
                    // if (slide.text != null && slide.text != '')
                    Text(
                      "${slide['text'] ?? ''}",
                      style: Get.textTheme.bodyMedium!.merge(
                        TextStyle(
                            color: CoreColor.fromHex('${slide['text_color']}')),
                      ),
                      overflow: TextOverflow.fade,
                      maxLines: 3,
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment:
                      Ui.getCrossAxisAlignment("${slide['text_position']}"),
                ),
              )),
        ),
      ],
    );
  }
}
