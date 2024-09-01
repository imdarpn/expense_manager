part of 'app_pages.dart';

abstract class Routes {
  static const String splash = _Paths.splash;
  static const String bottomNavMenu = _Paths.bottomNavMenu;
  static const String transaction = _Paths.transaction;
  static const String category = _Paths.category;
  static const String addCategory = _Paths.addCategory;
  static const String addTransaction = _Paths.addTransaction;
  static const String monthlyGraph = _Paths.monthlyGraph;

}

abstract class _Paths {
  static const String splash = '/splash';
  static const String bottomNavMenu = '/bottom_nav_menu';
  static const String transaction = '/transaction';
  static const String category = '/category';
  static const String addCategory = '/add_category';
  static const String addTransaction = '/add_transaction';
  static const String monthlyGraph = '/monthly_graph';

}
