import 'package:bmart/app/modules/bmartSidebar/views/bmart_sidebar_view.dart';
import 'package:bmart/app/modules/home/controllers/home_controller.dart';
import 'package:bmart/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class BmartDrawer extends GetView<HomeController> {
  const BmartDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const BmartSidebarView(),
          const SizedBox(
            height: 10,
          ),
          ListTile(
            title: ElevatedButton(
              onPressed: () {
                Get.toNamed(Routes.profile);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.deepOrange),
              ),
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
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: Colors.blue.shade100,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 15, bottom: 10),
                  child: const Text('Data Management'),
                ),
                ListTile(
                  title: ElevatedButton(
                    onPressed: () {
                      controller.initializeProductData();
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.deepOrange),
                    ),
                    child: const Text('Load Initial Data'),
                  ),
                  onTap: controller.closeDrawer,
                ),
                ListTile(
                  title: ElevatedButton(
                    onPressed: () async {
                      await controller.readProductData();
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.deepOrange),
                    ),
                    child: const Text('Read Data'),
                  ),
                  onTap: controller.closeDrawer,
                ),
                ListTile(
                  title: ElevatedButton(
                    onPressed: () async {
                      await controller.removeProductData();
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.deepOrange),
                    ),
                    child: const Text('Remove Data'),
                  ),
                  onTap: controller.closeDrawer,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Product Items: '),
                Text(controller.products.length.toString()),
              ],
            ),
          )
        ],
      ),
    );
  }
}
