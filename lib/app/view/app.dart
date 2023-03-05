// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:bmart/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // initialRoute: AppPages.INITIAL,
      initialRoute: FirebaseAuth.instance.currentUser == null
          ? Routes.SIGNIN
          : Routes.HOME,
      getPages: AppPages.routes,
      theme: ThemeData(
        // appBarTheme: const AppBarTheme(color: Color(0xFF13B9FF)),
        appBarTheme: const AppBarTheme(color: Color(0xFFEA3D16)),
        colorScheme: ColorScheme.fromSwatch(
          accentColor: const Color(0xFFBE220B),
        ),
      ),
      // localizationsDelegates: AppLocalizations.localizationsDelegates,
      // supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
