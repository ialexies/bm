// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:developer';
import 'package:bmart/app/app.dart';
import 'package:bmart/app/data/services/auth_service.dart';
import 'package:bmart/firebase_options.dart';
import 'package:bmart/initialize_providers.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    name: 'bmart',
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await initializeProviders();
  await initServices();
  runApp(const App());
  // await bootstrap(() => const App());
}

Future<void> initServices() async {
  log('starting Servicess....');

  log('starting auth service....');
  await Get.putAsync<AuthService>(() async => AuthService());

  log('starting storage service...');
  await GetStorage.init();

  log('All Services started');
}
