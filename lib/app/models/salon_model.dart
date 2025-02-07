/*
 * File name: salon_model.dart
 * Last modified: 2022.02.16 at 22:12:52
 * Author: SmarterVision - https://codecanyon.net/user/smartervision
 * Copyright (c) 2022
 */

import 'dart:core';

import 'address_model.dart';
import 'availability_hour_model.dart';
import 'media_model.dart';
import 'parents/model.dart';
import 'review_model.dart';
import 'salon_level_model.dart';
import 'tax_model.dart';
import 'user_model.dart';

class Salon extends Model {
  String? id;
  String? name;
  String? salonName;
  String? description;
  String? email;
  List<Media>? images;
  String? phoneNumber;
  String? mobileNumber;
  SalonLevel? salonLevel;
  List<AvailabilityHour>? availabilityHours;
  double? availabilityRange;
  bool? available;
  bool? isFavorite;
  double? distance;
  bool? closed;
  bool? featured;
  Address? address;
  List<Tax>? taxes;
  String? logo;

  List<User>? employees;
  double? rate;
  List<Review>? reviews;
  int? totalReviews;
  bool? verified;

  Salon({
    this.id,
    this.name,
    this.salonName,
    this.description,
    this.images,
    this.phoneNumber,
    this.mobileNumber,
    this.salonLevel,
    this.availabilityHours,
    this.availabilityRange,
    this.available,
    this.distance,
    this.isFavorite,
    this.closed,
    this.featured,
    this.address,
    this.logo,
    this.employees,
    this.rate,
    this.email,
    this.reviews,
    this.totalReviews,
    this.verified,
  });

  Salon.fromJson(Map<String, dynamic> json) {
    super.fromJson(json);
    name = transStringFromJson(json, 'name');
    salonName = transStringFromNestedJson(json, 'salon', 'name');
    description = transStringFromJson(json, 'description');
    logo = transStringFromJson(json, 'logo');
    images = mediaListFromJson(json, 'images');
    email = stringFromJson(json, 'email');
    phoneNumber = stringFromJson(json, 'phone_number');
    mobileNumber = stringFromJson(json, 'mobile_number');
    salonLevel =
        objectFromJson(json, 'salon_level', (v) => SalonLevel.fromJson(v));
    availabilityHours = listFromJson(
        json, 'availability_hours', (v) => AvailabilityHour.fromJson(v));
    availabilityRange = doubleFromJson(json, 'availability_range');
    available = boolFromJson(json, 'available');
    distance = doubleFromJson(json, 'distance');
    isFavorite = boolFromJson(json, 'is_favorite');
    closed = boolFromJson(json, 'closed');
    featured = boolFromJson(json, 'featured');
    address = objectFromJson(json, 'address', (v) => Address.fromJson(v));
    taxes = listFromJson(json, 'taxes', (v) => Tax.fromJson(v));
    employees = listFromJson(json, 'users', (v) => User.fromJson(v));
    rate = doubleFromJson(json, 'rate');
    reviews = listFromJson(json, 'salon_reviews', (v) => Review.fromJson(v));
    totalReviews =
        reviews!.isEmpty ? intFromJson(json, 'total_reviews') : reviews?.length;
    verified = boolFromJson(json, 'verified');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['closed'] = this.closed;
    data['phone_number'] = this.phoneNumber;
    data['mobile_number'] = this.mobileNumber;
    data['rate'] = this.rate;
    data['total_reviews'] = this.totalReviews;
    data['verified'] = this.verified;
    data['distance'] = this.distance;
    return data;
  }

  String get firstImageUrl => this.images?.first.url ?? '';

  String get firstImageThumb => this.images?.first.thumb ?? '';

  String get firstImageIcon => this.images?.first.icon ?? '';

  @override
  bool get hasData {
    return id != null && name != null;
  }

  Map<String, List<String>> groupedAvailabilityHours() {
    Map<String, List<String>> result = {};
    availabilityHours?.forEach((element) {
      if (result.containsKey(element.day)) {
        result[element.day]?.add('${element.startAt!} - ${element.endAt!}');
      } else {
        result[element.day!] = ['${element.startAt!} - ${element.endAt!}'];
      }
    });
    return result;
  }

  List<String> getAvailabilityHoursData(String day) {
    List<String> result = [];
    availabilityHours?.forEach((element) {
      if (element.day == day) {
        result.add(element.data!);
      }
    });
    return result;
  }

  // @override
  // bool operator ==(Object other) =>
  //     identical(this, other) ||
  //     super == other &&
  //         other is Salon &&
  //         runtimeType == other.runtimeType &&
  //         id == other.id &&
  //         name == other.name &&
  //         description == other.description &&
  //         images == other.images &&
  //         phoneNumber == other.phoneNumber &&
  //         mobileNumber == other.mobileNumber &&
  //         salonLevel == other.salonLevel &&
  //         availabilityRange == other.availabilityRange &&
  //         distance == other.distance &&
  //         closed == other.closed &&
  //         featured == other.featured &&
  //         address == other.address &&
  //         rate == other.rate &&
  //         reviews == other.reviews &&
  //         totalReviews == other.totalReviews &&
  //         verified == other.verified;

  @override
  int get hashCode =>
      super.hashCode ^
      id.hashCode ^
      name.hashCode ^
      description.hashCode ^
      images.hashCode ^
      phoneNumber.hashCode ^
      mobileNumber.hashCode ^
      salonLevel.hashCode ^
      availabilityRange.hashCode ^
      distance.hashCode ^
      closed.hashCode ^
      featured.hashCode ^
      address.hashCode ^
      rate.hashCode ^
      reviews.hashCode ^
      totalReviews.hashCode ^
      verified.hashCode;
}
