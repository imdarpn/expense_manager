import 'package:expense_manager/common/database/database_util.dart';
import 'package:expense_manager/common/enum/category_type.dart';
import 'package:expense_manager/pages/category/category_state.dart';
import 'package:expense_manager/utils/logger_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController
    with GetTickerProviderStateMixin {
  var categoryState = CategoryState();
  @override
  void onInit() {
    categoryState.tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
    getCategoryTypeData(index: 0);
    super.onInit();
  }

  void changeIndex(int index) {
    getCategoryTypeData(index: index);
  }

  void getCategoryTypeData({int index = 0}) {
    if (index == 0) {
      categoryState.categoryExpenseModelList.value =
          DatabaseUtil().getCategoryByType(categoryType: CategoryType.expense);
      logger.i("CATEGORY LIST --${categoryState.categoryExpenseModelList.length}");
    } else {
      categoryState.categoryIncomeModelList.value =
          DatabaseUtil().getCategoryByType(categoryType: CategoryType.income);
      logger.i("CATEGORY LIST --${categoryState.categoryIncomeModelList.length}");
    }
    update();

  }
}
