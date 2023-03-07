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
  }

  Future<void> readCarouselData() async {
    /// Get contents carousel
    final data2 = await StorageProvider.to.read(
      'carousel',
    );

    if (data2 == null) {
      carousel.value = [];
      debugPrint('empty carousel');
      return;
    }

    debugPrint(data2.toString());

    var myCarousel = <ProductImage>[];

    if (data2.runtimeType == List<ProductImage>) {
      myCarousel = data2 as List<ProductImage>;
    } else {
      final decodedData2 = json.decode(data2.toString()) as List<dynamic>;

      for (final element in decodedData2) {
        myCarousel.add(ProductImage.fromMap(element as Map<String, dynamic>));
      }
    }

    carousel.value = myCarousel;
  }

  Future<void> removeProductData() async {
    await StorageProvider.to.remove(
      'products',
    );
    await StorageProvider.to.remove(
      'carousel',
    );
    await readProductData();
    await readCarouselData();
    debugPrint('Dummy Data removed');
  }

  @override
  void onInit() async {
    super.onInit();
    await readProductData();
    await readCarouselData();
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
    await _loadTabData();

    /// Initialize data for carousel
    await _loadCarouselData();
  }

  Future<void> _loadCarouselData() async {
    try {
      await StorageProvider.to.save(
        'carousel',
        [
          ProductImage.fromMap({
            'isFeatured': true,
            'title': 'prod1-img21',
            'img': 'p1-img1.jpg',
          }),
        ],
      );
      await readCarouselData();
      debugPrint('successfully added dummy products');
    } catch (e) {
      debugPrint('failed to initialize products ');
    }
  }

  Future<void> _loadTabData() async {
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
  }

  bool isImginCurrentTabInTabA(Product product, ProductImage productImg) {
    final prodIndex = products.indexOf(product);
    // final toProductIndex = prodIndex == 0 ? 1 : 0;
    if (prodIndex == 0) return true;
    return false;
  }

  void moveToOtherTabToggle(Product product, ProductImage productImg) {
    final prodIndex = isImginCurrentTabInTabA(product, productImg) ? 0 : 1;
    final toProductIndex = prodIndex == 0 ? 1 : 0;
    // remove img from its current tab
    products[prodIndex].productImages.remove(productImg);

    // Add the image to other tab
    products[toProductIndex].productImages.add(productImg);

    // refresh state
    products.refresh();
  }

  void moveToOtherTab(Product product, ProductImage productImg) {
    final prodIndex = products.indexOf(product);

    final toProductIndex = prodIndex == 0 ? 1 : 0;

    // remove img from its current tab
    products[prodIndex].productImages.remove(productImg);

    // Add the image to other tab
    products[toProductIndex].productImages.add(productImg);

    // refresh state
    products.refresh();
  }

  bool isImgInCarousel(ProductImage productImg) {
    final isImgExistInCarosel =
        carousel.firstWhereOrNull((element) => element.img == productImg.img);

    if (isImgExistInCarosel != null) return true;

    return false;
  }

  void addOrRemoveInCarousel(Product e, ProductImage productImg, bool val) {
    if (val) {
      debugPrint(val.toString());
      //Check if Img is already in the carousel
      final isImgExistInCarosel = isImgInCarousel(productImg);
      if (isImgExistInCarosel == true) return;

      // Add the image to other tab
      carousel.add(productImg);
      Get.defaultDialog(
        title: 'Success',
        content: const Text('Successfully added to carousel'),
      ).then((value) => Get.back());
    } else {
      final isImgExistInCarosel = isImgInCarousel(productImg);

      if (isImgExistInCarosel != true) return;

      carousel.remove(productImg);

      Get.defaultDialog(
        title: 'Success',
        content: const Text('Image Removed'),
      ).then((value) => Get.back());
    }
  }
}
