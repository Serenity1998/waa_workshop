import 'parents/model.dart';

class News extends Model {
  String? id;
  String? description;
  String? detail;
  String? imageUrl;
  //Imaages url
  DateTime? createdAt;

  News({this.id, this.description, this.detail, this.createdAt});

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    data['detail'] = this.detail;
    data['imageUrl'] = this.imageUrl;
    return data;
  }
}
