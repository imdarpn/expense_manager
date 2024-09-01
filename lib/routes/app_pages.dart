import 'package:expense_manager/pages/add_category/add_category_binding.dart';
import 'package:expense_manager/pages/add_category/add_category_view.dart';
import 'package:expense_manager/pages/add_transaction/add_transaction_binding.dart';
import 'package:expense_manager/pages/add_transaction/add_transaction_view.dart';
import 'package:expense_manager/pages/bottom_nav_menu/bottom_nav_menu_binding.dart';
import 'package:expense_manager/pages/category/category_binding.dart';
import 'package:expense_manager/pages/category/category_view.dart';
import 'package:expense_manager/pages/monthly_graph/monthly_graph_binding.dart';
import 'package:expense_manager/pages/monthly_graph/monthly_graph_view.dart';
import 'package:expense_manager/pages/transactions/transaction_binding.dart';
import 'package:expense_manager/pages/transactions/transaction_view.dart';
import 'package:get/get.dart';

import '../pages/bottom_nav_menu/bottom_nav_menu_view.dart';
import '../pages/splash/splash_binding.dart';
import '../pages/splash/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  static const initialRoute = Routes.splash;

  static final List<GetPage<dynamic>> routes = [
    /// splash view
    GetPage(
      name: _Paths.splash,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),

    /// Dashboard view
    GetPage(
      name: _Paths.bottomNavMenu,
      page: () => const BottomNavMenuView(),
      binding: BottomNavMenuBinding(),
    ),

    /// Transaction view
    GetPage(
      name: _Paths.transaction,
      page: () => const TransactionView(),
      binding: TransactionBinding(),
    ),

    /// Category view
    GetPage(
      name: _Paths.category,
      page: () => const CategoryView(),
      binding: CategoryBinding(),
    ),

    /// Add Category view
    GetPage(
      name: _Paths.addCategory,
      page: () => const AddCategoryView(),
      binding: AddCategoryBinding(),
    ),

    /// Add Transaction view
    GetPage(
      name: _Paths.addTransaction,
      page: () => const AddTransactionView(),
      binding: AddTransactionBinding(),
    ),

    /// Monthly Graph view
    GetPage(
      name: _Paths.monthlyGraph,
      page: () => const MonthlyGraphView(),
      binding: MonthlyGraphBinding(),
    ),
  ];
}
