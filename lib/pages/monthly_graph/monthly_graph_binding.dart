import 'package:get/get.dart';
import 'monthly_graph_controller.dart';

class MonthlyGraphBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<MonthlyGraphController>(MonthlyGraphController());
  }
}
