import 'package:get/get.dart';

import 'bottom_nav_menu_controller.dart';

class BottomNavMenuBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<BottomNavMenuController>(BottomNavMenuController());
  }
}
