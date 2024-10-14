import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../common/ui.dart';
import '../../../routes/app_routes.dart';
import '../../global_widgets/block_button_widget.dart';
import '../controllers/book_e_service_controller.dart';

class BookingSelectEmployeeView extends GetView<BookEServiceController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ажилтан сонгох")),
      backgroundColor: Color(0xFFF1E7FF),
      body: Stack(
        children: [
          // Container(
          //   margin: EdgeInsets.only(top: 20),
          //   height: 279,
          //   child: Obx(() {
          //     return ListView.builder(
          //         padding: EdgeInsets.symmetric(horizontal: 20),
          //         scrollDirection: Axis.horizontal,
          //         itemCount: controller.booking.value.salon?.employees?.length,
          //         itemBuilder: ((context, index) {
          //           var employee =
          //               controller.booking.value.salon?.employees?[index];
          //           return SalonEmployeeItem(
          //             selected: controller.booking.value.employee == employee,
          //             employee: employee!,
          //             select: () {
          //               controller.selectEmployee(employee);
          //               controller.booking.refresh();
          //             },
          //           );
          //         }));
          //   }),
          // ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: Get.width,
              padding: EdgeInsets.symmetric(vertical: 36, horizontal: 24),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  )),
              height: 316,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child: Text("Та ажилтан  сонгохгүй байж болно")),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    color: Colors.grey[300],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text("Таны сонгосон ажилтан"),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 56,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                        color: lightGrayColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(() {
                            if (controller.booking.value.employee == null) {
                              return Container();
                            }
                            return Text(
                                "${controller.booking.value.employee?.name}");
                          }),
                          SvgPicture.asset(
                            "assets/img_new/ic_profile_active.svg",
                            color: Colors.black,
                          )
                        ]),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: Get.width,
                    height: 56,
                    child: BlockButtonWidget(
                        text: "Үргэлжлүүлэх",
                        onPressed: () async {
                          if (controller.booking.value.employee == null) {
                            Get.showSnackbar(Ui.defaultSnackBar(
                                message: "Та ажилтан сонгоно уу".tr));
                            return;
                          }
                          await Get.toNamed(Routes.BOOKING_SUMMARY);
                        }),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
