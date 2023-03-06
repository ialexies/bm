// ignore_for_file: prefer_const_declarations, omit_local_variable_types

import 'package:badges/badges.dart' as badges;
import 'package:bmart/app/modules/bmartSidebar/views/bmart_sidebar_view.dart';
import 'package:bmart/app/modules/home/controllers/home_controller.dart';
import 'package:bmart/app/routes/app_pages.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final TabBar tabBar = TabBar(
        indicatorColor: Colors.amber,
        tabs: controller.products
            .map(
              (element) => Tab(
                child: _TabBarEach(element.title, element.productImages.length),
              ),
            )
            .toList(),
      );

      return DefaultTabController(
        length: controller.products.length,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('AppBar'),
            actions: [
              IconButton(
                onPressed: () => FirebaseAuth.instance.signOut(),
                icon: const Icon(Icons.exit_to_app),
              )
            ],
            bottom: PreferredSize(
              preferredSize: tabBar.preferredSize,
              child: ColoredBox(
                color: Colors.black12,
                child: tabBar,
              ),
            ),
          ),
          body: TabBarView(
            children: controller.products
                .map(
                  (e) => Align(
                    alignment: Alignment.topCenter,
                    child: CarouselSlider(
                      options: CarouselOptions(
                        height: 200,
                        viewportFraction: 1.0,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 5),
                      ),
                      items: e.productImages.map((i) {
                        return GestureDetector(
                          onLongPress: () => Get.defaultDialog(
                              title: 'Image Options',
                              content: Container(
                                child: Column(
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {},
                                      child: const Text('Move to other tab'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {},
                                      child: const Text('Add To Carousel'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {},
                                      child: const Text('Remove from Carousel'),
                                    ),
                                  ],
                                ),
                              )),
                          child: Stack(
                            children: [
                              SizedBox(
                                width: double.infinity,
                                child: Image(
                                  image: AssetImage(
                                    'assets/images/${i.img}',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                right: 15,
                                top: 15,
                                child: Stack(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      size: 50,
                                      color: i.isFeatured
                                          ? Colors.amber
                                          : Colors.transparent,
                                      shadows: i.isFeatured
                                          ? const <Shadow>[
                                              Shadow(
                                                blurRadius: 15,
                                              )
                                            ]
                                          : null,
                                    ),
                                    const Icon(
                                      Icons.star_border,
                                      size: 50,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                )
                .toList(),
          ),
          drawer: Drawer(
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
                ListTile(
                  title: ElevatedButton(
                    onPressed: () {
                      Get.toNamed(Routes.profile);
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.deepOrange),
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
                  height: 30,
                ),
                Obx(
                  () => Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Product Items: '),
                      Text(controller.products.length.toString()),
                    ],
                  )),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}

class _TabBarEach extends StatelessWidget {
  const _TabBarEach(this._title, this._count);

  final String _title;
  final int _count;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(_title),
        const SizedBox(
          width: 5,
        ),
        badges.Badge(
          badgeStyle: const badges.BadgeStyle(
            badgeColor: Colors.black,
          ),
          badgeContent: Text(
            _count.toString(),
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          child: const Icon(
            Icons.image,
            color: Colors.white,
          ),
        )
      ],
    );
  }
}
