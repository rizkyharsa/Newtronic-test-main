import 'package:newtronic_test_rizky/models/product.dart';

class NewtronicData {
  int? id;
  String? title;
  String? description;
  String? banner;
  String? logo;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Product>? playlist;

  NewtronicData({
    this.id,
    this.title,
    this.description,
    this.banner,
    this.logo,
    this.createdAt,
    this.updatedAt,
    this.playlist,
  });

  factory NewtronicData.fromJson(Map<String, dynamic> json) => NewtronicData(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        banner: json["banner"],
        logo: json["logo"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        playlist:
            json["playlist"] == null ? [] : List<Product>.from(json["playlist"]!.map((x) => Product.fromJson(x))),
      );
}