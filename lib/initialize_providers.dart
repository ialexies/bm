import 'dart:developer';

import 'package:bmart/app/data/services/providers/storage_provider.dart';
import 'package:get/get.dart';

Future<void> initializeProviders() async {
  log('Initializing Providers: ');
  await Get.putAsync(
    () => StorageProvider().init(),
  );
  log('Providers Inititalized!');
}
