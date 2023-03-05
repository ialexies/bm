import 'package:bmart/app/modules/home/controllers/home_controller.dart';
import 'package:bmart/app/routes/app_pages.dart';
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
              DrawerHeader(
                child: Text('Drawer Header'),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
              ListTile(
                title: ElevatedButton(
                  onPressed: () {
                    Get.toNamed(Routes.profile);
                  },
                  child: Text('Profile'),
                ),
                onTap: controller.closeDrawer,
              )
            ],
          ),
        ));
  }
}
