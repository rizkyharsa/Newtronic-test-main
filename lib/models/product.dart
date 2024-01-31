class Product {
  int? id;
  int? dirId;
  String? title;
  String? description;
  String? url;
  String? type;
  DateTime? createdAt;
  DateTime? updatedAt;

  Product({
    this.id,
    this.dirId,
    this.title,
    this.description,
    this.url,
    this.type,
    this.createdAt,
    this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        dirId: json["dir_id"],
        title: json["title"],
        description: json["description"],
        url: json["url"],
        type: json["type"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
      );
}