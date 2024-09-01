import 'dart:async';
import 'package:expense_manager/common/database/table_name.dart';
import 'package:expense_manager/common/enum/loading_status.dart';
import 'package:expense_manager/common/methods/common_methods.dart';
import 'package:expense_manager/common/models/chart_model.dart';
import 'package:expense_manager/common/models/total_month_transaction_model.dart';
import 'package:expense_manager/common/models/transaction_model.dart';
import 'package:expense_manager/pages/monthly_graph/monthly_graph_state.dart';
import 'package:expense_manager/pages/transactions/transaction_state.dart';
import 'package:expense_manager/utils/extension_utils.dart';
import 'package:expense_manager/utils/logger_util.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../common/database/database_util.dart';

class MonthlyGraphController extends GetxController {
  var monthlyGraphState = MonthlyGraphState();

  @override
  void onInit() {

    getDataFromPreviousPage();
    super.onInit();
    fetchChartData();
  }

  void getDataFromPreviousPage() {
    monthlyGraphState.currentDate = Get.arguments['current_date'];
  }

  Future<void> fetchChartData() async {
    var transList = await Get.find<DatabaseUtil>().db.rawQuery(
      '''SELECT SUM(${TableName.transaction}.amount) AS total , count(${TableName.categories}.category_name) AS share , ${TableName.categories}.category_name ,  ${TableName.categories}.category_type  from ${TableName.transaction} LEFT JOIN ${TableName.categories}
          on ${TableName.transaction}.category_id = ${TableName.categories}.id
          WHERE ${TableName.transaction}.created_at BETWEEN ${CommonMethods.getFirstDate(monthlyGraphState.currentDate.value)} AND ${CommonMethods.getLastDate(monthlyGraphState.currentDate.value)}
          GROUP BY ${TableName.categories}.category_name
          ORDER BY share DESC
      ''',
    );
    logger.i("transList-- $transList");
    for (int i = 0; i < transList.length; i++) {
      if (transList[i]['category_name'] != null) {
        ChartModel chartModel = ChartModel.fromJson(transList[i]);
        monthlyGraphState.chartModelList.add(chartModel);
      }
    }
    update();
  }



}
