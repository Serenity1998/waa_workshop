/*
 * File name: maps_controller.dart
 * Last modified: 2022.02.26 at 14:50:11
 * Author: SmarterVision - https://codecanyon.net/user/smartervision
 * Copyright (c) 2022
 */

import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import "package:image/image.dart" as IMG;

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as LocationPlatformInterface;
import 'package:permission_handler/permission_handler.dart';

import '../../../../common/ui.dart';
import '../../../models/address_model.dart';
import '../../../models/category_model.dart';
import '../../../models/e_service_model.dart';
import '../../../models/salon_model.dart';
import '../../../repositories/category_repository.dart';
import '../../../repositories/e_service_repository.dart';
import '../../../repositories/salon_repository.dart';
import '../../../services/settings_service.dart';

class MapsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final salons = <Salon>[].obs;
  final eServices = <EService>[].obs;
  var allMarkers = <Marker>[].obs;
  RxInt tabIndex = 0.obs;
  RxBool isService = true.obs;
  RxString statusType = "Үйлчилгээгээр".obs;
  dynamic selectedItem;
  final cameraPosition =
      new CameraPosition(target: LatLng(47.9142979, 106.8922337), zoom: 15).obs;
  final mapController = Rx<GoogleMapController>;
  LocationPlatformInterface.Location location =
      new LocationPlatformInterface.Location();
  LocationPlatformInterface.PermissionStatus permissionGranted =
      LocationPlatformInterface.PermissionStatus.denied;
  ScrollController scrollController = ScrollController();
  final isDone = false.obs;
  final categories = <Category>[].obs;
  late CategoryRepository _categoryRepository;
  late EServiceRepository _eServiceRepository;
  final selectedCategory = <String>[].obs;
  RxBool isList = false.obs;
  RxBool isLoading = true.obs;
  late TabController tabController;
  PageController pageController = PageController(keepPage: true);
  late PermissionStatus status;
  List<String> categoriesId = [];

  bool isLocationServiceEnabled = false;
  late SalonRepository _salonRepository;
  RxString searchText = "".obs;
  late Rx<LatLng> currentLatLng;

  MapsController() {
    _salonRepository = new SalonRepository();
    _eServiceRepository = new EServiceRepository();
    _categoryRepository = new CategoryRepository();
  }

  Address get currentAddress => Get.find<SettingsService>().address.value;

  @override
  void onInit() async {
    categories.value = await _categoryRepository.getAllParents();
    await askPermission();
    await refreshMaps();
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      if (tabController.index != tabIndex) {
        tabIndex.value = tabController.index;
      }
    });
    super.onInit();
  }

  void toggleCategory(bool value, Category category) async {
    if (value) {
      selectedCategory.add(category.id!);
    } else {
      selectedCategory.removeWhere((element) => element == category.id);
    }
    tabController.animateTo(0);
    tabIndex.value = 0;
    await pageController.animateToPage(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeIn,
    );
    await searchEServices();
    await searchSalons();
    selectedItem = null;
  }

  Future<void> askPermission() async {
    Permission permissionLocation = Permission.location;
    status = await permissionLocation.request();
  }

  Future searchEServices() async {
    List<EService> response = [];
    try {
      isLoading.value = true;
      if (selectedCategory.isEmpty) {
        response = await _eServiceRepository.searchServices(
          '',
          categories.map((element) => element.id!).toList(),
        );
      } else {
        response = await _eServiceRepository.searchServices(
          '',
          selectedCategory.toList(),
        );
      }

      eServices.value = response.toList();

      if (!isList.value) getCurrentPosition();
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    } finally {
      isLoading.value = false;
    }
  }

  Future searchSalons() async {
    List<EService> response = [];
    try {
      isLoading.value = true;
      if (selectedCategory.isEmpty) {
        response = (await _eServiceRepository.searchSalons(
          '',
          categories.map((element) => element.id!).toList(),
        ))
            .cast<EService>();
      } else {
        response = (await _eServiceRepository.searchSalons(
          '',
          selectedCategory.toList(),
        ))
            .cast<EService>();
      }

      salons.value = response.cast<Salon>().toList();

      List<Marker> markers = [];
      response.map((element) async {
        var item = await getSalonMarker(element as Salon);
        markers.add(item);
      });
      allMarkers.value = markers;

      if (!isList.value) getCurrentPosition();
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    } finally {
      isLoading.value = false;
    }
  }

  void changeTab() async {
    await searchEServices();
    await searchSalons();
    selectedCategory.clear();
  }

  Future refreshMaps({bool showMessage = false}) async {
    await getCurrentPosition();
    if (showMessage) {
      Get.showSnackbar(
          Ui.SuccessSnackBar(message: "Home page refreshed successfully".tr));
    }
  }

  void navigateCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition();
    // await mapController.value.animateCamera(CameraUpdate.newCameraPosition(
    //   CameraPosition(
    //     target: LatLng(position.latitude, position.longitude),
    //     zoom: 15,
    //   ),
    // ));
  }

  Future<void> getCurrentPosition() async {
    Position position;
    if (status.isGranted) position = await Geolocator.getCurrentPosition();
    // cameraPosition.value = CameraPosition(
    //   target: LatLng(position.latitude, position.longitude),
    //   zoom: 15,
    // );
    // Marker marker = await _getMyPositionMarker(
    //     LatLng(position.latitude, position.longitude));
    // allMarkers.add(marker);
  }

  Future getNearSalons() async {
    try {
      isLoading = true.obs;
      salons.clear();
      // var res = await _eServiceRepository.searchSalons(
      //   '',
      //   selectedCategory.toList(),
      //   lat: cameraPosition.value.target.latitude,
      //   long: cameraPosition.value.target.longitude,
      // );

      var response = await _salonRepository.getNearSalons(
        currentAddress.getLatLng(),
        cameraPosition.value.target,
        searchText.value,
      );
      salons.assignAll(response);

      eServices.value = await _eServiceRepository.searchServices(
        '',
        categories.map((element) => element.id!).toList(),
      );

      response.forEach((element) async {
        var salonMarket = await getSalonMarker(element);
        allMarkers.add(salonMarket);
      });

      isDone.value = true;
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: "${e}"));
    }
    isLoading = false.obs;
  }

  Future<Uint8List> _getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Future<Marker> _getMyPositionMarker(LatLng latLng) async {
    final Uint8List markerIcon =
        await _getBytesFromAsset('assets/img/my_marker.png', 40);
    final Marker marker = Marker(
      markerId: MarkerId(Random().nextInt(100).toString()),
      icon: BitmapDescriptor.fromBytes(markerIcon),
      anchor: ui.Offset(0.5, 0.5),
      position: latLng,
    );

    return marker;
  }

  Future<Marker> getSalonMarker(Salon salon) async {
    // var imageUrl = salon.images.first.url;

    // Uint8List bytes =
    //     (await NetworkAssetBundle(Uri.parse(imageUrl)).load(imageUrl))
    //         .buffer
    //         .asUint8List();

    BitmapDescriptor markerbitmap = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(50, 50)),
      "assets/img_new/ic_map_marker.png",
    );

    final Marker marker = Marker(
      markerId: MarkerId(salon.id!),
      flat: true,
      icon: markerbitmap,
      // await convertImageFileToCustomBitmapDescriptor(
      //   bytes,
      //   borderColor: Get.theme.focusColor,
      //   borderSize: 35,
      //   addBorder: false,
      //   size: 100,
      // ),
      onTap: () {
        selectedItem = salon;
      },
      position: salon.address!.getLatLng(),
    );

    return marker;
  }

  Uint8List? resizeImage(Uint8List data) {
    Uint8List? resizedData = data;
    IMG.Image img = IMG.decodeImage(data)!;
    IMG.Image resized = IMG.copyResize(img, width: 120, height: 120);
    resizedData = IMG.encodeJpg(resized) as Uint8List?;
    return resizedData;
  }

  Future<BitmapDescriptor> convertImageFileToCustomBitmapDescriptor(
      Uint8List imageFile,
      {int size = 150,
      bool addBorder = false,
      Color borderColor = Colors.white,
      double borderSize = 10,
      String? title,
      Color titleColor = Colors.white,
      Color titleBackgroundColor = Colors.black}) async {
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint = Paint()..color;
    final TextPainter textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );
    final double radius = size / 2;

    //make canvas clip path to prevent image drawing over the circle
    final Path clipPath = Path();
    clipPath.addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.toDouble(), size.toDouble()),
        Radius.circular(100)));
    clipPath.addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, size * 8 / 10, size.toDouble(), size * 3 / 10),
        Radius.circular(100)));
    canvas.clipPath(clipPath);

    //paintImage
    final Uint8List imageUint8List = imageFile;
    final ui.Codec codec = await ui.instantiateImageCodec(imageUint8List);
    final ui.FrameInfo imageFI = await codec.getNextFrame();
    paintImage(
        canvas: canvas,
        rect: Rect.fromLTWH(0, 0, size.toDouble(), size.toDouble()),
        image: imageFI.image);

    if (addBorder) {
      //draw Border
      paint..color = borderColor;
      paint..style = PaintingStyle.stroke;
      paint..strokeWidth = borderSize;
      canvas.drawCircle(Offset(radius, radius), radius, paint);
    }

    if (title!.length > 9) {
      title = title.substring(0, 9);
    }
    //draw Title background
    paint..color = titleBackgroundColor;
    paint..style = PaintingStyle.fill;
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromLTWH(0, size * 8 / 10, size.toDouble(), size * 3 / 10),
            Radius.circular(100)),
        paint);

    //draw Title
    textPainter.text = TextSpan(
        text: title,
        style: TextStyle(
          fontSize: radius / 2.5,
          fontWeight: FontWeight.bold,
          color: titleColor,
        ));
    textPainter.layout();
    textPainter.paint(
        canvas,
        Offset(radius - textPainter.width / 2,
            size * 9.5 / 10 - textPainter.height / 2));

    //convert canvas as PNG bytes
    final _image = await pictureRecorder
        .endRecording()
        .toImage(size, (size * 1.1).toInt());
    final data = await _image.toByteData(format: ui.ImageByteFormat.png);

    //convert PNG bytes as BitmapDescriptor
    return BitmapDescriptor.fromBytes(data!.buffer.asUint8List());
  }
}
