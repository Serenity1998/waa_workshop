import 'package:get/get.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:save_time_customer/app/models/parents/model.dart';

import '../../common/uuid.dart';
import '../services/settings_service.dart';
import 'user_model.dart';

class SalonUser extends Model {
  String? position;
  String? worked_year;

  User? user;

  SalonUser(
      {this.position,
      this.worked_year,
      this.user});

  SalonUser.fromJson(Map<String, dynamic> json) {
    position = stringFromJson(json, 'position');
    worked_year = stringFromJson(json, 'worked_year');
    user = User.fromJson(json['user']);
    super.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}
