import 'dart:convert';

import 'package:bmart/app/data/services/models/product.dart';
import 'package:bmart/app/data/services/models/productImage.dart';
import 'package:bmart/app/data/services/providers/storage_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  RxList<Product> products = <Product>[].obs;
  RxList<ProductImage> carousel = <ProductImage>[].obs;

  Future<void> readProductData() async {
    /// Get contents of tab
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

    /// Get contents carousel
    final data2 = await StorageProvider.to.read(
      'carousel',
    );

    if (data2 == null) {
      carousel.value = [];
      debugPrint('empty products');
      return;
    }

    var myCarousel = <ProductImage>[];

    if (data.runtimeType == List<ProductImage>) {
      myCarousel = data as List<ProductImage>;
    } else {
      final decodedData = json.decode(data2.toString()) as List<dynamic>;

      for (final element in decodedData) {
        myCarousel.add(ProductImage.fromMap(element as Map<String, dynamic>));
      }
    }
    products.value = myprod;
    carousel.value = myCarousel;
  }

  Future<void> removeProductData() async {
    await StorageProvider.to.remove(
      'products',
    );
    await readProductData();
    debugPrint('Dummy Data removed');
  }

  @override
  void onInit() async {
    super.onInit();
    await readProductData();
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

  Future<void> initializeProductData() async {
    /// Initialize data for each tab
    try {
      await StorageProvider.to.save(
        'products',
        [
          Product.fromMap({
            'title': 'Tab A',
            'productImages': [
              ProductImage.fromMap({
                'isFeatured': true,
                'title': 'prod1-img21',
                'img': 'p1-img1.jpg',
              }),
              ProductImage.fromMap({
                'isFeatured': false,
                'title': 'prod1-img2',
                'img': 'p1-img2.jpg',
              }),
              ProductImage.fromMap({
                'isFeatured': true,
                'title': 'prod1-img3',
                'img': 'p1-img3.jpg',
              }),
              ProductImage.fromMap({
                'isFeatured': false,
                'title': 'prod1-img4',
                'img': 'p1-img4.jpg',
              }),
              ProductImage.fromMap({
                'isFeatured': true,
                'title': 'prod1-img5',
                'img': 'p1-img5.jpg',
              }),
              ProductImage.fromMap({
                'isFeatured': true,
                'title': 'prod6-img26',
                'img': 'p1-img6.jpg',
              }),
              ProductImage.fromMap({
                'isFeatured': true,
                'title': 'prod7-img7',
                'img': 'p1-img7.jpg',
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

    /// Initialize data for carousel
    try {
      await StorageProvider.to.save(
        'carousel',
        [
          ProductImage.fromMap({
            'isFeatured': true,
            'title': 'prod1-img21',
            'img': 'p1-img1.jpg',
          }),
          ProductImage.fromMap({
            'isFeatured': false,
            'title': 'prod1-img2',
            'img': 'p1-img2.jpg',
          }),
          ProductImage.fromMap({
            'isFeatured': true,
            'title': 'prod1-img3',
            'img': 'p1-img3.jpg',
          }),
        ],
      );
      await readProductData();
      debugPrint('successfully added dummy products');
    } catch (e) {
      debugPrint('failed to initialize products ');
    }
  }
}
