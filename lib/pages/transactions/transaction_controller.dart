import 'dart:async';
import 'package:expense_manager/common/database/table_name.dart';
import 'package:expense_manager/common/enum/loading_status.dart';
import 'package:expense_manager/common/methods/common_methods.dart';
import 'package:expense_manager/common/models/total_month_transaction_model.dart';
import 'package:expense_manager/common/models/transaction_model.dart';
import 'package:expense_manager/pages/transactions/transaction_state.dart';
import 'package:expense_manager/utils/extension_utils.dart';
import 'package:expense_manager/utils/logger_util.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../common/database/database_util.dart';

class TransactionController extends GetxController {
  var transactionState = TransactionState();

  @override
  void onInit() {
    transactionState.totalMonthlyTransactionModel.value =
        TotalMonthTransactionModel(
            income: 0.00, expense: 0.00, total: 0.00);

    super.onInit();
    fetchTransactions();
  }

  Future<void> fetchTransactions() async {
    transactionState.totalMonthlyTransactionModel.value = TotalMonthTransactionModel(income: 0,expense:  0, total: 0);
    transactionState.dailyStats.clear();
    transactionState.loadingState.value = LoadingStatus.loading;

    var transList = await Get.find<DatabaseUtil>().db.rawQuery(
      '''SELECT * from ${TableName.transaction} 
      WHERE created_at BETWEEN ${CommonMethods.getFirstDate(transactionState.currentDate.value)} AND ${CommonMethods.getLastDate(transactionState.currentDate.value)}
      ORDER BY created_at DESC''',
    );
    logger.i("LIST -- ${transList.length}");
    parseTransactions(transList, false);
    transactionState.loadingState.value = LoadingStatus.loaded;
  }

  void refreshListIfNeeded(DateTime dateTime) {
    if (transactionState.currentDate.value.isSameMonth(dateTime)) {
      fetchTransactions();
    }
  }

  void parseTransactions(List<Map<String, Object?>> list, bool isSearch) {
    Map<String, List<TransactionModel>> dateWiseTransactions = <String, List<TransactionModel>>{};
    Map<String, List<Map<String, Object?>>> dateWiseRaw = <String, List<Map<String, Object?>>>{};
    for (var transaction in list) {
      logger.i("DATE -- $transaction['created_at']");
      DateTime transactionDateTime = DateTime.fromMillisecondsSinceEpoch((transaction["created_at"] as int?) ?? 0);
      (dateWiseRaw[DateFormat.yMMMMd('en_US').format(transactionDateTime)] ??=
      []).add(transaction);
    }
    dateWiseRaw.forEach((date, rawTransactions) {
      List<TransactionModel> tempList = <TransactionModel>[];

      tempList.addAll(rawTransactions.map<TransactionModel>((rawTrans) {
        TransactionModel trans = TransactionModel.fromJson(rawTrans);

        // Update statistics only if not in search mode
        if (!isSearch) {
          (transactionState.dailyStats[date] ??= TotalMonthTransactionModel(income: 0, expense: 0, total: 0)).total += trans.amount;
          if (trans.amount.isNegative) {
            (transactionState.dailyStats[date] ??= TotalMonthTransactionModel(income: 0, expense: 0, total: 0)).expense +=
                trans.amount;
          } else {
            (transactionState.dailyStats[date] ??= TotalMonthTransactionModel(income: 0, expense: 0, total: 0)).income +=
                trans.amount;
          }
          transactionState.totalMonthlyTransactionModel.update((stats) {
            stats?.total += trans.amount;
            if (trans.amount.isNegative) {
              stats?.expense += trans.amount;
            } else {
              stats?.income += trans.amount;
            }
          });
        }

        return trans;
      }));
      tempList.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      dateWiseTransactions[date] = tempList;
    });

      transactionState.transactions.value = dateWiseTransactions;
    }

  void goToNextMonth() {
    transactionState.currentDate.value = CommonMethods.getNextMonth(transactionState.currentDate.value);
    fetchTransactions();
  }

  void goToPreviousMonth() {
    transactionState.currentDate.value = transactionState.currentDate.value.copyWith(month: transactionState.currentDate.value.month - 1);
    fetchTransactions();
  }

  void setDate(DateTime? dateTime) {
    if (dateTime != null) {
      transactionState.currentDate.value = dateTime;
      fetchTransactions();
    }
  }

}
