import 'dart:convert';

import 'package:bmart/app/data/services/models/product.dart';
import 'package:bmart/app/data/services/models/productImage.dart';
import 'package:bmart/app/data/services/providers/storage_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  RxList<Product> products = <Product>[].obs;

  Future<void> initializeProductData() async {
    try {
      await StorageProvider.to.save(
        'products',
        [
          Product.fromMap({
            'title': 'Tab A',
            'productImages': [
              ProductImage.fromMap({
                'isFeatured': true,
                'title': 'prod1-img2',
                'img': 'p1-img1.jpg',
              }),
              ProductImage.fromMap({
                'isFeatured': false,
                'title': 'prod1-img2',
                'img': 'p1-img2.jpg',
              }),
              ProductImage.fromMap({
                'isFeatured': true,
                'title': 'prod1-img2',
                'img': 'p1-img3.jpg',
              }),
              ProductImage.fromMap({
                'isFeatured': false,
                'title': 'prod1-img2',
                'img': 'p1-img4.jpg',
              }),
              ProductImage.fromMap({
                'isFeatured': true,
                'title': 'prod1-img2',
                'img': 'p1-img5.jpg',
              }),
            ],
          }),
          Product.fromMap({
            'title': 'Tab B',
            'productImages': [
              ProductImage.fromMap({
                'isFeatured': true,
                'title': 'prod1-img2',
                'img': 'p1-img2.jpg',
              }),
            ],
          }),
        ],
      );
      await readProductData();
      debugPrint('successfully added dummy products');
    } catch (e) {
      debugPrint('failed to initialize products ');
    }
  }

  Future<void> readProductData() async {
    final data = await StorageProvider.to.read(
      'products',
    );

    if (data == null) {
      products.value = [];
      debugPrint('empty products');
      return;
    }

    var myprod = <Product>[];

    if (data.runtimeType == List<Product>) {
      myprod = data as List<Product>;
    } else {
      final decodedData = json.decode(data.toString()) as List<dynamic>;

      for (final element in decodedData) {
        myprod.add(Product.fromMap2(element as Map<String, dynamic>));
      }
    }

    products.value = myprod;
  }

  Future<void> removeProductData() async {
    await StorageProvider.to.remove(
      'products',
    );
    await readProductData();
    debugPrint('Dummy Data removed');
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
