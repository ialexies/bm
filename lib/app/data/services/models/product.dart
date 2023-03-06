// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bmart/app/data/services/models/productImage.dart';

class Product {
  String title;
  List<ProductImage> productImages;
  Product({
    required this.title,
    required this.productImages,
  });
}
