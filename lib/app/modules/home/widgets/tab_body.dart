// ignore_for_file: inference_failure_on_function_invocation

import 'package:bmart/app/data/services/models/product.dart';
import 'package:bmart/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabBody extends GetView<HomeController> {
  TabBody(
    this.param,
  );

  Product param;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final e = controller.products[controller.products.indexOf(param)];
      return SizedBox(
        child: GridView.count(
          crossAxisCount: controller.products.length,
          physics: const ScrollPhysics(),
          children: e.productImages
              .map(
                (productImg) => GestureDetector(
                  onTap: () => Get.defaultDialog(
                    title: e.title,
                    content: Column(
                      children: [
                        Image(
                          image: AssetImage(
                            'assets/images/${productImg.img}',
                          ),
                          fit: BoxFit.cover,
                        ),
                        Switch(
                          value: !controller.isImginCurrentTabInTabA(
                            e,
                            productImg,
                          ),
                          onChanged: (val) {
                            controller.moveToOtherTabToggle(e, productImg);
                            Get.back();
                          },
                        ),
                        Checkbox(
                          value: controller.isImgInCarousel(productImg),
                          onChanged: (val) {
                            controller.addOrRemoveInCarousel(
                              e,
                              productImg,
                              val ?? false,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  onLongPress: () => Get.defaultDialog(
                    title: 'Image Options',
                    content: Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            controller.moveToOtherTab(
                              e,
                              productImg,
                            );
                            Get.back();
                          },
                          child: const Text(
                            'Move to other tab',
                          ),
                        ),
                        Checkbox(
                          value: controller.isImgInCarousel(productImg),
                          onChanged: (val) {
                            controller.addOrRemoveInCarousel(
                              e,
                              productImg,
                              val ?? false,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  child: Image(
                    image: AssetImage(
                      'assets/images/${productImg.img}',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              )
              .toList(),
        ),
      );
    });
  }
}
