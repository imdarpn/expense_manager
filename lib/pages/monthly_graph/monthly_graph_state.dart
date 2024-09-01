import 'package:expense_manager/common/models/chart_model.dart';
import 'package:get/get.dart';

class MonthlyGraphState {
  Rx<DateTime> currentDate = DateTime.now().obs;
  RxList<ChartModel> chartModelList = RxList.empty();
}
