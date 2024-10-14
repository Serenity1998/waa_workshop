import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:save_time_customer/app/models/salon_user_model.dart';

import '../../../../common/ui.dart';
import '../../../../helpers/color.dart';
import '../../../models/user_model.dart';
import '../../../routes/app_routes.dart';

class SalonEmployeeItem extends StatelessWidget {
  final Function? select;
  final SalonUser? employee;
  bool selected = false;

  SalonEmployeeItem(
      {Key? key, this.selected = false, this.select, this.employee})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 6, right: 6, bottom: 30),
      decoration: Ui.getBoxDecoration(radius: 36, boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.08),
          spreadRadius: 6,
          blurRadius: 7,
          offset: const Offset(0, 5),
        )
      ]),
      child: InkWell(
        onTap: () {},
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              height: double.maxFinite,
              width: 140,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: employee?.user?.media?.url ??
                      'https://cdn.dribbble.com/users/304574/screenshots/6222816/male-user-placeholder.png',
                  // imageUrl: 'http://192.168.1.77/storage/21/2009-stadium-about.jpg',
                  errorWidget: (context, url, error) =>
                      const Icon(Icons.error_outline),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 2),
                  Text(employee?.position ?? "",
                      style: context.textTheme.bodySmall),
                  const SizedBox(height: 10),
                  Text(employee?.user?.name ?? "",
                      style: context.textTheme.headlineSmall),
                  const SizedBox(height: 10),
                  Text(
                    "Туршлага: ${employee?.worked_year ?? "0"} жил",
                    maxLines: 1,
                    style: TextStyle(
                        fontSize: 10.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[700],
                        height: 1.2),
                  ),
                  const SizedBox(height: 10),
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
                      SizedBox(width: 5),
                      if (employee?.worked_year != null) ...[
                        Text(
                          "0",
                          maxLines: 1,
                          style: TextStyle(
                              fontSize: 10.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[700],
                              height: 1.2),
                        ),
                      ],
                      SizedBox(width: 5),
                      Container(
                        height: 13,
                        width: 13,
                        child: SvgPicture.asset(
                          'assets/icon/user.svg',
                          color: Colors.amber,
                        ),
                      ),
                      SizedBox(width: 5),
                      if (employee?.worked_year != null) ...[
                        Text(
                          "0",
                          maxLines: 1,
                          style: TextStyle(
                              fontSize: 10.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[700],
                              height: 1.2),
                        ),
                      ]
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
