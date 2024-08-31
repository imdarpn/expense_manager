import 'package:expense_manager/common/database/database_util.dart';
import 'package:expense_manager/common/models/category_model.dart';
import 'package:expense_manager/pages/add_category/add_category_state.dart';
import 'package:get/get.dart';

import '../../common/enum/category_type.dart';

class AddCategoryController extends GetxController {
  var addCategoryState = AddCategoryState();
  @override
  void onInit() {
    super.onInit();
    getDataFromPreviousPage();
  }

  void getDataFromPreviousPage() {
    if (Get.arguments['edit']) {
      categoryDataFromPrevious(Get.arguments['category']);
    } else {
      addCategoryState.categoryType.value = Get.arguments['type'];
    }
  }

  void setTransactionType(CategoryType? newTransactionType) {
    if (newTransactionType != null) {
      addCategoryState.categoryType.value = newTransactionType;
    }
  }

  Future<void> addCategory() async {
    await DatabaseUtil().addCategory(CategoryModel(
      categoryName: addCategoryState.categoryNameController.text,
      categoryType: addCategoryState.categoryType.value,
      createdAt: DateTime.now(),
      isDeleted: 0,
    ));

    Get.back(result: true);
  }

  Future<void> updateCategory() async {
    await DatabaseUtil().updateCategory(CategoryModel(
      id: addCategoryState.updateId,
      categoryName: addCategoryState.categoryNameController.text,
      categoryType: addCategoryState.categoryType.value,
      createdAt: DateTime.now(),
      isDeleted: 0,
    ));

    Get.back(result: true);
  }

  void categoryDataFromPrevious(CategoryModel category) {
    addCategoryState.isEdit.value = true;
    addCategoryState.selectedCategoryModel = category;
    addCategoryState.categoryNameController.text = category.categoryName;
    addCategoryState.categoryType.value = category.categoryType;
    addCategoryState.updateId = category.id!;
    update();
  }
}
