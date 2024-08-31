import 'dart:async';
import 'package:get/get.dart';

import '../../routes/app_pages.dart';

class SplashController extends GetxController with GetTickerProviderStateMixin {

  @override
  void onInit() {
    Future.delayed(
      const Duration(seconds: 2),
          () => redirectScreen(),
    );
    super.onInit();
  }

  redirectScreen() {
    Get.offAllNamed(Routes.bottomNavMenu,);
  }
}
