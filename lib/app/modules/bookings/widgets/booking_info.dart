import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/map.dart';
import '../../../../common/ui.dart';
import '../../../models/address_model.dart';
import '../../../models/booking_model.dart';
import '../../../services/settings_service.dart';
import '../controllers/booking_controller.dart';
import 'package:intl/intl.dart';

class BookingInfo extends GetWidget<BookingController> {
  Address get currentAddress => Get.find<SettingsService>().address.value;
  @override
  Widget build(BuildContext context) {
    Booking booking = controller.booking.value;

    return Container(
      width: Get.width,
      padding: EdgeInsets.all(20),
      decoration: Ui.getBoxDecoration(radius: 32),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CachedNetworkImage(
                      imageUrl: "${booking.salon?.firstImageThumb}",
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 16),
                  SizedBox(
                    width: Get.width - 206,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${booking.salon?.name}",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Container(
                              margin: EdgeInsets.only(top: 0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.calendar_month_outlined,
                                      color: Get.theme.focusColor, size: 20),
                                  const SizedBox(width: 5),
                                  Flexible(
                                    child: Text(
                                      "${DateFormat("yyy/MM/dd").format(controller.booking.value.bookingAt!)} | ${DateFormat("HH:mm").format(controller.booking.value.bookingAt!)}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Get.theme.focusColor),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                        Container(
                            decoration: BoxDecoration(
                                color: Get.theme.focusColor,
                                borderRadius: BorderRadius.circular(6)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 6),
                              child: Text(
                                "${controller.booking.value.status?.status}".tr,
                                style: TextStyle(
                                    fontSize: 10, color: Colors.white),
                              ),
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Ажилтан',
                style: TextStyle(
                    color: Color(0xff616161),
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                controller.booking.value.employee?.name ?? '',
                style: TextStyle(
                    color: Color(0xff616161),
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              )
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Байршил',
                style: TextStyle(
                    color: Color(0xff616161),
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(width: 10),
              Expanded(
                  child: Text(
                "${controller.booking.value.address?.address}",
                textAlign: TextAlign.end,
                style: TextStyle(
                    color: Color(0xff616161),
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ))
            ],
          ),
          const SizedBox(height: 15),
          Obx(
            () => Stack(
              alignment: Alignment.bottomCenter,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: MapsUtil.getStaticMaps(
                      controller.booking.value.address!.getLatLng()),
                ).paddingOnly(bottom: 50),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  decoration: BoxDecoration(
                      color: Get.theme.primaryColor,
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(10)),
                      border: Border.all(
                          color: Get.theme.focusColor.withOpacity(0.05))),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Location".tr,
                                style: Get.textTheme.titleSmall),
                            const SizedBox(height: 5),
                            Text(
                              "${controller.booking.value.address?.address}",
                              style: Get.textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                      MaterialButton(
                        onPressed: () {
                          MapsUtil.openMapsSheet(
                            context,
                            controller.booking.value.address!.getLatLng(),
                            "${controller.booking.value.address?.description}",
                          );
                        },
                        height: 44,
                        minWidth: 44,
                        padding: EdgeInsets.zero,
                        shape: CircleBorder(),
                        color: Get.theme.colorScheme.secondary.withOpacity(0.2),
                        child: Icon(
                          Icons.directions_outlined,
                          color: Get.theme.colorScheme.secondary,
                          size: 20,
                        ),
                        elevation: 0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Stack(
            //       children: [
            //         Container(
            //           height: 200,
            //           width: Get.width,
            //           child: ClipRRect(
            //             borderRadius: BorderRadius.circular(20),
            //             child: GoogleMap(
            //               mapToolbarEnabled: false,
            //               zoomControlsEnabled: true,
            //               zoomGesturesEnabled: true,
            //               myLocationEnabled: true,
            //               padding: EdgeInsets.only(top: 35),
            //               mapType: MapType.normal,
            //               initialCameraPosition: CameraPosition(
            //                 target: LatLng(
            //                     controller.booking.value.address.latitude,
            //                     controller.booking.value.address.longitude),
            //                 zoom: 14.4746,
            //               ),
            //               markers: Set.from(controller.salonMarkers),
            //               onMapCreated: (GoogleMapController _controller) {
            //                 controller.mapController = _controller;
            //               },
            //               onCameraMoveStarted: () {
            //                 // controller.salons.clear();
            //               },
            //               onCameraMove: (CameraPosition cameraPosition) {
            //                 controller.cameraPosition.value = cameraPosition;
            //               },
            //               onCameraIdle: () {
            //                 // controller.getNearSalons();
            //               },
            //             ),
            //           ),
            //         ),
            //         Align(
            //             alignment: Alignment.bottomLeft,
            //             child: Container(
            //               margin: EdgeInsets.only(top: 140, left: 15),
            //               padding: EdgeInsets.all(2),
            //               decoration: BoxDecoration(
            //                   color: Colors.white, shape: BoxShape.circle),
            //               child: IconButton(
            //                 icon: Icon(
            //                   Icons.directions,
            //                   color: Get.theme.focusColor,
            //                   size: 30,
            //                 ),
            //                 onPressed: () {
            //                   try {
            //                     MapsUtil.openMapsSheet(
            //                         Get.context,
            //                         controller.booking.value.address.getLatLng(),
            //                         controller.booking.value.salon.name);
            //                   } catch (e) {
            //                     print(e);
            //                     // Get.showSnackbar(Ui.defaultSnackBar(message: ""))
            //                   }
            //                 },
            //               ),
            //             )),
            //       ],
            //     )
          )
        ],
      ),
    );
  }
}
