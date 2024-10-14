/*
 * File name: network_exceptions.dart
 * Last modified: 2022.08.14 at 16:24:55
 * Author: SmarterVision - https://codecanyon.net/user/smartervision
 * Copyright (c) 2022
 */

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart' as _get;

import '../routes/app_routes.dart';


abstract class NetworkExceptions {
  static String handleResponse(Response response) {
    int statusCode = response.statusCode ?? 0;
    switch (statusCode) {
      case 400:
      case 401:
      case 403:
        if (_get.Get.currentRoute != Routes.LOGIN) {
          _get.Get.offAllNamed(Routes.LOGIN);
        }
        return "Unauthorized Request";
      case 404:
        return "Not found";
      case 409:
        return "Error due to a conflict";
      case 408:
        return "Connection request timeout";
      case 500:
        return "Internal Server Error";
      case 503:
        return "Service unavailable";
      default:
        return "Received invalid status code";
    }
  }

  static String getDioException(error) {
    if (error is Exception) {
      try {
        var errorMessage = "";
        if (error is DioException) {
          switch (error.type) {
            case DioExceptionType.cancel:
              errorMessage = "Request Cancelled";
              break;
            case DioExceptionType.connectionTimeout:
              errorMessage = "Connection request timeout";
              break;
            case DioExceptionType.unknown:
              errorMessage = "No internet connection";
              break;
            case DioExceptionType.receiveTimeout:
              errorMessage = "Send timeout in connection with API server";
              break;
            case DioExceptionType.sendTimeout:
              errorMessage = "Send timeout in connection with API server";
              break;
            case DioExceptionType.badCertificate:
              errorMessage = "Bad certificate";
              break;
            case DioExceptionType.badResponse:
              errorMessage = "Bad response";
              break;
            case DioExceptionType.connectionError:
              errorMessage = "Connection error";
              break;
          }
        } else if (error is SocketException) {
          errorMessage = "No internet connection";
        } else {
          errorMessage = "Unexpected error occurred";
        }
        return errorMessage;
      } on FormatException {
        return "Unexpected error occurred";
      } catch (_) {
        return "Unexpected error occurred";
      }
    } else {
      if (error.toString().contains("is not a subtype of")) {
        return "Unable to process the data";
      } else {
        return "Unexpected error occurred";
      }
    }
  }
}
