
import 'package:expense_manager/pages/splash/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/app_pages.dart';
import 'bottom_nav_menu_binding.dart';


class BottomNavMenuController extends GetxController with GetSingleTickerProviderStateMixin  {
   final currentIndex = 0.obs;
  late TabController? tabController;


  final pages = <String>[
    Routes.splash,
    Routes.splash,
    Routes.splash,
  ];

  @override
  void onInit() {
    // TODO: implement onInit
    tabController = TabController(vsync: this, length: pages.length);

    super.onInit();
  }

  void changePage(int index) {
      if (index != currentIndex.value) {
        currentIndex.value = index;
        Get.offNamed(pages[index], id: 0);
      }

  }

  @override
  void onReady() {
    super.onReady();

    if (Get.arguments != null) {

    }
  }





  Route? onGenerateRoute(RouteSettings settings) {
    if (settings.name == Routes.splash) {
      return GetPageRoute(
        settings: settings,
        page: () => const SplashView(),
        binding: BottomNavMenuBinding(),);
    }

   return null;

  }

  @override
  void onClose() {
    tabController!.dispose();
    super.onClose();
  }

}
