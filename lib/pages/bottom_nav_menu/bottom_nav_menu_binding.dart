import 'package:get/get.dart';

import '../../common/remote_repository/api_repository.dart';
import 'bottom_nav_menu_controller.dart';

class BottomNavMenuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiRepository>(() => ApiRepositoryImpl());
    Get.put<BottomNavMenuController>(BottomNavMenuController());
  }
}
