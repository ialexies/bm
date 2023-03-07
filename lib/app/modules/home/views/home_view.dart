// ignore_for_file: prefer_const_declarations, omit_local_variable_types

import 'package:bmart/app/modules/home/controllers/home_controller.dart';
import 'package:bmart/app/modules/home/widgets/bmart_drawer.dart';
import 'package:bmart/app/modules/home/widgets/tab_body.dart';
import 'package:bmart/app/modules/widgetsGlobal/bmartTabBar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          title: const Text('AppBar'),
          actions: [
            IconButton(
              onPressed: () => FirebaseAuth.instance.signOut(),
              icon: const Icon(Icons.exit_to_app),
            )
          ],
        ),
        body: controller.products.isEmpty
            ? const Center(
                child: Text(
                  'Please Click the \n "LOAD INITIAL BUTTON" \nin the sidebar',
                  textAlign: TextAlign.center,
                ),
              )
            : CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: CarouselSlider(
                      options: CarouselOptions(
                        height: Get.width * .8,
                        viewportFraction: 1,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 5),
                      ),
                      items: controller.carousel.map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return SizedBox(
                              width: double.infinity,
                              child: Image(
                                image: AssetImage(
                                  'assets/images/${i.img}',
                                ),
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: DefaultTabController(
                      length: controller.products.length,
                      child: ColoredBox(
                        color: Colors.white,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              color: Colors.blue.shade800,
                              padding:
                                  const EdgeInsets.only(top: 20, bottom: .5),
                              child: TabBar(
                                indicatorColor: Colors.amber,
                                tabs: controller.products
                                    .map(
                                      (element) => Tab(
                                        child: TabBarEach(
                                          element.title,
                                          element.productImages.length,
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  height: Get.height * .5,
                                  child: TabBarView(
                                    children: controller.products
                                        .map(
                                          TabBody.new,
                                        )
                                        .toList(),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
        drawer: const BmartDrawer(),
      );
    });
  }
}
