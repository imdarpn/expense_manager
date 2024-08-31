import 'package:expense_manager/pages/category/category_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController with GetTickerProviderStateMixin{

  var categoryState = CategoryState();
  @override
  void onInit() {

    categoryState.tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
    super.onInit();
  }
}
