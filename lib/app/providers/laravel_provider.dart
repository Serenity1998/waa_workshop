/*
 * File name: laravel_provider.dart
 * Last modified: 2022.08.18 at 20:21:33
 * Author: SmarterVision - https://codecanyon.net/user/smartervision
 * Copyright (c) 2022
 */

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/foundation.dart' as foundation;
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart' show DateFormat;

import '../../common/uuid.dart';
import '../models/address_model.dart';
import '../models/award_model.dart';
import '../models/booking_model.dart';
import '../models/booking_status_model.dart';
import '../models/category_model.dart';
import '../models/coupon_model.dart';
import '../models/custom_page_model.dart';
import '../models/e_service_model.dart';
import '../models/experience_model.dart';
import '../models/faq_category_model.dart';
import '../models/faq_model.dart';
import '../models/favorite_model.dart';
import '../models/gallery_model.dart';
import '../models/notification_model.dart';
import '../models/option_group_model.dart';
import '../models/payment_method_model.dart';
import '../models/payment_model.dart';
import '../models/review_model.dart';
import '../models/salon_model.dart';
import '../models/salon_user_model.dart';
import '../models/setting_model.dart';
import '../models/slide_model.dart';
import '../models/user_model.dart';
import '../models/wallet_model.dart';
import '../models/wallet_transaction_model.dart';
import '../modules/search/controllers/search_controller.dart';
import 'api_provider.dart';
import 'dio_client.dart';

class LaravelApiClient extends GetxService with ApiClient {
  late DioClient _httpClient;
  late dio.Options _optionsNetwork;
  late dio.Options _optionsCache;

  LaravelApiClient() {
    baseUrl = globalService.baseUrl;
    _httpClient = DioClient(baseUrl, dio.Dio(), interceptors: []);
  }

  Future<LaravelApiClient> init() async {
    _optionsNetwork = _httpClient.optionsNetwork;
    _optionsCache = _httpClient.optionsCache;
    return this;
  }

  bool isLoading({required String task, List<String>? tasks}) {
    return _httpClient.isLoading(task: task, tasks: tasks ?? []);
  }

  void setLocale(String locale) {
    _optionsNetwork.headers?['Accept-Language'] = locale;
    _optionsCache.headers?['Accept-Language'] = locale;
  }

  void forceRefresh() {
    if (!foundation.kIsWeb && !foundation.kDebugMode) {
      _optionsCache = dio.Options(headers: _optionsCache.headers);
      _optionsNetwork = dio.Options(headers: _optionsNetwork.headers);
    }
  }

  void unForceRefresh() {
    // if (!foundation.kIsWeb && !foundation.kDebugMode) {
    //   _optionsNetwork = buildCacheOptions(const Duration(days: 3),
    //       forceRefresh: true, options: _optionsNetwork);
    //   _optionsCache = buildCacheOptions(Duration(minutes: 10),
    //       forceRefresh: false, options: _optionsCache);
    // }
  }

  Future<List<Slide>> getHomeSlider() async {
    Uri uri = getApiBaseUri("slides");
    Get.log(uri.toString());
    var response = await _httpClient.getUri(uri, options: _optionsCache);
    if (response.data['success'] == true) {
      return response.data['data']
          .map<Slide>((obj) => Slide.fromJson(obj))
          .toList();
    } else {
      throw Exception(response.data['message']);
    }
  }

  Future<User> getUser(User user) async {
    if (!authService.isAuth) {
      throw Exception(
          "${"You don't have the permission to access to this area!".tr}[ getUser() ]");
    }
    var queryParameters = {
      'api_token': authService.apiToken,
    };
    Uri uri = getApiBaseUri("user").replace(queryParameters: queryParameters);
    Get.log(uri.toString());
    var response = await _httpClient.getUri(
      uri,
      options: _optionsNetwork,
    );
    if (response.data['success'] == true) {
      return User.fromJson(response.data['data']);
    } else {
      throw Exception(response.data['message']);
    }
  }

  Future<User> login(User user) async {
    Uri uri = getApiBaseUri("login");
    Get.log(uri.toString());
    var response = await _httpClient.postUri(
      uri,
      data: json.encode(user.toJson()),
      options: _optionsNetwork,
    );
    if (response.data['success'] == true) {
      response.data['data']['auth'] = true;
      return User.fromJson(response.data['data']);
    } else {
      throw Exception(response.data['message']);
    }
  }

  Future<User> register(User user) async {
    Uri uri = getApiBaseUri("register");
    Get.log(uri.toString());
    var response = await _httpClient.postUri(
      uri,
      data: json.encode(user.toJson()),
      options: _optionsNetwork,
    );
    if (response.data['success'] == true) {
      response.data['data']['auth'] = true;
      return User.fromJson(response.data['data']);
    } else {
      throw Exception(response.data['message']);
    }
  }

  Future<bool> sendResetLinkEmail(User user) async {
    Uri uri = getApiBaseUri("send_reset_link_email");
    Get.log(uri.toString());
    // to remove other attributes from the user object
    user = User(email: user.email);
    var response = await _httpClient.postUri(
      uri,
      data: json.encode(user.toJson()),
      options: _optionsNetwork,
    );

    if (response.data['success'] == true) {
      return true;
    } else {
      throw Exception(response.data['message']);
    }
  }

  Future<User> updateUser(User user) async {
    if (!authService.isAuth) {
      throw Exception(
          "${"You don't have the permission to access to this area!".tr}[ updateUser() ]");
    }
    var queryParameters = {
      'api_token': authService.apiToken,
    };
    Uri _uri = getApiBaseUri("users/${user.id}")
        .replace(queryParameters: queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.postUri(
      _uri,
      data: json.encode(user.toJson()),
      options: _optionsNetwork,
    );
    if (response.data['success'] == true) {
      response.data['data']['auth'] = true;
      return User.fromJson(response.data['data']);
    } else {
      throw Exception(response.data['message']);
    }
  }

  Future<bool> deleteUser(User user) async {
    if (!authService.isAuth) {
      throw Exception(
          "${"You don't have the permission to access to this area!".tr}[ deleteUser() ]");
    }
    var _queryParameters = {
      'api_token': authService.apiToken,
    };
    Uri _uri =
        getApiBaseUri("users").replace(queryParameters: _queryParameters);
    var response = await _httpClient.deleteUri(
      _uri,
      options: _optionsNetwork,
    );
    if (response.data['success'] == true) {
      return response.data['data'];
    } else {
      throw Exception(response.data['message']);
    }
  }

  Future<List<Address>> getAddresses() async {
    if (!authService.isAuth) {
      throw Exception(
          "${"You don't have the permission to access to this area!".tr}[ getAddresses() ]");
    }
    var _queryParameters = {
      'api_token': authService.apiToken,
      'search': "user_id:${authService.user.value.id}",
      'searchFields': 'user_id:=',
      'orderBy': 'id',
      'sortedBy': 'desc',
    };
    Uri _uri =
        getApiBaseUri("addresses").replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.getUri(_uri, options: _optionsCache);
    if (response.data['success'] == true) {
      return response.data['data']
          .map<Address>((obj) => Address.fromJson(obj))
          .toList();
    } else {
      throw Exception(response.data['message']);
    }
  }

  Future<List<Salon>> getRecommendedSalons() async {
    // final _address = Get.find<SettingsService>().address.value;
    var _queryParameters = {
      'only':
          'id;name;has_media;media;total_reviews;rate;salonLevel;distance;closed',
      'with': 'salonLevel',
      'limit': '6',
    };
    Uri _uri =
        getApiBaseUri("salons").replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.getUri(_uri, options: _optionsCache);
    if (response.data['success'] == true) {
      return response.data['data']
          .map<Salon>((obj) => Salon.fromJson(obj))
          .toList();
    } else {
      throw Exception(response.data['message']);
    }
  }

  Future<List<Salon>> getNearSalons(
      LatLng latLng, LatLng areaLatLng, String search) async {
    var _queryParameters = {
      'only':
          'id;name;has_media;media;total_reviews;rate;salonLevel;address;distance;closed;eservices',
      'with': 'salonLevel;address;eservices',
      'limit': '20',
      'searchFields': "name:like",
    };

    if (search.isNotEmpty) {
      _queryParameters['search'] = search;
    }
    // _queryParameters['myLat'] = latLng.latitude.toString();
    // _queryParameters['myLon'] = latLng.longitude.toString();
    // _queryParameters['areaLat'] = areaLatLng.latitude.toString();
    // _queryParameters['areaLon'] = areaLatLng.longitude.toString();

    Uri _uri =
        getApiBaseUri("salons").replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.getUri(_uri, options: _optionsCache);
    if (response.data['success'] == true) {
      return response.data['data']
          .map<Salon>((obj) => Salon.fromJson(obj))
          .toList();
    } else {
      throw Exception(response.data['message']);
    }
  }

  Future<List<EService>> getLatestEServices(String categoryId) async {
    var queryParameters = {
      'with': 'categories;options;options.media;salon.address',
      'searchFields': 'categories.id:in',
      'limit': '10',
    };
    Uri uri =
        getApiBaseUri("e_services").replace(queryParameters: queryParameters);
    Get.log(uri.toString());
    var response = await _httpClient.getUri(uri, options: _optionsNetwork);
    if (response.data['success'] == true) {
      return response.data['data']['e_services']
          .map<EService>((obj) => EService.fromJson(obj))
          .toList();
    } else {
      throw Exception(response.data['message']);
    }
  }

  Future<List<EService>> getAllEServicesWithPagination(
      String categoryId, int page, List<String> subCategories) async {
    // final _address = Get.find<SettingsService>().address.value;
    var _queryParameters = {
      'with': 'categories;options;options.media;salon.address',
      'searchFields': 'categories.id:in',
      'limit': '4',
      'offset': ((page - 1) * 4).toString()
    };

    if (subCategories.isNotEmpty) {
      _queryParameters['search'] = 'categories.id:${subCategories.join(',')}';
    } else {
      _queryParameters['search'] = 'categories.id:$categoryId';
    }

    /*  if (!_address.isUnknown()) {
      _queryParameters['myLat'] = _address.latitude.toString();
      _queryParameters['myLon'] = _address.longitude.toString();
    }*/
    Uri uri =
        getApiBaseUri("e_services").replace(queryParameters: _queryParameters);
    Get.log(uri.toString());
    var response = await _httpClient.getUri(uri, options: _optionsNetwork);
    if (response.data['success'] == true) {
      return response.data['data']['e_services']
          .map<EService>((obj) => EService.fromJson(obj))
          .toList();
    } else {
      throw Exception(response.data['message']);
    }
  }

  Future<List<EService>> searchEServices(
    String keywords,
    List<String> categories,
    int page, {
    int review_rate = 0,
    int low_price = 0,
    int max_price = 0,
    bool customer_address = false,
    double lat = 0,
    double long = 0,
  }) async {
    Map<String, String> _queryParameters = {
      'with': 'salon;salon.address;categories',
      'search': 'name:$keywords;',
      'searchFields': 'name:like;',
      'min_rate': '1',
      'categories': '${categories.join(',')}',
      'at_salon': '${customer_address ? 0 : 1}',
      'at_customer_address': '${customer_address ? 1 : 0}',
    };

    if (max_price != 0) {
      _queryParameters["max_rate"] = max_price.toString();
    }

    if (review_rate != 0) {
      _queryParameters["review_rate"] = review_rate.toString();
    }

    if (lat != 0) {
      _queryParameters['myLat'] = '$lat';
    }

    if (long != 0) {
      _queryParameters['myLon'] = '$long';
    }

    var _url;
    _url = 'search/e_services';
    if (authService.isAuth) {
      _queryParameters['api_token'] = authService.apiToken;
      _url = 'search/e_services';
    } else {
      _url = 'e_services';
    }

    Uri _uri = getApiBaseUri(_url).replace(queryParameters: _queryParameters);

    Get.log(_uri.toString());
    var response = await _httpClient.getUri(_uri, options: _optionsNetwork);
    if (response.data['success'] == true) {
      return response.data['data']['e_services']
          .map<EService>((obj) => EService.fromJson(obj))
          .toList();
    } else {
      throw Exception(response.data['message']);
    }
  }

  Future<List<Salon>> searchSalons(
    String keywords,
    List<String> categories,
    int page, {
    int review_rate = 0,
    int low_price = 0,
    int max_price = 0,
    bool customer_address = false,
    double lat = 0,
    double long = 0,
  }) async {
    Map<String, String> _queryParameters = {
      'with': 'eServices',
      'search': 'name:$keywords;',
      'searchFields': 'name:like;',
      'min_rate': '1',
      'categories': '${categories.join(',')}',
      'at_salon': '${customer_address ? 0 : 1}',
      'at_customer_address': '${customer_address ? 1 : 0}',
    };

    if (max_price != 0) {
      _queryParameters["max_rate"] = max_price.toString();
    }

    if (review_rate != 0) {
      _queryParameters["review_rate"] = review_rate.toString();
    }

    if (lat != 0) {
      _queryParameters['myLat'] = lat.toString();
    }

    if (long != 0) {
      _queryParameters['myLon'] = long.toString();
    }

    var _url = 'salons';

    Uri _uri = getApiBaseUri(_url).replace(queryParameters: _queryParameters);

    Get.log(_uri.toString());
    var response = await _httpClient.getUri(_uri, options: _optionsNetwork);
    if (response.data['success'] == true) {
      return response.data['data']
          .map<Salon>((obj) => Salon.fromJson(obj))
          .toList();
    } else {
      throw Exception(response.data['message']);
    }
  }

  Future<dynamic> getSearchHistory() async {
    if (!authService.isAuth) {
      throw Exception(
          "${"You don't have the permission to access to this area!".tr}[ getFavoritesEServices() ]");
    }

    var _queryParameters = {
      'api_token': authService.apiToken,
    };

    Uri uri =
        getApiBaseUri('search').replace(queryParameters: _queryParameters);
    Get.log(uri.toString());
    var response = await _httpClient.getUri(uri, options: _optionsNetwork);
    if (response.data['success'] == true) {
      return response.data['data'].toList();
    } else {
      throw Exception(response.data['message']);
    }
  }

  Future<dynamic> deleteSearchHistory(String text) async {
    if (!authService.isAuth) {
      throw Exception(
          "${"You don't have the permission to access to this area!".tr}[ getFavoritesEServices() ]");
    }

    var _queryParameters = {
      'api_token': authService.apiToken,
      'string': text,
    };

    Uri uri =
        getApiBaseUri('search').replace(queryParameters: _queryParameters);
    Get.log(uri.toString());
    var response = await _httpClient.getUri(uri, options: _optionsNetwork);
    if (response.data['success'] == true) {
      Get.put(SearchControllerCustom())
          .searchHistory
          .removeWhere((element) => element['search'] == text);
      getSearchHistory();
      return response.data['data'].toList();
    } else {
      throw Exception(response.data['message']);
    }
  }

  Future<dynamic> deleteAllSearchHistory() async {
    if (!authService.isAuth) {
      throw Exception(
          "${"You don't have the permission to access to this area!".tr}[ getFavoritesEServices() ]");
    }

    var _queryParameters = {
      'api_token': authService.apiToken,
    };

    Uri uri =
        getApiBaseUri('search/all').replace(queryParameters: _queryParameters);
    Get.log(uri.toString());
    var response = await _httpClient.getUri(uri, options: _optionsNetwork);
    if (response.data['success'] == true) {
      Get.put(SearchControllerCustom()).searchHistory.clear();
      Get.put(SearchControllerCustom()).getSearchHistory();
      return true;
    } else {
      throw Exception(response.data['message']);
    }
  }

  Future<List<Favorite>> getFavoritesEServices() async {
    if (!authService.isAuth) {
      throw Exception(
          "${"You don't have the permission to access to this area!".tr}[ getFavoritesEServices() ]");
    }
    var _queryParameters = {
      'with': 'eService;options;eService.salon;salon',
      'search': 'user_id:${authService.user.value.id}',
      'searchFields': 'user_id:=',
      'orderBy': 'created_at',
      'sortBy': 'desc',
      'api_token': authService.apiToken,
    };
    Uri _uri =
        getApiBaseUri("favorites").replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.getUri(_uri, options: _optionsNetwork);
    if (response.data['success'] == true) {
      return response.data['data']
          .map<Favorite>((obj) => Favorite.fromJson(obj))
          .toList();
    } else {
      throw Exception(response.data['message']);
    }
  }

  Future<Favorite> addFavoriteEService(Favorite favorite) async {
    if (!authService.isAuth) {
      throw Exception(
          "${"You must have an account to be able to add services to favorite".tr}[ addFavoriteEService() ]");
    }
    var _queryParameters = {
      'api_token': authService.apiToken,
    };
    Uri _uri =
        getApiBaseUri("favorites").replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.postUri(
      _uri,
      data: json.encode(favorite.toJson()),
      options: _optionsNetwork,
    );
    if (response.data['success'] == true) {
      response.data['data']['auth'] = true;
      return Favorite.fromJson(response.data['data']);
    } else {
      throw Exception(response.data['message']);
    }
  }

  Future<bool> removeFavoriteEService(Favorite favorite) async {
    if (!authService.isAuth) {
      throw Exception(
          "${"You must have an account to be able to add services to favorite".tr}[ removeFavoriteEService() ]");
    }
    var _queryParameters = {
      'api_token': authService.apiToken,
    };
    Uri _uri =
        getApiBaseUri("favorites/1").replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.deleteUri(
      _uri,
      data: json.encode(favorite.toJson()),
      options: _optionsNetwork,
    );
    if (response.data['success'] == true) {
      return response.data['data'];
    } else {
      throw Exception(response.data['message']);
    }
  }

  Future<List<EService>> getEServices(String id) async {
    var _queryParameters = {
      'with':
          'salon;salon.users;salon.address;categories;salon.availabilityHours',
    };
    if (authService.isAuth) {
      _queryParameters['api_token'] = authService.apiToken;
    }
    Uri _uri = getApiBaseUri("e_services/$id")
        .replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.getUri(_uri, options: _optionsNetwork);
    if (response.data['success'] == true) {
      return response.data['data']
          .map<EService>((obj) => EService.fromJson(obj))
          .toList();
    } else {
      throw Exception(response.data['message']);
    }
  }

  Future<EService> getEService(String id) async {
    var _queryParameters = {
      'with':
          'salon;salon.users;salon.address;categories;salon.availabilityHours',
    };
    if (authService.isAuth) {
      _queryParameters['api_token'] = authService.apiToken;
    }
    Uri _uri = getApiBaseUri("e_services/$id")
        .replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.getUri(_uri, options: _optionsNetwork);
    if (response.data['success'] == true) {
      return EService.fromJson(response.data['data']);
    } else {
      throw Exception(response.data['message']);
    }
  }

  Future<Salon> getSalon(String salonId) async {
    const queryParameters = {
      'with': 'salonLevel;availabilityHours;users;address'
    };
    Uri uri = getApiBaseUri("salons/$salonId")
        .replace(queryParameters: queryParameters);
    Get.log(uri.toString());
    var response = await _httpClient.getUri(uri, options: _optionsNetwork);
    if (response.data['success'] == true) {
      return Salon.fromJson(response.data['data']);
    } else {
      throw Exception(response.data['message']);
    }
  }

  Future<dynamic> getSalonsById(List<String> categoryIds) async {
    var _queryParameters = {
      'with': 'eservices;eservices.categories',
      'searchFields': 'eservices.categories.id:in',
      'search': 'eservices.categories.id:${categoryIds.join(',')}',
    };

    Uri _uri =
        getApiBaseUri("salons").replace(queryParameters: _queryParameters);
    var response = await _httpClient.getUri(_uri, options: _optionsNetwork);
    print(_uri);
    print(response);
    if (response.data['success'] == true) {
      return response.data['data']
          .map<Salon>((obj) => Salon.fromJson(obj))
          .toList();
    } else {
      throw Exception(response.data['message']);
    }
  }

  Future<List> getAvailabilityHours(
      String salonId, DateTime date, String serviceId) async {
    var queryParameters = {
      'date': DateFormat('y-MM-dd').format(date),
      'service_id': serviceId
    };
    Uri uri = getApiBaseUri("availability_hours/$salonId")
        .replace(queryParameters: queryParameters);
    Get.log(uri.toString());
    var response = await _httpClient.getUri(uri, options: _optionsNetwork);
    if (response.data['success'] == true) {
      return response.data['data'];
    } else {
      throw Exception(response.data['message']);
    }
  }

  Future<List<Review>> getSalonReviews(String salonId) async {
    var _queryParameters = {
      'with': 'salonReviews;salonReviews.booking;salonReviews.booking.user',
      'only': 'salonReviews',
    };
    Uri _uri = getApiBaseUri("salons/$salonId")
        .replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.getUri(_uri, options: _optionsCache);
    if (response.data['success'] == true) {
      return response.data['data']['salon_reviews']
          .map<Review>((obj) => Review.fromJson(obj))
          .toList();
    } else {
      throw Exception(response.data['message']);
    }
  }

  Future<List<Gallery>> getSalonGalleries(String salonId) async {
    var _queryParameters = {
      'with': 'media',
      'search': 'salon_id:$salonId',
      'searchFields': 'salon_id:=',
      'orderBy': 'updated_at',
      'sortedBy': 'desc',
    };
    Uri _uri =
        getApiBaseUri("galleries").replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.getUri(_uri, options: _optionsCache);
    if (response.data['success'] == true) {
      return response.data['data']
          .map<Gallery>((obj) => Gallery.fromJson(obj))
          .toList();
    } else {
      throw Exception(response.data['message']);
    }
  }

  Future<List<Award>> getSalonAwards(String salonId) async {
    var _queryParameters = {
      'search': 'salon_id:$salonId',
      'searchFields': 'salon_id:=',
      'orderBy': 'updated_at',
      'sortedBy': 'desc',
    };
    Uri _uri =
        getApiBaseUri("awards").replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.getUri(_uri, options: _optionsNetwork);
    if (response.data['success'] == true) {
      return response.data['data']
          .map<Award>((obj) => Award.fromJson(obj))
          .toList();
    } else {
      throw Exception(response.data['message']);
    }
  }

  Future<List<Experience>> getSalonExperiences(String salonId) async {
    var _queryParameters = {
      'search': 'salon_id:$salonId',
      'searchFields': 'salon_id:=',
      'orderBy': 'updated_at',
      'sortedBy': 'desc',
    };
    Uri _uri =
        getApiBaseUri("experiences").replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.getUri(_uri, options: _optionsNetwork);
    if (response.data['success'] == true) {
      return response.data['data']
          .map<Experience>((obj) => Experience.fromJson(obj))
          .toList();
    } else {
      throw Exception(response.data['message']);
    }
  }

  Future<List<EService>> getSalonFeaturedEServices(
      String salonId, List<String> categories, int page) async {
    var _queryParameters = {
      'with':
          'categories;optionGroups;optionGroups.options;optionGroups.options.media',
      'search':
          'categories.id:${categories.join(',')};salon_id:$salonId;featured:1',
      'searchFields': 'categories.id:in;salon_id:=;featured:=',
      'searchJoin': 'and',
      'limit': '4',
      'offset': ((page - 1) * 4).toString()
    };
    Uri _uri =
        getApiBaseUri("e_services").replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.getUri(_uri, options: _optionsCache);
    if (response.data['success'] == true) {
      return response.data['data']
          .map<EService>((obj) => EService.fromJson(obj))
          .toList();
    } else {
      throw Exception(response.data['message']);
    }
  }

  Future<List<EService>> getSalonPopularEServices(
      String salonId, List<String> categories, int page) async {
    var _queryParameters = {
      'with':
          'categories;optionGroups;optionGroups.options;optionGroups.options.media',
      'search': 'categories.id:${categories.join(',')};salon_id:$salonId',
      'searchFields': 'categories.id:in;salon_id:=',
      'searchJoin': 'and',
      'rating': 'true',
      'limit': '4',
      'offset': ((page - 1) * 4).toString()
    };
    Uri _uri =
        getApiBaseUri("e_services").replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.getUri(_uri, options: _optionsCache);
    if (response.data['success'] == true) {
      return response.data['data']
          .map<EService>((obj) => EService.fromJson(obj))
          .toList();
    } else {
      throw Exception(response.data['message']);
    }
  }

  Future<List<EService>> getSalonAvailableEServices(
      String salonId, List<String> categories, int page) async {
    var _queryParameters = {
      'with':
          'categories;optionGroups;optionGroups.options;optionGroups.options.media',
      'search': 'categories.id:${categories.join(',')};salon_id:$salonId',
      'searchFields': 'categories.id:in;salon_id:=',
      'searchJoin': 'and',
      'available_salon': 'true',
      'limit': '4',
      'offset': ((page - 1) * 4).toString()
    };
    Uri _uri =
        getApiBaseUri("e_services").replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.getUri(_uri, options: _optionsNetwork);
    if (response.data['success'] == true) {
      return response.data['data']
          .map<EService>((obj) => EService.fromJson(obj))
          .toList();
    } else {
      throw Exception(response.data['message']);
    }
  }

  Future<List<EService>> getSalonMostRatedEServices(
      String salonId, List<String> categories, int page) async {
    var _queryParameters = {
      //'only': 'id;name;price;discount_price;price_unit;duration;has_media;total_reviews;rate',
      'with':
          'categories;optionGroups;optionGroups.options;optionGroups.options.media',
      'search': 'categories.id:${categories.join(',')};salon_id:$salonId',
      'searchFields': 'categories.id:in;salon_id:=',
      'searchJoin': 'and',
      'rating': 'true',
      'limit': '4',
      'offset': ((page - 1) * 4).toString()
    };
    Uri _uri =
        getApiBaseUri("e_services").replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.getUri(_uri, options: _optionsCache);
    if (response.data['success'] == true) {
      return response.data['data']
          .map<EService>((obj) => EService.fromJson(obj))
          .toList();
    } else {
      throw Exception(response.data['message']);
    }
  }

  Future<List<SalonUser>> getSalonUsers(String salonId) async {
    Uri _uri = getApiBaseUri("salons/$salonId");
    printUri(StackTrace.current, _uri);
    var response = await _httpClient.getUri(_uri, options: _optionsNetwork);
    if (response.data['success'] == true) {
      return response.data['data']['salon_users']
          .map<SalonUser>((obj) => SalonUser.fromJson(obj))
          .toList();
    } else {
      throw Exception(response.data['message']);
    }
  }

  Future<List<User>> getSalonEmployees(String salonId) async {
    Uri _uri = getApiBaseUri("salons/$salonId");
    printUri(StackTrace.current, _uri);
    var response = await _httpClient.getUri(_uri, options: _optionsNetwork);
    if (response.data['success'] == true) {
      return response.data['data']['users']
          .map<SalonUser>((obj) => User.fromJson(obj))
          .toList();
    } else {
      throw Exception(response.data['message']);
    }
  }

  Future<List<EService>> getSalonEServices(
      String salonId, List<String> categories, int page) async {
    var _queryParameters = {
      'with':
          'categories;optionGroups;optionGroups.options;optionGroups.options.media',
      'search': 'categories.id:${categories.join(',')};salon_id:$salonId',
      'searchFields': 'categories.id:in;salon_id:=',
      'searchJoin': 'and',
      'limit': '4',
      'offset': ((page - 1) * 4).toString()
    };
    print("sdadadsasdasadsadasdas  $_queryParameters");
    Uri _uri =
        getApiBaseUri("e_services").replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.getUri(_uri, options: _optionsCache);
    print('haral idesn res: $response');
    if (response.data['success'] == true) {
      return response.data['data']['e_services']
          .map<EService>((obj) => EService.fromJson(obj))
          .toList();
    } else {
      throw Exception(response.data['message']);
    }
  }

  Future<List<Review>> getEServiceReviews(String eServiceId) async {
    var _queryParameters = {
      'with': 'user',
      'only': 'created_at;review;rate;user',
      'search': "e_service_id:$eServiceId",
      'orderBy': 'created_at',
      'sortBy': 'desc',
      'limit': '10'
    };
    Uri _uri = getApiBaseUri("e_service_reviews")
        .replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.getUri(_uri, options: _optionsCache);
    if (response.data['success'] == true) {
      return response.data['data']
          .map<Review>((obj) => Review.fromJson(obj))
          .toList();
    } else {
      throw Exception(response.data['message']);
    }
  }

  Future<List<OptionGroup>> getEServiceOptionGroups(String eServiceId) async {
    var _queryParameters = {
      'with': 'options;options.media',
      'only':
          'id;name;allow_multiple;options.id;options.name;options.description;options.price;options.option_group_id;options.e_service_id;options.media',
      'search': "options.e_service_id:$eServiceId",
      'searchFields': 'options.e_service_id:=',
      'orderBy': 'name',
      'sortBy': 'desc'
    };
    Uri _uri = getApiBaseUri("option_groups")
        .replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.getUri(_uri, options: _optionsCache);
    if (response.data['success'] == true) {
      return response.data['data']
          .map<OptionGroup>((obj) => OptionGroup.fromJson(obj))
          .toList();
    } else {
      throw Exception(response.data['message']);
    }
  }

  Future<List<EService>> getFeaturedEServices(
      String categoryId, int page) async {
    // final _address = Get.find<SettingsService>().address.value;
    var _queryParameters = {
      //'only': 'id;name;price;discount_price;price_unit;duration;has_media;total_reviews;rate',
      'with': 'salon;salon.address;categories',
      'search': 'categories.id:$categoryId;featured:1',
      'searchFields': 'categories.id:=;featured:=',
      'searchJoin': 'and',
      'limit': '4',
      'offset': ((page - 1) * 4).toString()
    };
    /* if (!_address.isUnknown()) {
      _queryParameters['myLat'] = _address.latitude.toString();
      _queryParameters['myLon'] = _address.longitude.toString();
    }*/
    Uri _uri =
        getApiBaseUri("e_services").replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.getUri(_uri, options: _optionsCache);
    if (response.data['success'] == true) {
      return response.data['data']
          .map<EService>((obj) => EService.fromJson(obj))
          .toList();
    } else {
      throw Exception(response.data['message']);
    }
  }

  Future<List<EService>> getPopularEServices(
      String categoryId, int page) async {
    // final _address = Get.find<SettingsService>().address.value;
    var _queryParameters = {
      //'only': 'id;name;price;discount_price;price_unit;duration;has_media;total_reviews;rate',
      'with': 'salon;salon.address;categories',
      'search': 'categories.id:$categoryId',
      'searchFields': 'categories.id:=',
      'rating': 'true',
      'limit': '4',
      'offset': ((page - 1) * 4).toString()
    };
    /* if (!_address.isUnknown()) {
      _queryParameters['myLat'] = _address.latitude.toString();
      _queryParameters['myLon'] = _address.longitude.toString();
    }*/
    Uri _uri =
        getApiBaseUri("e_services").replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.getUri(_uri, options: _optionsCache);
    if (response.data['success'] == true) {
      return response.data['data']
          .map<EService>((obj) => EService.fromJson(obj))
          .toList();
    } else {
      throw Exception(response.data['message']);
    }
  }

  Future<List<EService>> getMostRatedEServices(
      String categoryId, int page) async {
    // final _address = Get.find<SettingsService>().address.value;
    var _queryParameters = {
      //'only': 'id;name;price;discount_price;price_unit;duration;has_media;total_reviews;rate',
      'with': 'salon;salon.address;categories',
      'search': 'categories.id:$categoryId',
      'searchFields': 'categories.id:=',
      'rating': 'true',
      'limit': '4',
      'offset': ((page - 1) * 4).toString()
    };
    /*if (!_address.isUnknown()) {
      _queryParameters['myLat'] = _address.latitude.toString();
      _queryParameters['myLon'] = _address.longitude.toString();
    }*/
    Uri _uri =
        getApiBaseUri("e_services").replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.getUri(_uri, options: _optionsCache);
    if (response.data['success'] == true) {
      return response.data['data']
          .map<EService>((obj) => EService.fromJson(obj))
          .toList();
    } else {
      throw Exception(response.data['message']);
    }
  }

  Future<List<EService>> getAvailableEServices(
      String categoryId, int page) async {
    // final _address = Get.find<SettingsService>().address.value;
    var _queryParameters = {
      'with': 'salon;salon.address;categories',
      'search': 'categories.id:$categoryId',
      'searchFields': 'categories.id:=',
      'available_salon': 'true',
      'limit': '4',
      'offset': ((page - 1) * 4).toString()
    };
    /*if (!_address.isUnknown()) {
      _queryParameters['myLat'] = _address.latitude.toString();
      _queryParameters['myLon'] = _address.longitude.toString();
    }*/
    Uri _uri =
        getApiBaseUri("e_services").replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.getUri(_uri, options: _optionsNetwork);
    if (response.data['success'] == true) {
      return response.data['data']
          .map<EService>((obj) => EService.fromJson(obj))
          .toList();
    } else {
      throw Exception(response.data['message']);
    }
  }

  Future<List<Category>> getAllCategories() async {
    const _queryParameters = {
      'orderBy': 'order',
      'sortBy': 'asc',
    };
    Uri _uri =
        getApiBaseUri("categories").replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.getUri(_uri, options: _optionsCache);
    if (response.data['success'] == true) {
      return response.data['data']
          .map<Category>((obj) => Category.fromJson(obj))
          .toList();
    } else {
      throw Exception(response.data['message']);
    }
  }

  Future<List<Category>> getAllParentCategories() async {
    const _queryParameters = {
      'parent': 'true',
      'orderBy': 'order',
      'sortBy': 'asc',
    };
    Uri _uri =
        getApiBaseUri("categories").replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.getUri(_uri, options: _optionsCache);
    if (response.data['success'] == true) {
      return response.data['data']
          .map<Category>((obj) => Category.fromJson(obj))
          .toList();
    } else {
      throw Exception(response.data['message']);
    }
  }

  Future<List<Category>> getSubCategories(String categoryId) async {
    final _queryParameters = {
      'search': "parent_id:$categoryId",
      'searchFields': "parent_id:=",
      'orderBy': 'order',
      'sortBy': 'asc',
    };
    Uri _uri =
        getApiBaseUri("categories").replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.getUri(_uri, options: _optionsCache);
    if (response.data['success'] == true) {
      return response.data['data']
          .map<Category>((obj) => Category.fromJson(obj))
          .toList();
    } else {
      throw Exception(response.data['message']);
    }
  }

  Future<List<Category>> getAllWithSubCategories() async {
    const _queryParameters = {
      'with': 'subCategories',
      'parent': 'true',
      'orderBy': 'order',
      'sortBy': 'asc',
    };
    Uri _uri =
        getApiBaseUri("categories").replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.getUri(_uri, options: _optionsCache);
    if (response.data['success'] == true) {
      return response.data['data']
          .map<Category>((obj) => Category.fromJson(obj))
          .toList();
    } else {
      throw Exception(response.data['message']);
    }
  }

  Future<List<Category>> getFeaturedCategories() async {
    // final _address = Get.find<SettingsService>().address.value;
    var _queryParameters = {
      'with': 'featuredEServices',
      'parent': 'true',
      'search': 'featured:1',
      'searchFields': 'featured:=',
      'orderBy': 'order',
      'sortedBy': 'asc',
    };
    /* if (!_address.isUnknown()) {
      _queryParameters['myLat'] = _address.latitude.toString();
      _queryParameters['myLon'] = _address.longitude.toString();
    }*/
    Uri _uri =
        getApiBaseUri("categories").replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.getUri(_uri, options: _optionsCache);
    if (response.data['success'] == true) {
      return response.data['data']
          .map<Category>((obj) => Category.fromJson(obj))
          .toList();
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<List<Booking>> getBookings(int statusId, int page) async {
    var _queryParameters = {
      'with': 'bookingStatus;payment;payment.paymentStatus;employee',
      'api_token': authService.apiToken,
      'orderBy': 'created_at',
      'sortedBy': 'desc',
      'limit': '4',
      'offset': ((page - 1) * 4).toString()
    };
    _queryParameters["search"] = 'booking_status_id:${statusId}';
    Uri _uri =
        getApiBaseUri("bookings").replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.getUri(_uri, options: _optionsNetwork);
    if (response.data['success'] == true) {
      return response.data['data']
          .map<Booking>((obj) => Booking.fromJson(obj))
          .toList();
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<List<BookingStatus>> getBookingStatuses() async {
    var _queryParameters = {
      'only': 'id;status;order',
      'orderBy': 'order',
      'sortedBy': 'asc',
    };
    Uri _uri = getApiBaseUri("booking_statuses")
        .replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.getUri(_uri, options: _optionsCache);
    if (response.data['success'] == true) {
      return response.data['data']
          .map<BookingStatus>((obj) => BookingStatus.fromJson(obj))
          .toList();
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<Booking> getBooking(String bookingId) async {
    var _queryParameters = {
      'with':
          'bookingStatus;user;employee;payment;payment.paymentMethod;payment.paymentStatus',
      'api_token': authService.apiToken,
    };
    Uri _uri = getApiBaseUri("bookings/${bookingId}")
        .replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.getUri(_uri, options: _optionsNetwork);
    if (response.data['success'] == true) {
      return Booking.fromJson(response.data['data']);
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<Coupon> validateCoupon(Booking booking) async {
    var _queryParameters = {
      'api_token': authService.apiToken,
      'code': booking.coupon?.code ?? '',
      'e_services_id': booking.eServices?.map((e) => e.id).join(",") ?? '',
      'salon_id': booking.salon?.id ?? '',
      'categories_id': booking.eServices!
          .expand((element) => element.categories! + element.subCategories!)
          .map((e) => e.id)
          .join(","),
    };
    Uri uri =
        getApiBaseUri("coupons").replace(queryParameters: _queryParameters);
    Get.log(uri.toString());
    var response = await _httpClient.getUri(uri, options: _optionsNetwork);
    if (response.data['success'] == true) {
      return Coupon.fromJson(response.data['data']);
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<Booking> updateBooking(Booking booking) async {
    if (!authService.isAuth) {
      throw new Exception(
          "You don't have the permission to access to this area!".tr +
              "[ updateBooking() ]");
    }
    var _queryParameters = {
      'api_token': authService.apiToken,
    };
    print(booking.toJson());
    Uri _uri = getApiBaseUri("bookings/${booking.id}")
        .replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.putUri(_uri,
        data: booking.toJson(), options: _optionsNetwork);
    if (response.data['success'] == true) {
      return Booking.fromJson(response.data['data']);
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<Booking> addBooking(Booking booking) async {
    if (!authService.isAuth) {
      throw new Exception("Нэвтэрч орно уу" + "[ addBooking() ]");
    }
    var _queryParameters = {
      'api_token': authService.apiToken,
    };
    Uri _uri =
        getApiBaseUri("bookings").replace(queryParameters: _queryParameters);
    var response = await _httpClient.postUri(_uri,
        data: booking.toJson(), options: _optionsNetwork);
    if (response.data['success'] == true) {
      return Booking.fromJson(response.data['data']);
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<Review> addReview(Review review) async {
    if (!authService.isAuth) {
      throw new Exception(
          "You don't have the permission to access to this area!".tr +
              "[ addReview() ]");
    }
    var _queryParameters = {
      'api_token': authService.apiToken,
    };
    Uri _uri = getApiBaseUri("salon_reviews")
        .replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    Get.log(review.toJson().toString());
    var response = await _httpClient.postUri(_uri,
        data: review.toJson(), options: _optionsNetwork);
    if (response.data['success'] == true) {
      return Review.fromJson(response.data['data']);
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<List<PaymentMethod>> getPaymentMethods() async {
    if (!authService.isAuth) {
      throw new Exception(
          "You don't have the permission to access to this area!".tr +
              "[ getPaymentMethods() ]");
    }
    var _queryParameters = {
      'with': 'media',
      'search': 'enabled:1',
      'searchFields': 'enabled:=',
      'orderBy': 'order',
      'sortBy': 'asc',
      'api_token': authService.apiToken,
    };
    Uri _uri = getApiBaseUri("payment_methods")
        .replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.getUri(_uri, options: _optionsCache);
    if (response.data['success'] == true) {
      return response.data['data']
          .map<PaymentMethod>((obj) => PaymentMethod.fromJson(obj))
          .toList();
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<List<Wallet>> getWallets() async {
    if (!authService.isAuth) {
      throw new Exception(
          "You don't have the permission to access to this area!".tr +
              "[ getWallets() ]");
    }
    var _queryParameters = {
      'api_token': authService.apiToken,
    };
    Uri _uri =
        getApiBaseUri("wallets").replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.getUri(_uri, options: _optionsCache);
    if (response.data['success'] == true) {
      return response.data['data']
          .map<Wallet>((obj) => Wallet.fromJson(obj))
          .toList();
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<Wallet> createWallet(Wallet _wallet) async {
    if (!authService.isAuth) {
      throw new Exception(
          "You don't have the permission to access to this area!".tr +
              "[ createWallet() ]");
    }
    var _queryParameters = {
      'api_token': authService.apiToken,
    };
    Uri _uri =
        getApiBaseUri("wallets").replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.postUri(_uri,
        data: _wallet.toJson(), options: _optionsNetwork);
    if (response.data['success'] == true) {
      return Wallet.fromJson(response.data['data']);
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<Wallet> updateWallet(Wallet _wallet) async {
    if (!authService.isAuth) {
      throw new Exception(
          "You don't have the permission to access to this area!".tr +
              "[ updateWallet() ]");
    }
    var _queryParameters = {
      'api_token': authService.apiToken,
    };
    Uri _uri = getApiBaseUri("wallets/${_wallet.id}")
        .replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.putUri(_uri,
        data: _wallet.toJson(), options: _optionsNetwork);
    if (response.data['success'] == true) {
      return Wallet.fromJson(response.data['data']);
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<bool> deleteWallet(Wallet _wallet) async {
    if (!authService.isAuth) {
      throw new Exception(
          "You don't have the permission to access to this area!".tr +
              "[ deleteWallet() ]");
    }
    var _queryParameters = {
      'api_token': authService.apiToken,
    };
    Uri _uri = getApiBaseUri("wallets/${_wallet.id}")
        .replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.deleteUri(_uri, options: _optionsNetwork);
    if (response.data['success'] == true) {
      return response.data['data'];
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<List<WalletTransaction>> getWalletTransactions(Wallet wallet) async {
    if (!authService.isAuth) {
      throw new Exception(
          "You don't have the permission to access to this area!".tr +
              "[ getWalletTransactions() ]");
    }
    var _queryParameters = {
      'api_token': authService.apiToken,
      'with': 'user',
      'search': 'wallet_id:${wallet.id}',
      'searchFields': 'wallet_id:=',
    };
    Uri _uri = getApiBaseUri("wallet_transactions")
        .replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.getUri(_uri, options: _optionsNetwork);
    if (response.data['success'] == true) {
      return response.data['data']
          .map<WalletTransaction>((obj) => WalletTransaction.fromJson(obj))
          .toList();
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<Payment> createPayment(Booking _booking) async {
    if (!authService.isAuth) {
      throw new Exception(
          "You don't have the permission to access to this area!".tr +
              "[ createPayment() ]");
    }
    var _queryParameters = {
      'api_token': authService.apiToken,
    };
    Uri _uri = getApiBaseUri("payments/cash")
        .replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.postUri(_uri,
        data: _booking.toJson(), options: _optionsNetwork);
    if (response.data['success'] == true) {
      return Payment.fromJson(response.data['data']);
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<Payment> createWalletPayment(Booking _booking, Wallet _wallet) async {
    if (!authService.isAuth) {
      throw new Exception(
          "You don't have the permission to access to this area!".tr +
              "[ createPayment() ]");
    }
    var _queryParameters = {
      'api_token': authService.apiToken,
    };
    Uri _uri = getApiBaseUri("payments/wallets/${_wallet.id}")
        .replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.postUri(_uri,
        data: _booking.toJson(), options: _optionsNetwork);
    if (response.data['success'] == true) {
      return Payment.fromJson(response.data['data']);
    } else {
      throw new Exception(response.data['message']);
    }
  }

  String getPayPalUrl(Booking _booking) {
    if (!authService.isAuth) {
      throw new Exception(
          "You don't have the permission to access to this area!".tr +
              "[ getPayPalUrl() ]");
    }
    var _queryParameters = {
      'api_token': authService.apiToken,
      'booking_id': _booking.id,
    };
    Uri _uri = getBaseUri("payments/paypal/express-checkout")
        .replace(queryParameters: _queryParameters);
    return _uri.toString();
  }

  String getRazorPayUrl(Booking _booking) {
    if (!authService.isAuth) {
      throw new Exception(
          "You don't have the permission to access to this area!".tr +
              "[ getRazorPayUrl() ]");
    }
    var _queryParameters = {
      'api_token': authService.apiToken,
      'booking_id': _booking.id,
    };
    Uri _uri = getBaseUri("payments/razorpay/checkout")
        .replace(queryParameters: _queryParameters);
    return _uri.toString();
  }

  String getStripeUrl(Booking _booking) {
    if (!authService.isAuth) {
      throw new Exception(
          "You don't have the permission to access to this area!".tr +
              "[ getStripeUrl() ]");
    }
    var _queryParameters = {
      'api_token': authService.apiToken,
      'booking_id': _booking.id,
    };
    Uri _uri = getBaseUri("payments/stripe/checkout")
        .replace(queryParameters: _queryParameters);
    return _uri.toString();
  }

  String getPayStackUrl(Booking _booking) {
    if (!authService.isAuth) {
      throw new Exception(
          "You don't have the permission to access to this area!".tr +
              "[ getPayStackUrl() ]");
    }
    var _queryParameters = {
      'api_token': authService.apiToken,
      'booking_id': _booking.id,
    };
    Uri _uri = getBaseUri("payments/paystack/checkout")
        .replace(queryParameters: _queryParameters);
    return _uri.toString();
  }

  String getPayMongoUrl(Booking _booking) {
    if (!authService.isAuth) {
      throw new Exception(
          "You don't have the permission to access to this area!".tr +
              "[ getPayMongoUrl() ]");
    }
    var _queryParameters = {
      'api_token': authService.apiToken,
      'booking_id': _booking.id,
    };
    Uri _uri = getBaseUri("payments/paymongo/checkout")
        .replace(queryParameters: _queryParameters);
    return _uri.toString();
  }

  String getFlutterWaveUrl(Booking _booking) {
    if (!authService.isAuth) {
      throw new Exception(
          "You don't have the permission to access to this area!".tr +
              "[ getFlutterWaveUrl() ]");
    }
    var _queryParameters = {
      'api_token': authService.apiToken,
      'booking_id': _booking.id,
    };
    Uri _uri = getBaseUri("payments/flutterwave/checkout")
        .replace(queryParameters: _queryParameters);
    return _uri.toString();
  }

  String getStripeFPXUrl(Booking _booking) {
    if (!authService.isAuth) {
      throw new Exception(
          "You don't have the permission to access to this area!".tr +
              "[ getStripeFPXUrl() ]");
    }
    var _queryParameters = {
      'api_token': authService.apiToken,
      'booking_id': _booking.id,
    };
    Uri _uri = getBaseUri("payments/stripe-fpx/checkout")
        .replace(queryParameters: _queryParameters);
    return _uri.toString();
  }

  Future<List<Notification>> getNotifications() async {
    if (!authService.isAuth) {
      throw new Exception(
          "You don't have the permission to access to this area!".tr +
              "[ getNotifications() ]");
    }
    var _queryParameters = {
      'search': 'notifiable_id:${authService.user.value.id}',
      'searchFields': 'notifiable_id:=',
      'searchJoin': 'and',
      'orderBy': 'created_at',
      'sortedBy': 'desc',
      'limit': '50',
      'only': 'id;type;data;read_at;created_at',
      'api_token': authService.apiToken,
    };
    Uri _uri = getApiBaseUri("notifications")
        .replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.getUri(_uri, options: null);
    if (response.data['success'] == true) {
      return response.data['data']
          .map<Notification>((obj) => Notification.fromJson(obj))
          .toList();
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<Notification> markAsReadNotification(Notification notification) async {
    if (!authService.isAuth) {
      throw new Exception(
          "You don't have the permission to access to this area!".tr +
              "[ markAsReadNotification() ]");
    }
    var _queryParameters = {
      'api_token': authService.apiToken,
    };
    Uri _uri = getApiBaseUri("notifications/${notification.id}")
        .replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.putUri(_uri,
        data: notification.markReadMap(), options: _optionsNetwork);
    if (response.data['success'] == true) {
      return Notification.fromJson(response.data['data']);
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<bool> sendNotification(
      List<User> users, User from, String type, String text, String id) async {
    if (!authService.isAuth) {
      throw new Exception(
          "You don't have the permission to access to this area!".tr +
              "[ sendNotification() ]");
    }
    var _queryParameters = {
      'api_token': authService.apiToken,
    };
    var data = {
      'users': users.map((e) => e.id).toList(),
      'from': from.id,
      'type': type,
      'text': text,
      'id': id,
    };
    Uri _uri = getApiBaseUri("notifications")
        .replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    Get.log(data.toString());
    var response =
        await _httpClient.postUri(_uri, data: data, options: _optionsNetwork);
    if (response.data['success'] == true) {
      return true;
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<Notification> removeNotification(Notification notification) async {
    if (!authService.isAuth) {
      throw new Exception(
          "You don't have the permission to access to this area!".tr +
              "[ removeNotification() ]");
    }
    var _queryParameters = {
      'api_token': authService.apiToken,
    };
    Uri _uri = getApiBaseUri("notifications/${notification.id}")
        .replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.deleteUri(_uri, options: _optionsNetwork);
    if (response.data['success'] == true) {
      return Notification.fromJson(response.data['data']);
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<int> getNotificationsCount() async {
    print(authService.isAuth);
    if (!authService.isAuth) {
      return 0;
    }
    var _queryParameters = {
      'search': 'notifiable_id:${authService.user.value.id}',
      'searchFields': 'notifiable_id:=',
      'searchJoin': 'and',
      'api_token': authService.apiToken,
    };
    Uri _uri = getApiBaseUri("notifications/count")
        .replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.getUri(_uri, options: _optionsNetwork);
    if (response.data['success'] == true) {
      return response.data['data'];
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<List<FaqCategory>> getFaqCategories() async {
    var _queryParameters = {
      'orderBy': 'created_at',
      'sortedBy': 'asc',
    };
    Uri _uri = getApiBaseUri("faq_categories")
        .replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.getUri(_uri, options: _optionsCache);
    if (response.data['success'] == true) {
      return response.data['data']
          .map<FaqCategory>((obj) => FaqCategory.fromJson(obj))
          .toList();
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<List<Faq>> getFaqs(String categoryId) async {
    var _queryParameters = {
      'search': 'faq_category_id:${categoryId}',
      'searchFields': 'faq_category_id:=',
      'searchJoin': 'and',
      'orderBy': 'updated_at',
      'sortedBy': 'desc',
    };
    Uri _uri = getApiBaseUri("faqs").replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.getUri(_uri, options: _optionsCache);
    if (response.data['success'] == true) {
      return response.data['data']
          .map<Faq>((obj) => Faq.fromJson(obj))
          .toList();
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<Setting> getSettings() async {
    Uri _uri = getApiBaseUri("settings");
    Get.log(_uri.toString());

    print("URssI : $_uri");
    var response = await _httpClient.getUri(_uri, options: _optionsNetwork);
    if (response.data['success'] == true) {
      log(json.encode(response.data['data']));

      return Setting.fromJson(response.data['data']);
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<Map<String, String>> getTranslations(String locale) async {
    var _queryParameters = {
      'locale': locale,
    };
    Uri _uri = getApiBaseUri("translations")
        .replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.getUri(_uri, options: _optionsCache);
    if (response.data['success'] == true) {
      return Map<String, String>.from(response.data['data']);
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<List<String>> getSupportedLocales() async {
    Uri _uri = getApiBaseUri("supported_locales");
    Get.log(_uri.toString());
    var response = await _httpClient.getUri(_uri, options: _optionsCache);
    if (response.data['success'] == true) {
      print('laar: $response');
      return List.from(response.data['data']);
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<List<CustomPage>> getCustomPages() async {
    var _queryParameters = {
      'only': 'id;title',
      'search': 'published:1',
      'orderBy': 'created_at',
      'sortedBy': 'asc',
    };
    Uri _uri = getApiBaseUri("custom_pages")
        .replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.getUri(_uri, options: _optionsCache);
    if (response.data['success'] == true) {
      return response.data['data']
          .map<CustomPage>((obj) => CustomPage.fromJson(obj))
          .toList();
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<CustomPage> getCustomPageById(String id) async {
    Uri _uri = getApiBaseUri("custom_pages/$id");
    Get.log(_uri.toString());
    var response = await _httpClient.getUri(_uri, options: _optionsCache);
    if (response.data['success'] == true) {
      return CustomPage.fromJson(response.data['data']);
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<String> uploadImage(File file, String field) async {
    if (!authService.isAuth) {
      throw new Exception(
          "You don't have the permission to access to this area!".tr +
              "[ uploadImage() ]");
    }
    String fileName = file.path.split('/').last;
    var _queryParameters = {
      'api_token': authService.apiToken,
    };
    Uri _uri = getApiBaseUri("uploads/store")
        .replace(queryParameters: _queryParameters);
    printUri(StackTrace.current, _uri);
    dio.FormData formData = dio.FormData.fromMap({
      "file": await dio.MultipartFile.fromFile(file.path, filename: fileName),
      "uuid": Uuid().generateV4(),
      "field": field,
    });
    var response = await _httpClient.postUri(_uri, data: formData);
    print(response.data);
    if (response.data['data'] != false) {
      return response.data['data'];
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<bool> deleteUploaded(String uuid) async {
    if (!authService.isAuth) {
      throw new Exception(
          "You don't have the permission to access to this area!".tr +
              "[ deleteUploaded() ]");
    }
    var _queryParameters = {
      'api_token': authService.apiToken,
    };
    Uri _uri = getApiBaseUri("uploads/clear")
        .replace(queryParameters: _queryParameters);
    printUri(StackTrace.current, _uri);
    var response = await _httpClient.postUri(_uri, data: {'uuid': uuid});
    print(response.data);
    if (response.data['data'] != false) {
      return true;
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<bool> deleteAllUploaded(List<String> uuids) async {
    if (!authService.isAuth) {
      throw new Exception(
          "You don't have the permission to access to this area!".tr +
              "[ deleteUploaded() ]");
    }
    var _queryParameters = {
      'api_token': authService.apiToken,
    };
    Uri _uri = getApiBaseUri("uploads/clear")
        .replace(queryParameters: _queryParameters);
    printUri(StackTrace.current, _uri);
    var response = await _httpClient.postUri(_uri, data: {'uuid': uuids});
    print(response.data);
    if (response.data['data'] != false) {
      return true;
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future getPortfolioEducations() async {
    Uri _uri = getApiBaseUri("uploads/clear");
    print("_uri_uri ${_uri.toString()}");
    var response = await _httpClient.get(_uri.toFilePath(), options: null);
    return response;
  }
}
