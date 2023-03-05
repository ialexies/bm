import 'package:bmart/app/modules/home/controllers/home_controller.dart';
import 'package:bmart/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('HomeView'),
          centerTitle: true,
        ),
        body: const Center(
          child: Text(
            'HomeView is working',
            style: TextStyle(fontSize: 20),
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const DrawerHeader(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.red, Colors.deepOrangeAccent],
                    stops: [0.0, 0.7],
                    transform: GradientRotation(90),
                  ),
                ),
                child: Text(
                  'SETTINGS',
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                title: ElevatedButton(
                  onPressed: () {
                    Get.toNamed(Routes.profile);
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.deepOrange)),
                  child: const Text('My Profile'),
                ),
                onTap: controller.closeDrawer,
              ),
              ListTile(
                title: ElevatedButton(
                  onPressed: () async {
                    // Get.toNamed(Routes.profile);
                    await FirebaseAuth.instance.signOut();
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.deepOrange)),
                  child: const Text('Logout'),
                ),
                onTap: controller.closeDrawer,
              )
            ],
          ),
        ));
  }
}
