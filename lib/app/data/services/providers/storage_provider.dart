// ignore_for_file: strict_raw_type, type_annotate_public_apis, inference_failure_on_untyped_parameter, inference_failure_on_function_invocation

import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StorageProvider extends GetxService {
  static StorageProvider get to => Get.find();
  final GetStorage box = GetStorage();

  Future<StorageProvider> init() async {
    return this;
  }

  Future read(String name) async {
    final val = await box.read(name);
    return val;
  }

  Future save(String key, val) async {
    await box.write(key, val);
  }

  Future removeCart(String key) async {
    await box.remove(key);
  }
}
