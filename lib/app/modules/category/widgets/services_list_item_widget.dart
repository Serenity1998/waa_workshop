/*
 * File name: services_list_item_widget.dart
 * Last modified: 2022.02.14 at 11:09:50
 * Author: SmarterVision - https://codecanyon.net/user/smartervision
 * Copyright (c) 2022
 */

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../common/ui.dart';
import '../../../models/e_service_model.dart';
import '../../../routes/app_routes.dart';

class ServicesListItemWidget extends StatelessWidget {
  ServicesListItemWidget({
    Key? key,
    required EService service,
    this.isFromFavorite = false,
    this.favouriteClicked,
  })  : _service = service,
        super(key: key);

  final EService _service;
  final bool? isFromFavorite;
  final Function? favouriteClicked;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isFromFavorite ?? false
          ? null
          : () {
              Get.toNamed(Routes.E_SERVICE, arguments: {
                'eService': _service,
                'heroTag': 'service_list_item'
              });
            },
      child: Container(
        height: 155,
        width: isFromFavorite! ? double.infinity : 306,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        margin: EdgeInsets.symmetric(
            horizontal: isFromFavorite! ? 0 : 10, vertical: 10),
        decoration: Ui.getBoxDecoration(radius: 32),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hero(
              tag: 'service_list_item ${_service.id}',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: CachedNetworkImage(
                  height: 114,
                  width: 120,
                  fit: BoxFit.cover,
                  imageUrl: "${_service.firstImageUrl}",
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
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Wrap(
                runSpacing: 5,
                alignment: WrapAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          _service.salon != null
                              ? _service.salon?.name ?? ""
                              : "",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[700],
                            height: 1.2,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20)
                      // InkWell(
                      //   onTap: () {
                      //     if (favouriteClicked != null)
                      //       this.favouriteClicked!();
                      //   },
                      //   child: Container(
                      //     padding: const EdgeInsets.all(5),
                      //     height: 30,
                      //     width: 30,
                      //     child: _service.isFavorite ?? false
                      //         ? SvgPicture.asset(
                      //             "assets/img/ic_bookmark.svg",
                      //             fit: BoxFit.contain,
                      //           )
                      //         : SvgPicture.asset(
                      //             "assets/img/ic_bookmark_blank.svg",
                      //             fit: BoxFit.contain,
                      //           ),
                      //   ),
                      // ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          _service.name ?? '',
                          style: Get.textTheme.bodyMedium!
                              .merge(const TextStyle(fontSize: 16)),
                          maxLines: 2,
                          // textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Ui.getPrice(
                        _service.getPrice ?? 0,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Get.theme.focusColor,
                            height: 1.2),
                      ),
                      if ((_service.getOldPrice ?? 0) > 0)
                        Ui.getPrice(_service.getOldPrice ?? 0,
                            style: TextStyle(
                                fontSize: 10.0,
                                fontWeight: FontWeight.w400,
                                color: Get.theme.hintColor,
                                height: 1.2)),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 13,
                        width: 13,
                        child: SvgPicture.asset(
                          'assets/img_new/ic_star.svg',
                          color: Colors.amber,
                        ),
                      ),
                      const SizedBox(width: 5),
                      if (_service.salon != null) ...[
                        Text(
                          '${_service.salon?.rate!.toStringAsFixed(1)}',
                          maxLines: 1,
                          style: TextStyle(
                              fontSize: 10.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[700],
                              height: 1.2),
                        ),
                        Text(
                          " | ${_service.salon?.reviews?.length.toString()} сэтгэгдэл",
                          maxLines: 1,
                          style: TextStyle(
                              fontSize: 10.0,
                              fontWeight: FontWeight.w400,
                              color: Get.theme.hintColor,
                              height: 1.2),
                        ),
                      ]
                    ],
                  ),

                  // Divider(height: 8, thickness: 1),
                  // Wrap(
                  //   spacing: 5,
                  //   children:
                  //       List.generate(_service.categories.length, (index) {
                  //     return Container(
                  //       padding:
                  //           EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  //       child: Text(_service.categories.elementAt(index).name,
                  //           style: Get.textTheme.bodySmall
                  //               .merge(TextStyle(fontSize: 10))),
                  //       decoration: BoxDecoration(
                  //           color: Get.theme.primaryColor,
                  //           border: Border.all(
                  //             color: Get.theme.focusColor.withOpacity(0.2),
                  //           ),
                  //           borderRadius:
                  //               BorderRadius.all(Radius.circular(20))),
                  //     );
                  //   }),
                  //   runSpacing: 5,
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
