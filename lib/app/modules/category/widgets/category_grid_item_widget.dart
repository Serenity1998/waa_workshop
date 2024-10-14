/*
 * File name: category_grid_item_widget.dart
 * Last modified: 2022.02.17 at 10:51:44
 * Author: SmarterVision - https://codecanyon.net/user/smartervision
 * Copyright (c) 2022
 */

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../common/ui.dart';
import '../../../models/category_model.dart';
import '../../../models/media_model.dart';
import '../../../routes/app_routes.dart';

class CategoryGridItemWidget extends StatelessWidget {
  final Category category;
  final String heroTag;

  CategoryGridItemWidget({
    Key? key,
    required this.category,
    required this.heroTag,
  }) : super(key: key);

  Widget getCategoryImage(List<Media> image) {
    return "${image.length >= 1 ? image[0].url : 'https://fakeimg.pl/80x80'}"
        .toLowerCase()
        .endsWith('.svg')
        ? SvgPicture.network(
          "${image.length >= 1 ? image[0].url : 'https://fakeimg.pl/80x80'}",
            height: 45,
          ).paddingOnly(top: 0, bottom: 10)
        : CachedNetworkImage(
          fit: BoxFit.fitHeight,
          height: 45,
          imageUrl: "${image.length >= 1 ? image[0].url : 'https://fakeimg.pl/80x80'}",
          placeholder: (context, url) => Image.asset(
            'assets/img/loading.gif',
            fit: BoxFit.cover,
          ),
          errorWidget: (context, url, error) =>
          Icon(Icons.error_outline),
        ).paddingOnly(top: 0, bottom: 10);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Get.theme.colorScheme.secondary.withOpacity(0.08),
      onTap: () {
        Get.toNamed(Routes.CATEGORY, arguments: category);
      },
      child: Column(
        children: <Widget>[
          Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: getCategoryImage(category.banners ?? [])
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Text(
              "${category.name}",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium!.merge(
                const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              softWrap: false,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),


    );
  }
}
