import 'package:get/get.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/phone_number.dart';

import '../../common/uuid.dart';
import '../services/settings_service.dart';
import 'media_model.dart';
import 'parents/model.dart';

class User extends Model {
  String? uid;
  String? name;
  String? email;
  String? password;
  Media? avatar;
  Media? media;
  String? apiToken;
  String? deviceToken;
  String? phoneNumber;
  bool? verifiedPhone;
  String? verificationId;
  String? address;
  String? bio;

  bool? auth;

  User(
      {this.uid,
      this.name,
      this.email,
      this.password,
      this.apiToken,
      this.deviceToken,
      this.phoneNumber,
      this.verifiedPhone,
      this.verificationId,
      this.address,
      this.bio,
      this.avatar,
      this.media});

  User.fromJson(Map<String, dynamic> json) {
    uid = stringFromJson(json, 'uid');
    name = stringFromJson(json, 'name');
    email = stringFromJson(json, 'email');
    apiToken = stringFromJson(json, 'api_token');
    deviceToken = stringFromJson(json, 'device_token');
    phoneNumber = stringFromJson(json, 'phone_number');
    verifiedPhone = boolFromJson(json, 'phone_verified_at');
    avatar = mediaFromJson(json, 'avatar');
    media = mediaFromJson(json, 'media');
    auth = boolFromJson(json, 'auth');
    try {
      address = json['custom_fields']['address']['view'];
    } catch (e) {
      address = stringFromJson(json, 'address');
    }
    try {
      bio = json['custom_fields']['bio']['view'];
    } catch (e) {
      bio = stringFromJson(json, 'bio');
    }
    super.fromJson(json);
  }

  String get greeting {
    var time = DateTime.now().hour;
    if (time >= 06 && time < 11) {
      return "Өглөөний мэнд";
    }
    if (time >= 11 && time < 18) {
      return "Өдрийн мэнд";
    }

    if (time >= 18 && time < 22) {
      return "Оройн мэнд";
    }

    if (time >= 22 && time < 06) {
      return "Шөнийн мэнд";
    }

    return "Өдрийн мэнд";
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['uid'] = uid;
    data['name'] = name;
    data['email'] = email;
    if (password != null && password != '') {
      data['password'] = password;
    }
    data['api_token'] = apiToken;
    if (deviceToken != null) {
      data["device_token"] = deviceToken;
    }
    data["phone_number"] = phoneNumber;
    if (verifiedPhone != null && verifiedPhone!) {
      data["phone_verified_at"] = DateTime.now().toLocal().toString();
    }
    data["address"] = address;
    data["bio"] = bio;
    if (avatar != null && Uuid.isUuid(avatar!.id.toString())) {
      data['avatar'] = avatar?.id;
    }
    if (avatar != null) {
      data["media"] = [avatar?.toJson()];
    }
    data['auth'] = auth;
    return data;
  }

  Map toRestrictMap() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["uid"] = uid;
    map["email"] = email;
    map["name"] = name;
    map["thumb"] = avatar?.thumb;
    map["device_token"] = deviceToken;
    return map;
  }

  PhoneNumber getPhoneNumber() {
    if (phoneNumber != null) {
      phoneNumber = phoneNumber!.replaceAll(' ', '');
      String dialCode1 = phoneNumber!.substring(1, 2);
      String dialCode2 = phoneNumber!.substring(1, 3);
      String dialCode3 = phoneNumber!.substring(1, 4);
      for (int i = 0; i < countries.length; i++) {
        if (countries[i].dialCode == dialCode1) {
          return PhoneNumber(
              countryISOCode: countries[i].code,
              countryCode: dialCode1,
              number: phoneNumber!.substring(2));
        } else if (countries[i].dialCode == dialCode2) {
          return PhoneNumber(
              countryISOCode: countries[i].code,
              countryCode: dialCode2,
              number: phoneNumber!.substring(3));
        } else if (countries[i].dialCode == dialCode3) {
          return PhoneNumber(
              countryISOCode: countries[i].code,
              countryCode: dialCode3,
              number: phoneNumber!.substring(4));
        }
      }
    }
    return PhoneNumber(
        countryISOCode:
            Get.find<SettingsService>().setting.value.defaultCountryCode!,
        countryCode: '1',
        number: '');
  }

  @override
  int get hashCode =>
      super.hashCode ^
      name.hashCode ^
      email.hashCode ^
      password.hashCode ^
      avatar.hashCode ^
      apiToken.hashCode ^
      deviceToken.hashCode ^
      phoneNumber.hashCode ^
      verifiedPhone.hashCode ^
      verificationId.hashCode ^
      address.hashCode ^
      bio.hashCode ^
      auth.hashCode;

  @override
  bool operator ==(other) {
    return super == other &&
        other is User &&
        runtimeType == other.runtimeType &&
        uid == other.uid &&
        name == other.name &&
        email == other.email &&
        password == other.password &&
        avatar == other.avatar &&
        apiToken == other.apiToken &&
        deviceToken == other.deviceToken &&
        phoneNumber == other.phoneNumber &&
        verifiedPhone == other.verifiedPhone &&
        verificationId == other.verificationId &&
        address == other.address &&
        bio == other.bio &&
        auth == other.auth;
  }
}
