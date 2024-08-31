import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/enum/category_type.dart';

class AddCategoryState {
  Rx<CategoryType> categoryType = CategoryType.expense.obs;
  final categoryNameController = TextEditingController();
  final formKey = GlobalKey<FormState>();
}
