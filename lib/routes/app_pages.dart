import 'package:expense_manager/pages/bottom_nav_menu/bottom_nav_menu_binding.dart';
import 'package:get/get.dart';

import '../pages/bottom_nav_menu/bottom_nav_menu_view.dart';
import '../pages/splash/splash_bindings.dart';
import '../pages/splash/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  static const initialRoute = Routes.splash;

  static final List<GetPage<dynamic>> routes = [
    /// splash view
    GetPage(
      name: _Paths.splash,
      page: () => const SplashView(),
      binding: SplashBindings(),
    ),

    /// Dashboard view
    GetPage(
      name: _Paths.bottomNavMenu,
      page: () => const BottomNavMenuView(),
      binding: BottomNavMenuBinding(),
    ),
  ];
}
