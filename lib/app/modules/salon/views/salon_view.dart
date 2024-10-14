/*
 * File name: salon_view.dart
 * Last modified: 2022.02.13 at 15:44:07
 * Author: SmarterVision - https://codecanyon.net/user/smartervision
 * Copyright (c) 2022
 */

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import '../../../../common/ui.dart';
import '../../../models/media_model.dart';
import '../../../models/salon_model.dart';
import '../../../routes/app_routes.dart';
import '../../../services/auth_service.dart';
import '../../category/controllers/category_controller.dart';
import '../../global_widgets/block_button_widget.dart';
import '../../global_widgets/circular_loading_widget.dart';
import '../../global_widgets/tab_bar_widget.dart';
import '../controllers/salon_controller.dart';
import '../controllers/salon_e_services_controller.dart';
import '../widgets/salon_title_bar_widget.dart';

class SalonView extends GetView<SalonController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var _salon = controller.salon.value;
      if (!_salon.hasData) {
        return Scaffold(
          body: CircularLoadingWidget(height: Get.height),
        );
      } else {
        return DefaultTabController(
          length: 6,
          child: Scaffold(
            body: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                    pinned: true,
                    floating: false,
                    expandedHeight: 300.0,
                    flexibleSpace: FlexibleSpaceBar(
                      collapseMode: CollapseMode.parallax,
                      background: Obx(() {
                        return Stack(
                          alignment: AlignmentDirectional.bottomCenter,
                          children: <Widget>[
                            buildCarouselSlider(_salon),
                            buildCarouselBullets(_salon),
                          ],
                        );
                      }),
                    )),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (_, int index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 20),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${_salon.name}",
                                  style: Get.textTheme.displayLarge?.merge(
                                      TextStyle(fontWeight: FontWeight.w700)),
                                ),
                                GestureDetector(
                                  onTap: (() {
                                    final categoryController =
                                        Get.find<CategoryController>();
                                    if (!Get.find<AuthService>().isAuth) {
                                      Get.toNamed(Routes.LOGIN);
                                    } else {
                                      if (_salon.isFavorite ?? false) {
                                        controller.removeFromFavorite(_salon);
                                      } else {
                                        controller.addToFavorite(_salon);
                                      }
                                      categoryController.salons
                                          .firstWhere((element) =>
                                              element.id == _salon.id)
                                          .isFavorite = !_salon.isFavorite!;
                                      categoryController.salons.refresh();
                                      controller.salon.refresh();
                                    }
                                  }),
                                  child: Container(
                                    height: 20,
                                    width: 20,
                                    child: SvgPicture.asset(
                                      _salon.isFavorite!
                                          ? "assets/img/ic_bookmark.svg"
                                          : "assets/img/ic_bookmark_blank.svg",
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 24,
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: 2,
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
                                                padding:
                                                    const EdgeInsets.symmetric(
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
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(Icons.star,
                                        color: Colors.orange, size: 15),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: Text(_salon.rate.toString()),
                                    ),
                                    Text(
                                        " ( ${_salon.reviews?.length} сэтгэгдэл")
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                    childCount: 1,
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (_, int index) {
                      return Container(
                        height: 45,
                        width: double.infinity,
                        child: TabBar(
                          tabs: tabs,
                          indicatorWeight: 4,
                          isScrollable: true,
                          onTap: ((value) {
                            controller.currentIndex.value = value;
                          }),
                          padding: EdgeInsets.only(left: 10),
                          indicator: MaterialIndicator(
                            height: 4,
                            topLeftRadius: 8,
                            topRightRadius: 8,
                            color: Get.theme.focusColor,
                            horizontalPadding: 10,
                            tabPosition: TabPosition.bottom,
                          ),
                        ),
                      );
                    },
                    childCount: 1,
                  ),
                ),
                SliverToBoxAdapter(
                  child: controller.pages[controller.currentIndex.value],
                ),
              ],
            ),
            bottomNavigationBar: Obx(() {
              return controller.currentIndex.value != 1
                  ? Container(height: 10)
                  : Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      decoration: BoxDecoration(
                        color: Get.theme.primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                              color: Get.theme.focusColor.withOpacity(0.1),
                              blurRadius: 10,
                              offset: Offset(0, -5)),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 58,
                              child: BlockButtonWidget(
                                  text: "Мессеж".tr,
                                  color: Color(0xffF1E7FF),
                                  onPressed: () {
                                    controller.startChat();
                                  }),
                            ),
                          ),
                          const SizedBox(width: 30),
                          Expanded(
                            child: SizedBox(
                              height: 58,
                              child: BlockButtonWidget(
                                  text: "Захиалга".tr,
                                  color: Get.theme.colorScheme.secondary,
                                  onPressed: () {
                                    var _booking =
                                        Get.find<SalonEServicesController>()
                                            .booking
                                            .value;
                                    Get.toNamed(Routes.BOOK_E_SERVICE,
                                        arguments: {'booking': _booking});
                                  }),
                            ),
                          )
                        ],
                      ),
                    );
            }),
          ),
        );
      }
    });
  }

  CarouselSlider buildCarouselSlider(Salon _salon) {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 7),
        height: 360,
        viewportFraction: 1.0,
        onPageChanged: (index, reason) {
          controller.currentSlide.value = index;
        },
      ),
      items: _salon.images?.map((Media media) {
        return Builder(
          builder: (BuildContext context) {
            return Hero(
              tag: '${controller.heroTag} + ${_salon.id}',
              child: CachedNetworkImage(
                width: double.infinity,
                height: 360,
                fit: BoxFit.cover,
                imageUrl: "${media.url}",
                placeholder: (context, url) => Image.asset(
                  'assets/img/loading.gif',
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
                errorWidget: (context, url, error) => Icon(Icons.error_outline),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Container buildCarouselBullets(Salon _salon) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: _salon.images!.map((Media media) {
          return Container(
            width: 20.0,
            height: 5.0,
            margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 2.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                color: controller.currentSlide.value ==
                        _salon.images?.indexOf(media)
                    ? Get.theme.focusColor
                    : Get.theme.primaryColor.withOpacity(0.4)),
          );
        }).toList(),
      ),
    );
  }

  List<Tab> get tabs {
    return [
      Tab(text: "Дэлгэрэнгүй"),
      Tab(text: "Үйлчилгээ"),
      Tab(text: "Зургийн цомог"),
      Tab(text: "Reviews".tr),
      Tab(text: "Awards".tr),
      Tab(text: "Experiences".tr),
    ];
  }

  SalonTitleBarWidget buildSalonTitleBarWidget(Salon _salon) {
    return SalonTitleBarWidget(
      title: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  _salon.name ?? '',
                  style: Get.textTheme.headlineSmall
                      ?.merge(TextStyle(height: 1.1)),
                  maxLines: 2,
                  softWrap: true,
                  overflow: TextOverflow.fade,
                ),
              ),
              Container(
                child: Text(_salon.salonLevel?.name?.tr ?? ' . . . ',
                    maxLines: 1,
                    style: Get.textTheme.bodyMedium?.merge(
                      TextStyle(
                          color: Get.theme.colorScheme.secondary,
                          height: 1.4,
                          fontSize: 10),
                    ),
                    softWrap: false,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.fade),
                decoration: BoxDecoration(
                  color: Get.theme.colorScheme.secondary.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.end,
                  children: List.from(Ui.getStarsList(_salon.rate ?? 0))
                    ..addAll([
                      SizedBox(width: 5),
                      Text(
                        "Reviews (%s)".trArgs([_salon.totalReviews.toString()]),
                        style: Get.textTheme.bodySmall,
                      ),
                    ]),
                ),
              ),
              Text(
                Ui.getDistance(_salon.distance!),
                style: Get.textTheme.bodySmall,
              ),
            ],
          ),
        ],
      ),
      tabBar: _salon.description == null
          ? TabBarLoadingWidget()
          : TabBarWidget(
              initialSelectedId: 0,
              tag: 'salon',
              tabs: [
                ChipWidget(
                  tag: 'salon',
                  text: "Details".tr,
                  id: 0,
                  onSelected: (id) {
                    controller.changePage(id);
                  },
                ),
                ChipWidget(
                  tag: 'salon',
                  text: "Services".tr,
                  id: 1,
                  onSelected: (id) {
                    controller.changePage(id);
                  },
                ),
                ChipWidget(
                  tag: 'salon',
                  text: "Galleries".tr,
                  id: 2,
                  onSelected: (id) {
                    controller.changePage(id);
                  },
                ),
                ChipWidget(
                  tag: 'salon',
                  text: "Reviews".tr,
                  id: 3,
                  onSelected: (id) {
                    controller.changePage(id);
                  },
                ),
                ChipWidget(
                  tag: 'salon',
                  text: "Awards".tr,
                  id: 4,
                  onSelected: (id) {
                    controller.changePage(id);
                  },
                ),
                ChipWidget(
                  tag: 'salon',
                  text: "Experiences".tr,
                  id: 5,
                  onSelected: (id) {
                    controller.changePage(id);
                  },
                )
              ],
            ),
    );
  }

  Widget buildBottomWidget() {
    var _booking = Get.find<SalonEServicesController>().booking.value;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: Get.theme.primaryColor,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
              color: Get.theme.focusColor.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(0, -5)),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: BlockButtonWidget(
                text: "Place a Booking".tr,
                color: Get.theme.colorScheme.secondary,
                onPressed:
                    // _booking.eServices.isEmpty
                    //     ? null
                    //     :
                    () {
                  print(_booking);
                  Get.toNamed(Routes.BOOK_E_SERVICE,
                      arguments: {'booking': _booking});
                }),
          ),
          SizedBox(width: 20),
          Wrap(
            direction: Axis.vertical,
            spacing: 2,
            children: [
              Text(
                "Subtotal".tr,
                style: Get.textTheme.bodySmall,
              ),
              Ui.getPrice(
                _booking.getSubtotal(),
                style: Get.textTheme.titleLarge!,
              ),
            ],
          )
        ],
      ).paddingSymmetric(horizontal: 20),
    );
  }
}
