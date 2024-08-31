import 'package:expense_manager/common/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryState {
  late TabController tabController;
  RxList<CategoryModel> categoryExpenseModelList = <CategoryModel>[].obs;
  RxList<CategoryModel> categoryIncomeModelList = <CategoryModel>[].obs;

}
