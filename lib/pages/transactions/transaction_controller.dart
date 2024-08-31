import 'dart:async';
import 'package:expense_manager/common/models/total_month_transaction_model.dart';
import 'package:expense_manager/pages/transactions/transaction_state.dart';
import 'package:get/get.dart';

class TransactionController extends GetxController {
  var transactionState = TransactionState();

  @override
  void onInit() {
    transactionState.totalMonthlyTransactionModel.value =
        TotalMonthTransactionModel(
            income: 1000.00, expense: 500.00, total: 500.00);

    super.onInit();
  }
}
