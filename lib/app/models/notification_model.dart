import 'package:get/get.dart';

import 'parents/model.dart';

class Notification extends Model {
  String? id;
  String? type;
  String? image;
  Map<String, dynamic>? data;
  Map<dynamic, dynamic>? salon;
  bool? read;
  DateTime? createdAt;

  Notification();

  Notification.fromJson(Map<String, dynamic> json) {
    super.fromJson(json);
    type = stringFromJson(json, 'type');
    image = stringFromJson(json, 'image');
    data = json["data"] ?? {};
    salon = mapFromJson(json, 'salon', defaultValue: {});
    image = stringFromJson(json, "image");
    read = boolFromJson(json, 'read_at');
    createdAt = dateFromJson(json, 'created_at',
        defaultValue: DateTime.now().toLocal());
  }

  Map markReadMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["read_at"] = read;
    return map;
  }

  @override
  Map<String, dynamic> toJson() {
    throw UnimplementedError();
  }

  String getMessage() {
    if (type == 'App\\Notifications\\NewMessage' && data?['from'] != null) {
      return data?['from'] + ' ' + type.toString().tr;
    } else if (data?['booking_id'] != null) {
      return '#' + data!['booking_id'].toString() + ' ' + type.toString().tr;
    } else {
      return type.toString().tr;
    }
  }
}
