import 'package:get/get.dart';
import 'add_category_controller.dart';

class AddCategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AddCategoryController>(AddCategoryController());
  }
}
