import 'package:bmart/app/modules/bmartSidebar/controllers/bmart_sidebar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BmartSidebarView extends GetView<BmartSidebarController> {
  const BmartSidebarView({super.key});
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
