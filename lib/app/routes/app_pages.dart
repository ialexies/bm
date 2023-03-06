import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:get/get.dart';

import '../modules/bmartSidebar/bindings/bmart_sidebar_binding.dart';
import '../modules/bmartSidebar/views/bmart_sidebar_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;
  static const providerConfigs = [EmailProviderConfiguration()];
  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.profile,
      page: () => ProfileScreen(
        providerConfigs: providerConfigs,
        children: [Text('ddf')],
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(Icons.chevron_left),
          ),
        ),
        actions: [
          SignedOutAction((context) {
            Navigator.pushReplacementNamed(context, '/signin');
          }),
        ],
      ),
    ),
    GetPage(
      name: _Paths.SIGNIN,
      page: () {
        return SignInScreen(
          providerConfigs: providerConfigs,
          headerBuilder: (context, constraints, _) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: AspectRatio(
                aspectRatio: 1,
                child: Image.network(
                    'https://firebase.flutter.dev/img/flutterfire_300x.png'),
              ),
            );
          },
          actions: [
            AuthStateChangeAction<SignedIn>((context, state) {
              final auth = FirebaseAuth.instance;
              final user = auth.currentUser;
              final uid = user?.uid;

              FirebaseFirestore.instance
                  .collection('users')
                  .doc(uid)
                  .update({})
                  .then((value) => print("User Details"))
                  .catchError((error) => print("Failed to add user: $error"));

              Navigator.pushReplacementNamed(context, '/home');
            }),
          ],
        );
      },
    ),
    GetPage(
      name: _Paths.BMART_SIDEBAR,
      page: () => const BmartSidebarView(),
      binding: BmartSidebarBinding(),
    ),
  ];
}
