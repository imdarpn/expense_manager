import 'package:expense_manager/common/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/enum/category_type.dart';

class AddTransactionState {

  final TextEditingController categoryController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  CategoryModel? selectedCategory;
  late DateTime transactionDate;
  late TimeOfDay transactionTime;
  Rx<CategoryType> categoryType = CategoryType.expense.obs;
  RxBool isEdit = false.obs;
  final formKey = GlobalKey<FormState>();


}
