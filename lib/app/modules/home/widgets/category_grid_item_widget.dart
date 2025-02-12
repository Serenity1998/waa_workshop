/*
 * File name: category_grid_item_widget.dart
 * Last modified: 2022.02.17 at 09:20:42
 * Author: SmarterVision - https://codecanyon.net/user/smartervision
 * Copyright (c) 2022
 */

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../models/category_model.dart';
import '../../../routes/app_routes.dart';

class CategoryGridItemWidget extends StatelessWidget {
  final Category category;
  final String heroTag;

  CategoryGridItemWidget(
      {Key? key, required this.category, required this.heroTag})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Get.theme.colorScheme.secondary.withOpacity(0.08),
      onTap: () {
        Get.toNamed(Routes.CATEGORY, arguments: category);
      },
      child: Column(
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: category.color?.withOpacity(0.1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5)),
                  ),
                  child:
                      ("${category.image?.url}".toLowerCase().endsWith('.svg')
                          ? SvgPicture.network(
                              "${category.image?.url}",
                              color: category.color,
                              height: 25,
                            ).paddingAll(10)
                          : CachedNetworkImage(
                              height: 25,
                              fit: BoxFit.fitHeight,
                              imageUrl: "${category.image?.url}",
                              placeholder: (context, url) => Image.asset(
                                'assets/img/loading.gif',
                                fit: BoxFit.cover,
                              ),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error_outline),
                            )),
                ),
              ],
            ),
          ),
          const SizedBox(height: 2),
          Flexible(
            child: Text(
              category.name ?? '',
              style: Get.textTheme.bodyLarge!
                  .merge(TextStyle(fontWeight: FontWeight.w500)),
              softWrap: false,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
