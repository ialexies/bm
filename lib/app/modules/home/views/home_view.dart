import 'package:bmart/app/modules/home/controllers/home_controller.dart';
import 'package:bmart/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  TabBar get _tabBar => const TabBar(
        indicatorColor: Colors.amber,
        tabs: [
          Tab(icon: Icon(Icons.call)),
          Tab(icon: Icon(Icons.message)),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('AppBar'),
          bottom: PreferredSize(
            preferredSize: _tabBar.preferredSize,
            child: ColoredBox(
              color: Colors.black12,
              child: _tabBar,
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            Icon(Icons.directions_transit),
            Icon(Icons.directions_bike),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const BmartSideBar(),
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
        ),
      ),
    );
  }
}

class BmartSideBar extends StatelessWidget {
  const BmartSideBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const DrawerHeader(
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
    );
  }
}
