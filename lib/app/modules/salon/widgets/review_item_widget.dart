/*
 * File name: review_item_widget.dart
 * Last modified: 2022.02.10 at 17:47:27
 * Author: SmarterVision - https://codecanyon.net/user/smartervision
 * Copyright (c) 2022
 */

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/ui.dart';
import '../../../models/review_model.dart';

class ReviewItemWidget extends StatelessWidget {
  final Review review;

  ReviewItemWidget({Key? key, required this.review}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Wrap(
        direction: Axis.horizontal,
        runSpacing: 20,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              if (review.booking?.user != null)
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: CachedNetworkImage(
                    height: 65,
                    width: 65,
                    fit: BoxFit.cover,
                    imageUrl: "${review.booking?.user?.avatar?.thumb}",
                    placeholder: (context, url) => Image.asset(
                      'assets/img/loading.gif',
                      fit: BoxFit.cover,
                      height: 65,
                      width: 65,
                    ),
                    errorWidget: (context, url, error) =>
                        Icon(Icons.error_outline),
                  ),
                )
              else
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: Image.asset(
                    'assets/img/img_placeholder.jpg',
                    height: 65,
                    width: 65,
                  ),
                ),
              SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      review.booking?.user?.name ?? 'Хэрэглэгч',
                      overflow: TextOverflow.fade,
                      softWrap: false,
                      maxLines: 2,
                      style: Get.textTheme.bodyMedium!
                          .merge(TextStyle(color: Get.theme.hintColor)),
                    ),
                    Text(
                      review.booking?.user?.bio ?? '',
                      overflow: TextOverflow.ellipsis,
                      style: Get.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 32,
                child: Chip(
                  padding: EdgeInsets.all(0),
                  label: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(review.rate.toString(),
                          style: Get.textTheme.bodyLarge!
                              .merge(TextStyle(color: Get.theme.primaryColor))),
                      Icon(
                        Icons.star_border,
                        color: Get.theme.primaryColor,
                        size: 16,
                      ),
                    ],
                  ),
                  backgroundColor:
                      Get.theme.colorScheme.secondary.withOpacity(0.9),
                  shape: StadiumBorder(),
                ),
              ),
            ],
          ),
          // Ui.removeHtml(review.review!, style: Get.textTheme.bodyLarge!),
        ],
      ),
    );
  }
}
