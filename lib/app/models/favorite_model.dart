import 'salon_model.dart';
import 'e_service_model.dart';
import 'option_model.dart';
import 'parents/model.dart';

class Favorite extends Model {
  String? id;
  EService? eService;
  Salon? salon;
  List<Option>? options;
  String? userId;

  Favorite({this.id, this.eService, this.salon, this.options, this.userId});

  Favorite.fromJson(Map<String, dynamic> json) {
    super.fromJson(json);
    eService = objectFromJson(json, 'e_service', (v) => EService.fromJson(v));
    salon = objectFromJson(json, 'salon', (v) => Salon.fromJson(v));
    options = listFromJson(json, 'options', (v) => Option.fromJson(v));
    userId = stringFromJson(json, 'user_id');
  }

  Map<String, dynamic> toJson() {
    var map = new Map<String, dynamic>();
    if (id != null) map["id"] = id;
    if (eService != null) map["e_service_id"] = eService?.id;
    if (salon != null) map["salon_id"] = salon?.id;
    map["user_id"] = userId;
    if (options is List<Option>) {
      map["options"] = options?.map((element) => element.id).toList();
    }
    return map;
  }
}
