import 'package:get/get.dart';

import '../controllers/bmart_sidebar_controller.dart';

class BmartSidebarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BmartSidebarController>(
      () => BmartSidebarController(),
    );
  }
}
