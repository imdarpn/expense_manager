
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/methods/common_methods.dart';
import '../../routes/app_pages.dart';
import '../../utils/custom_bottombar/custom_bottom_bar.dart';
import 'bottom_nav_menu_controller.dart';

class BottomNavMenuView extends GetView<BottomNavMenuController> {
  const BottomNavMenuView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        if (controller.currentIndex.value != 0) {

          controller.changePage(0);
          return false;
        }

        return true;
      },
      child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: getView(),
      bottomNavigationBar: Obx(() {
        return CustomBottomBar(
          currentIndex: controller.currentIndex.value,
          onTap: (i) {
            controller.changePage(i);
          },
          items: CommonMethods.getTabs()
        );
      }),

    ));
  }


  Widget getView() {
    return Navigator(
      key: Get.nestedKey(0),
      initialRoute: Routes.splash,
      onGenerateRoute: controller.onGenerateRoute,
    );
  }


}
