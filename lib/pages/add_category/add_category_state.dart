import 'package:expense_manager/common/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/enum/category_type.dart';

class AddCategoryState {
  Rx<CategoryType> categoryType = CategoryType.expense.obs;
  final categoryNameController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  int updateId = 0;
  CategoryModel? selectedCategoryModel;
  RxBool isEdit = false.obs;
}
