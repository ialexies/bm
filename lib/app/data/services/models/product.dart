// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:bmart/app/data/services/models/productImage.dart';

class Product {
  String title;
  List<ProductImage> productImages;
  Product({
    required this.title,
    required this.productImages,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'productImages': productImages.map((x) => x.toMap()).toList(),
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      title: map['title'] as String,
      productImages: List<ProductImage>.from(
        (map['productImages'] as List<ProductImage>).map<ProductImage>(
          (x) => ProductImage.fromMap(x.toMap() as Map<String, dynamic>),
        ),
      ),
    );
  }

  factory Product.fromMap2(Map<String, dynamic> map) {
    final data = jsonEncode(map);
    final decoded = jsonDecode(data);

    List<ProductImage> _prouctImageList = [];

    final a = decoded["productImages"] as List;

    a.forEach((x) {
      _prouctImageList.add(
        ProductImage(
          isFeatured: x['isFeatured'] == 'true',
          title: x['title'].toString(),
          img: x['img'].toString(),
        ),
      );
    });

    return Product(
        title: map["title"].toString(), productImages: _prouctImageList);
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);
}
