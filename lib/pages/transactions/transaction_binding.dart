import 'package:get/get.dart';
import 'transaction_controller.dart';

class TransactionBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<TransactionController>(TransactionController());
  }
}
