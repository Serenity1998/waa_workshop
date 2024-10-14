import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../app/modules/bookings/controllers/bookings_controller.dart';
import '../app/modules/search/controllers/search_controller.dart';

// ignore: must_be_immutable
class EmptyView extends GetWidget<BookingsController> {
  final String message;
  final String title;
  final String buttonText;
  final Function? buttonTap;

  EmptyView({
    Key? key,
    this.message = '',
    this.title = '',
    this.buttonText = '',
    this.buttonTap,
  }) : super(key: key);

  SearchControllerCustom searchController = Get.put(SearchControllerCustom());
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (message.isEmpty && title.isEmpty)
            Obx(() {
              List<String> categoriesName =
                  searchController.selectedCategoriesName;

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      '"${(searchController.textEditingController.text.isNotEmpty) ? searchController.textEditingController.text : categoriesName.join(' ')}" хайлтын үр дүн',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                  ),
                  Text(
                    '${searchController.eServices.length} олдсон',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Get.theme.focusColor,
                    ),
                  )
                ],
              );
            }),
          const SizedBox(height: 60),
          Center(child: SvgPicture.asset("assets/img_new/order_empty.svg")),
          const SizedBox(height: 40),
          if (title.isNotEmpty)
            Container(
              margin: const EdgeInsets.only(bottom: 12),
              child: Text('$title',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            ),
          if (message.isEmpty && title.isEmpty) ...[
            Text('Олдсонгүй',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
            const SizedBox(height: 10),
            Text(
                'Уучлаарай, таны оруулсан түлхүүр үг олдсонгүй, дахин шалгах эсвэл өөр түлхүүр үгээр хайна уу.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
          ] else
            Text(
              message ??
                  "Танд одоогоор ${controller.getCurrentStatus().status?.toLowerCase()} төлөвтэй\nзахиалга байхгүй байна!",
              style: Get.textTheme.bodyLarge?.copyWith(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          if (buttonText.isNotEmpty && buttonTap != null) SizedBox(height: 40),
          if (buttonText.isNotEmpty && buttonTap != null)
            InkWell(
              onTap: () => buttonTap,
              child: Container(
                height: 58,
                width: Get.width,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60),
                  color: Color(0xffF1E7FF),
                ),
                child: Text(
                  '$buttonText',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Get.theme.focusColor,
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
