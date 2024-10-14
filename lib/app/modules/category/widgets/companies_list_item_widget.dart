import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../common/ui.dart';
import '../../../models/salon_model.dart';
import '../../../routes/app_routes.dart';

class CompaniesListItemWidget extends StatelessWidget {
  final Salon? salon;
  final Function? favouriteClicked;
  final bool? isFromFavorite;
  const CompaniesListItemWidget(
      {this.salon,
      this.favouriteClicked,
      this.isFromFavorite = false,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.SALON, arguments: {'salon': salon});
      },
      child: Container(
        height: 155,
        width: 306,
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: Ui.getBoxDecoration(radius: 32),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              if (salon!.logo!.isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: CachedNetworkImage(
                    height: 115,
                    width: 120,
                    fit: BoxFit.cover,
                    imageUrl: "${salon?.logo}",
                    placeholder: (context, url) => Image.asset(
                      'assets/img/loading.gif',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 150,
                    ),
                    errorWidget: (context, url, error) =>
                        Icon(Icons.error_outline),
                  ),
                )
              else
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.white, width: 1)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      alignment: Alignment.center,
                      width: 120,
                      height: 114,
                      decoration: BoxDecoration(color: Get.theme.focusColor),
                      child: Text(
                        salon!.name!.isNotEmpty ? salon!.name![0] : '',
                        style: TextStyle(color: Colors.white, fontSize: 40),
                      ),
                    ),
                  ),
                ),
              const SizedBox(width: 16),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 21),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 30,
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 1,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: EdgeInsets.only(right: 16),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          color: index == 0
                                              ? Get.theme.focusColor
                                                  .withOpacity(0.1)
                                              : Color(0xff4aaf57)
                                                  .withOpacity(0.1)),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Text(
                                            index == 0
                                                ? "Үйлчилгээ"
                                                : 'Цэвэрлэгээ',
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: index == 0
                                                    ? Get.theme.focusColor
                                                    : Color(0xff4aaf57)),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                            InkWell(
                              onTap: () {
                                if (favouriteClicked != null)
                                  this.favouriteClicked!();
                              },
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                height: 30,
                                width: 30,
                                child: salon?.isFavorite ?? false
                                    ? SvgPicture.asset(
                                        "assets/img/ic_bookmark.svg",
                                        fit: BoxFit.contain,
                                      )
                                    : SvgPicture.asset(
                                        "assets/img/ic_bookmark_blank.svg",
                                        fit: BoxFit.contain,
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        child: Text(
                          "${salon!.salonName!.isNotEmpty ? salon?.salonName : salon?.name}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Get.textTheme.bodyMedium?.merge(
                            TextStyle(color: Colors.black, fontSize: 18),
                          ),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          "${salon?.description}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Color(0xff616161),
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.star, size: 14, color: Color(0xFFFFB24D)),
                          const SizedBox(width: 9),
                          Text(
                            "${salon?.rate.toString()}",
                            maxLines: 2,
                            style: TextStyle(
                                color: Color(0xff616161), fontSize: 12),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '|',
                            maxLines: 2,
                            style: TextStyle(
                                color: Color(0xff616161), fontSize: 12),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "${salon?.distance.toString()} км",
                            maxLines: 2,
                            style: TextStyle(
                                color: Color(0xff616161), fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
