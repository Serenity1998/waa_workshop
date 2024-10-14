/*
 * File name: e_service_repository.dart
 * Last modified: 2022.02.04 at 16:43:20
 * Author: SmarterVision - https://codecanyon.net/user/smartervision
 * Copyright (c) 2022
 */

import 'package:get/get.dart';

import '../models/e_service_model.dart';
import '../models/favorite_model.dart';
import '../models/option_group_model.dart';
import '../models/review_model.dart';
import '../models/salon_model.dart';
import '../providers/laravel_provider.dart';

class EServiceRepository {
  late LaravelApiClient _laravelApiClient;

  EServiceRepository() {
    this._laravelApiClient = Get.find<LaravelApiClient>();
  }

  Future<List<EService>> getLatestWithPagination(String categoryId) {
    return _laravelApiClient.getLatestEServices(categoryId);
  }

  Future<List<EService>> getAllWithPagination(String categoryId,
      {int page = 0, List<String>? subcategory}) {
    return _laravelApiClient.getAllEServicesWithPagination(
        categoryId, page, subcategory!);
  }

  Future<List<EService>> searchServices(
    String keywords,
    List<String> categories, {
    int page = 1,
    int review_rate = 0,
    int low_price = 0,
    int max_price = 0,
    bool customer_address = false,
    double lat = 0,
    double long = 0,
  }) async {
    return await _laravelApiClient.searchEServices(
      keywords,
      categories,
      page,
      review_rate: review_rate,
      low_price: low_price,
      max_price: max_price,
      customer_address: customer_address,
      lat: lat,
      long: long,
    );
  }

  Future<List<Salon>> searchSalons(
    String keywords,
    List<String> categories, {
    int page = 1,
    int review_rate = 0,
    int low_price = 0,
    int max_price = 0,
    bool customer_address = false,
    double lat = 0,
    double long = 0,
  }) async {
    return await _laravelApiClient.searchSalons(
      keywords,
      categories,
      page,
      review_rate: review_rate,
      low_price: low_price,
      max_price: max_price,
      customer_address: customer_address,
      lat: lat,
      long: long,
    );
  }

  Future<List<Favorite>> getFavorites() {
    return _laravelApiClient.getFavoritesEServices();
  }

  Future<Favorite> addFavorite(Favorite favorite) {
    return _laravelApiClient.addFavoriteEService(favorite);
  }

  Future<bool> removeFavorite(Favorite favorite) {
    return _laravelApiClient.removeFavoriteEService(favorite);
  }

  Future<List<EService>> getFeatured(String categoryId, {int page = 0}) {
    return _laravelApiClient.getFeaturedEServices(categoryId, page);
  }

  Future<List<EService>> getPopular(String categoryId, {int page = 0}) {
    return _laravelApiClient.getPopularEServices(categoryId, page);
  }

  Future<List<EService>> getMostRated(String categoryId, {int page = 0}) {
    return _laravelApiClient.getMostRatedEServices(categoryId, page);
  }

  Future<List<EService>> getAvailable(String categoryId, {int page = 0}) {
    return _laravelApiClient.getAvailableEServices(categoryId, page);
  }

  Future<List<EService>> getServices(String id) {
    return _laravelApiClient.getEServices(id);
  }

  Future<EService> get(String id) {
    return _laravelApiClient.getEService(id);
  }

  Future<List<Review>> getReviews(String eServiceId) {
    return _laravelApiClient.getEServiceReviews(eServiceId);
  }

  Future<List<OptionGroup>> getOptionGroups(String eServiceId) {
    return _laravelApiClient.getEServiceOptionGroups(eServiceId);
  }
}
