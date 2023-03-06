import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class ProductImage {
  bool isFeatured;
  String title;
  String img;
  ProductImage({
    required this.isFeatured,
    required this.title,
    required this.img,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isFeatured': isFeatured,
      'title': title,
      'img': img,
    };
  }

  factory ProductImage.fromMap(Map<String, dynamic> map) {
    return ProductImage(
      isFeatured: map['isFeatured'] as bool,
      title: map['title'] as String,
      img: map['img'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductImage.fromJson(String source) =>
      ProductImage.fromMap(json.decode(source) as Map<String, dynamic>);
}
