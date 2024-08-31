import 'package:expense_manager/common/models/total_month_transaction_model.dart';
import 'package:expense_manager/common/models/transaction_model.dart';
import 'package:get/get.dart';

import '../../common/enum/loading_status.dart';

class TransactionState {
  Rx<TotalMonthTransactionModel> totalMonthlyTransactionModel = TotalMonthTransactionModel(income: 0, expense: 0, total: 0).obs;
  Rx<DateTime> currentDate = DateTime.now().obs;
  RxString query = ''.obs;
  Rx<LoadingStatus> loadingState = LoadingStatus.loading.obs;
  RxMap<String, List<TransactionModel>> transactions = <String, List<TransactionModel>>{}.obs;

  RxMap<String, TotalMonthTransactionModel> dailyStats = <String, TotalMonthTransactionModel>{}.obs;
}
