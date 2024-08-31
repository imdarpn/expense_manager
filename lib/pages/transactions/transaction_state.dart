import 'package:expense_manager/common/models/total_month_transaction_model.dart';
import 'package:get/get.dart';

class TransactionState {
  Rx<TotalMonthTransactionModel> totalMonthlyTransactionModel =
      TotalMonthTransactionModel(income: 0, expense: 0, total: 0).obs;
}
