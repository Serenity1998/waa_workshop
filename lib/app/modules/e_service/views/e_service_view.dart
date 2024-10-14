/*
 * File name: e_service_view.dart
 * Last modified: 2022.02.16 at 22:11:22
 * Author: SmarterVision - https://codecanyon.net/user/smartervision
 * Copyright (c) 2022
 */

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../common/ui.dart';
import '../../../models/e_service_model.dart';
import '../../../models/media_model.dart';
import '../../../providers/laravel_provider.dart';
import '../../../routes/app_routes.dart';
import '../../../services/auth_service.dart';
import '../../category/controllers/category_controller.dart';
import '../../global_widgets/block_button_widget.dart';
import '../../global_widgets/circular_loading_widget.dart';
import '../../global_widgets/duration_chip_widget.dart';
import '../../global_widgets/salon_availability_badge_widget.dart';
import '../controllers/e_service_controller.dart';
import '../widgets/e_service_til_widget.dart';
import '../widgets/e_service_title_bar_widget.dart';
import '../widgets/option_group_item_widget.dart';
import '../widgets/salon_item_widget.dart';

class EServiceView extends GetView<EServiceController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var eService = controller.eService.value;
      if (!eService.hasData) {
        return Scaffold(
          body: CircularLoadingWidget(height: Get.height),
        );
      } else {
        return Scaffold(
          bottomNavigationBar: buildBottomWidget(),
          body: RefreshIndicator(
              onRefresh: () async {
                Get.find<LaravelApiClient>().forceRefresh();
                controller.refreshEService(showMessage: true);
                Get.find<LaravelApiClient>().unForceRefresh();
              },
              child: CustomScrollView(
                primary: true,
                shrinkWrap: false,
                slivers: <Widget>[
                  SliverAppBar(
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      expandedHeight: 310,
                      elevation: 0,
                      floating: false,
                      pinned: true,
                      iconTheme:
                          IconThemeData(color: Theme.of(context).primaryColor),
                      centerTitle: true,
                      automaticallyImplyLeading: false,
                      leading: IconButton(
                        icon: Container(
                          decoration:
                              BoxDecoration(shape: BoxShape.circle, boxShadow: [
                            BoxShadow(
                              color: Get.theme.primaryColor.withOpacity(0.5),
                              blurRadius: 20,
                            ),
                          ]),
                          child: Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Get.theme.primaryColor.withOpacity(0.5),
                            ),
                            child: new Icon(Icons.arrow_back,
                                size: 18, color: Get.theme.hintColor),
                          ),
                        ),
                        onPressed: Get.back,
                      ),
                      flexibleSpace: FlexibleSpaceBar(
                        collapseMode: CollapseMode.parallax,
                        background: Obx(() {
                          return Stack(
                            alignment: AlignmentDirectional.bottomCenter,
                            children: <Widget>[
                              buildCarouselSlider(eService),
                              buildCarouselBullets(eService),
                            ],
                          );
                        }),
                      )),
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  "${eService.name}",
                                  style: Get.textTheme.displaySmall!
                                      .merge(TextStyle(fontSize: 24)),
                                ),
                              ),
                              GestureDetector(
                                onTap: (() {
                                  final categoryController =
                                      Get.find<CategoryController>();
                                  if (!Get.find<AuthService>().isAuth) {
                                    Get.toNamed(Routes.LOGIN);
                                  } else {
                                    if (eService.isFavorite ?? false) {
                                      controller.removeFromFavorite(eService);
                                    } else {
                                      controller.addToFavorite(eService);
                                    }
                                    categoryController.eServices
                                        .firstWhere((element) =>
                                            element.id == eService.id)
                                        .isFavorite = !eService.isFavorite!;
                                    categoryController.eServices.refresh();
                                    controller.eService.refresh();
                                  }
                                }),
                                child: Container(
                                  height: 20,
                                  width: 20,
                                  child: SvgPicture.asset(
                                    eService.isFavorite!
                                        ? "assets/img/ic_bookmark.svg"
                                        : "assets/img/ic_bookmark_blank.svg",
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${eService.salon?.name}",
                                      style: Get.textTheme.bodyMedium?.merge(
                                        TextStyle(
                                          color: Get.theme.focusColor,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        height: 13,
                                        width: 13,
                                        child: SvgPicture.asset(
                                          "assets/img/ic_star.svg",
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        eService.salon!.rate!
                                            .toStringAsFixed(1),
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontSize: 10.0,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey[700],
                                            height: 1.2),
                                      ),
                                      Text(
                                        " | ${eService.salon?.reviews!.length.toString()} сэтгэгдэл",
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontSize: 10.0,
                                            fontWeight: FontWeight.w400,
                                            color: Get.theme.hintColor,
                                            height: 1.2),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        buildCategories(eService),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              Ui.getPrice(
                                eService.getPrice!,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Get.theme.focusColor,
                                    height: 1.2),
                              ),
                              if (eService.getOldPrice! > 0)
                                Ui.getPrice(eService.getOldPrice!,
                                    style: TextStyle(
                                        fontSize: 10.0,
                                        fontWeight: FontWeight.w400,
                                        color: Get.theme.hintColor,
                                        height: 1.2)),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text("(${eService.duration})"),
                              )
                            ],
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Divider(),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Text(
                                    "Description".tr,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                                // Row(
                                //   children: [
                                //     Flexible(
                                //       child: Ui.applyHtml(
                                //         _eService.description!,
                                //         style: Get.textTheme.bodyLarge!.merge(
                                //           TextStyle(
                                //             fontSize: 18,
                                //             fontWeight: FontWeight.w400,
                                //           ),
                                //         ),
                                //       ),
                                //     ),
                                //   ],
                                // ),
                                Text("Galleries".tr,
                                        style: Get.textTheme.titleSmall)
                                    .paddingSymmetric(vertical: 20)
                              ],
                            )),
                        Container(
                          height: 120,
                          child: ListView.builder(
                              primary: false,
                              shrinkWrap: false,
                              scrollDirection: Axis.horizontal,
                              itemCount: eService.images?.length,
                              itemBuilder: (_, index) {
                                var _media = eService.images?.elementAt(index);
                                return InkWell(
                                  onTap: () {
                                    Get.toNamed(Routes.GALLERY, arguments: {
                                      'media': eService.images,
                                      'current': _media,
                                      'heroTag': 'e_services_galleries'
                                    });
                                  },
                                  child: Container(
                                    width: 100,
                                    height: 100,
                                    margin: EdgeInsetsDirectional.only(
                                        end: 20,
                                        start: index == 0 ? 20 : 0,
                                        top: 10,
                                        bottom: 10),
                                    child: Stack(
                                      alignment: AlignmentDirectional.topStart,
                                      children: [
                                        Hero(
                                          tag: 'e_services_galleries' +
                                              (_media?.id ?? ''),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            child: CachedNetworkImage(
                                              height: 100,
                                              width: double.infinity,
                                              fit: BoxFit.cover,
                                              imageUrl: "${_media?.thumb}",
                                              placeholder: (context, url) =>
                                                  Image.asset(
                                                'assets/img/loading.gif',
                                                fit: BoxFit.cover,
                                                width: double.infinity,
                                                height: 100,
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error_outline),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        )
                      ],
                    ),
                  ),
                ],
              )),
        );
      }
    });
  }

  Widget buildOptions(EService _eService) {
    return Obx(() {
      if (controller.optionGroups.isEmpty) {
        return const SizedBox();
      }
      return EServiceTilWidget(
        horizontalPadding: 0,
        title: Text("Options".tr, style: Get.textTheme.titleSmall)
            .paddingSymmetric(horizontal: 20),
        content: ListView.separated(
          padding: EdgeInsets.all(0),
          itemBuilder: (context, index) {
            return OptionGroupItemWidget(
                optionGroup: controller.optionGroups.elementAt(index),
                eService: _eService);
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 6);
          },
          itemCount: controller.optionGroups.length,
          primary: false,
          shrinkWrap: true,
        ),
      );
    });
  }

  CarouselSlider buildCarouselSlider(EService _eService) {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 7),
        height: 370,
        viewportFraction: 1.0,
        onPageChanged: (index, reason) {
          controller.currentSlide.value = index;
        },
      ),
      items: _eService.images?.map((Media media) {
        return Builder(
          builder: (BuildContext context) {
            return Hero(
              tag: '${controller.heroTag.value} ${_eService.id}',
              child: CachedNetworkImage(
                width: double.infinity,
                height: 350,
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

  Container buildCarouselBullets(EService _eService) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: _eService.images!.map((Media media) {
          return Container(
            width: 20.0,
            height: 5.0,
            margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 2.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                color: controller.currentSlide.value ==
                        _eService.images?.indexOf(media)
                    ? Get.theme.focusColor
                    : Get.theme.primaryColor.withOpacity(0.4)),
          );
        }).toList(),
      ),
    );
  }

  EServiceTitleBarWidget buildEServiceTitleBarWidget(EService _eService) {
    return EServiceTitleBarWidget(
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  _eService.name ?? '',
                  style: Get.textTheme.headlineSmall
                      ?.merge(TextStyle(height: 1.1)),
                  maxLines: 2,
                  softWrap: true,
                  overflow: TextOverflow.fade,
                ),
              ),
              SalonAvailabilityBadgeWidget(salon: _eService.salon!)
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Expanded(
                child: DurationChipWidget(duration: _eService.duration!),
              ),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 5,
                children: [
                  if (_eService.getOldPrice! > 0)
                    Ui.getPrice(
                      _eService.getOldPrice!,
                      style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                          color: Get.theme.hintColor,
                          height: 1.2),
                    ),
                  Ui.getPrice(
                    _eService.getPrice!,
                    style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                        color: Get.theme.hintColor,
                        height: 1.2),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildCategories(EService _eService) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Wrap(
        alignment: WrapAlignment.start,
        spacing: 5,
        runSpacing: 8,
        children: List.generate(_eService.categories!.length, (index) {
              var _category = _eService.categories!.elementAt(index);
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                child: Text(_category.name!,
                    style: Get.textTheme.bodyLarge!
                        .merge(TextStyle(color: _category.color))),
                decoration: BoxDecoration(
                    color: _category.color?.withOpacity(0.2),
                    border: Border.all(
                      color: _category.color!.withOpacity(0.1),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(5))),
              );
            }) +
            List.generate(_eService.subCategories!.length, (index) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                child: Text("${_eService.subCategories?.elementAt(index).name}",
                    style: Get.textTheme.bodySmall),
                decoration: BoxDecoration(
                    color: Get.theme.primaryColor,
                    border: Border.all(
                      color: Get.theme.focusColor.withOpacity(0.2),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(5))),
              );
            }),
      ),
    );
  }

  Widget buildSalon(EService _eService) {
    if (_eService.salon?.hasData ?? false) {
      return GestureDetector(
        onTap: () {
          Get.toNamed(Routes.SALON, arguments: {
            'salon': _eService.salon,
            'heroTag': 'e_service_details'
          });
        },
        child: EServiceTilWidget(
          title: Text("Service Provider".tr, style: Get.textTheme.titleSmall),
          content: SalonItemWidget(salon: _eService.salon!),
          actions: [
            Text("View More".tr, style: Get.textTheme.titleMedium),
          ],
        ),
      );
    } else {
      return EServiceTilWidget(
        title: Text("Service Provider".tr, style: Get.textTheme.titleSmall),
        content: const SizedBox(height: 60),
        actions: [],
      );
    }
  }

  Widget buildBottomWidget() {
    if (controller.eService.value.enableBooking == null ||
        !controller.eService.value.enableBooking!)
      return const SizedBox();
    else {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                  text: "Мессеж".tr,
                  color: LightFocusColor,
                  onPressed:
                      //  controller.booking.value.eServices.isEmpty
                      //     ? null
                      //     :
                      () {
                    controller.startChat();
                  }),
            ),
            const SizedBox(width: 30),
            Expanded(
              child: BlockButtonWidget(
                  text: "Place a Booking".tr,
                  color: Get.theme.colorScheme.secondary,
                  onPressed:
                      // controller.booking.value.eServices.isEmpty
                      //     ? null
                      //     :
                      () {
                    Get.toNamed(Routes.BOOK_E_SERVICE, arguments: {
                      'booking': controller.booking.value,
                      'salon': controller.eService.value.salon,
                      'serviceId': controller.eService.value.id.toString(),
                      'minuteRange': controller.eService.value.minute_range
                    });
                  }),
            ),
          ],
        ),
      );
    }
  }
}
