import 'dart:convert';

import 'package:bmart/app/data/services/models/product.dart';
import 'package:bmart/app/data/services/models/productImage.dart';
import 'package:bmart/app/data/services/providers/storage_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  final scaffoldKey = GlobalKey<ScaffoldState>();

  RxList<Product> products = <Product>[].obs;

  Future<void> initializeProductData() async {
    await StorageProvider.to.save(
      'products',
      [
        Product.fromMap({
          'title': 'Product 1',
          'productImages': [
            ProductImage.fromMap({
              'isFeatured': true,
              'title': 'prod1-img2',
              'img': 'mypath',
            }),
          ],
        }),
      ],
    );
  }

  Future<void> readProductData() async {
    final data = await StorageProvider.to.read(
      'products',
    );

    final myprod = <Product>[];

    final decodedData = json.decode(data.toString()) as List<dynamic>;

    for (final element in decodedData) {
      myprod.add(Product.fromMap2(element as Map<String, dynamic>));
    }

    print(myprod);
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void closeDrawer() {
    scaffoldKey.currentState!.openEndDrawer();
  }
}
