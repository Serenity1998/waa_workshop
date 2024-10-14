/*
 * File name: e_service_model.dart
 * Last modified: 2022.03.11 at 22:33:38
 * Author: SmarterVision - https://codecanyon.net/user/smartervision
 * Copyright (c) 2022
 */

import 'category_model.dart';
import 'media_model.dart';
import 'option_group_model.dart';
import 'parents/model.dart';
import 'salon_model.dart';

class EService extends Model {
  String? id;
  String? name;
  String? description;
  List<Media>? images;
  double? price;
  double? discountPrice;
  String? duration;
  bool? featured;
  bool? enableBooking;
  bool? enableAtSalon;
  bool? enableAtCustomerAddress;
  bool? isFavorite;
  bool? enableCustomTime;
  bool? enableEmergency;
  int? minute_range;
  List<Category>? categories;
  List<Category>? subCategories;
  List<OptionGroup>? optionGroups;
  Salon? salon;

  EService({
    this.id,
    this.name,
    this.description,
    this.images,
    this.price,
    this.discountPrice,
    this.duration,
    this.featured,
    this.enableBooking,
    this.enableAtSalon,
    this.enableAtCustomerAddress,
    this.isFavorite,
    this.categories,
    this.subCategories,
    this.optionGroups,
    this.enableEmergency,
    this.enableCustomTime,
    this.minute_range,
    this.salon,
  });

  EService.fromJson(Map<String, dynamic> json) {
    super.fromJson(json);
    name = transStringFromJson(
      json,
      'name',
    );
    description = transStringFromJson(json, 'description');
    images = mediaListFromJson(json, 'images');
    price = doubleFromJson(json, 'price');
    discountPrice = doubleFromJson(json, 'discount_price');
    duration = durationFromJson(json, 'duration');
    featured = boolFromJson(json, 'featured');
    enableBooking = boolFromJson(json, 'enable_booking');
    enableAtSalon = boolFromJson(json, 'enable_at_salon');
    enableCustomTime = boolFromJson(json, 'enable_custom_time');
    enableEmergency = boolFromJson(json, 'enable_emergency');
    enableAtCustomerAddress = boolFromJson(json, 'enable_at_customer_address');
    isFavorite = boolFromJson(json, 'is_favorite');
    categories = listFromJson<Category>(
        json, 'categories', (value) => Category.fromJson(value));
    subCategories = listFromJson<Category>(
        json, 'sub_categories', (value) => Category.fromJson(value));
    optionGroups = listFromJson<OptionGroup>(json, 'option_groups',
        (value) => OptionGroup.fromJson(value, eServiceId: id));
    minute_range = intFromJson(json, 'minute_range');
    salon = objectFromJson(json, 'salon', (value) => Salon.fromJson(value));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (id != null) data['id'] = id;
    if (name != null) data['name'] = name;
    if (description != null) data['description'] = description;
    if (price != null) data['price'] = price;
    if (discountPrice != null) data['discount_price'] = discountPrice;
    if (duration != null) data['duration'] = duration;
    if (featured != null) data['featured'] = featured;
    if (enableBooking != null) data['enable_booking'] = enableBooking;
    if (enableAtSalon != null) data['enable_at_salon'] = enableAtSalon;
    if (enableAtCustomerAddress != null) {
      data['enable_at_customer_address'] = enableAtCustomerAddress;
    }
    if (isFavorite != null) data['is_favorite'] = isFavorite;
    if (categories != null) {
      data['categories'] = categories?.map((v) => v.id).toList();
    }
    data['image'] = images?.map((v) => v.toJson()).toList();
    if (subCategories != null) {
      data['sub_categories'] = subCategories?.map((v) => v.toJson()).toList();
    }
    if (optionGroups != null) {
      data['option_groups'] = optionGroups?.map((v) => v.toJson()).toList();
    }
    if (salon != null && salon!.hasData) {
      data['salon_id'] = salon!.id;
    }
    data['minute_range'] = minute_range;
    return data;
  }

  String get firstImageUrl => images?.first.url ?? '';
  String get firstImageThumb => images?.first.thumb ?? '';
  String get firstImageIcon => images?.first.icon ?? '';

  @override
  bool get hasData {
    return id != null && name != null && description != null;
  }

  /*
  * Get the real price of the service
  * when the discount not set, then it return the price
  * otherwise it return the discount price instead
  * */
  double? get getPrice {
    return (discountPrice ?? 0) > 0 ? discountPrice : price;
  }

  /*
  * Get discount price
  * */
  double? get getOldPrice {
    return (discountPrice ?? 0) > 0 ? price : 0;
  }

  // @override
  // bool operator ==(Object other) =>
  //     identical(this, other) ||
  //     super == other &&
  //         other is EService &&
  //         runtimeType == other.runtimeType &&
  //         id == other.id &&
  //         name == other.name &&
  //         description == other.description &&
  //         isFavorite == other.isFavorite &&
  //         enableBooking == other.enableBooking &&
  //         categories == other.categories &&
  //         subCategories == other.subCategories &&
  //         salon == other.salon;

  @override
  int get hashCode =>
      super.hashCode ^
      id.hashCode ^
      name.hashCode ^
      description.hashCode ^
      salon.hashCode ^
      categories.hashCode ^
      subCategories.hashCode ^
      isFavorite.hashCode ^
      enableBooking.hashCode;
}
