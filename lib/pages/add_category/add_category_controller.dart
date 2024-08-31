import 'package:expense_manager/pages/add_category/add_category_state.dart';
import 'package:expense_manager/utils/logger_util.dart';
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
    addCategoryState.categoryType.value = Get.arguments['type'];
  }

  void setTransactionType(CategoryType? newTransactionType) {
    if (newTransactionType != null) {
      addCategoryState.categoryType.value = newTransactionType;
    }
  }

  validateForm() {

  }


}
