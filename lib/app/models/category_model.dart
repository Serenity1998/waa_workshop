import 'package:flutter/material.dart';

import 'e_service_model.dart';
import 'media_model.dart';
import 'parents/model.dart';

class Category extends Model {
  String? id;
  String? name;
  String? description;
  Color? color;
  Media? image;
  List<Media>? banners;
  bool? featured;
  List<Category>? subCategories;
  List<EService>? eServices;

  Category(
      {this.id,
      this.name,
      this.description,
      this.color,
      this.image,
      this.banners,
      this.featured,
      this.subCategories,
      this.eServices});

  List<Media> tempBanners() {
    var tempBanner = this.banners;
    tempBanner?.removeAt(0);
    return tempBanner!;
  }

  Category.fromJson(Map<String, dynamic> json) {
    super.fromJson(json);
    name = transStringFromJson(json, 'name');
    color = colorFromJson(json, 'color');
    description = transStringFromJson(json, 'description');
    image = mediaFromJson(json, 'image');
    banners = mediaListFromJson(json, "media");
    featured = boolFromJson(json, 'featured');
    eServices =
        listFromJson(json, 'featured_e_services', (v) => EService.fromJson(v));
    subCategories =
        listFromJson(json, 'sub_categories', (v) => Category.fromJson(v));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['color'] = '#${this.color?.value.toRadixString(16)}';
    return data;
  }

  // @override
  // bool operator ==(Object other) =>
  //     identical(this, other) ||
  //     super == other &&
  //         other is Category &&
  //         runtimeType == other.runtimeType &&
  //         id == other.id &&
  //         name == other.name &&
  //         description == other.description &&
  //         color == other.color &&
  //         image == other.image &&
  //         featured == other.featured &&
  //         subCategories == other.subCategories &&
  //         eServices == other.eServices;

  // @override
  // int get hashCode =>
  //     super.hashCode ^
  //     id.hashCode ^
  //     name.hashCode ^
  //     description.hashCode ^
  //     color.hashCode ^
  //     image.hashCode ^
  //     featured.hashCode ^
  //     subCategories.hashCode ^
  //     eServices.hashCode;
}
