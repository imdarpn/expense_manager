import 'package:expense_manager/common/constants/string_constants.dart';
import 'package:expense_manager/common/models/total_month_transaction_model.dart';
import 'package:expense_manager/common/widgets/total_card_widget.dart';
import 'package:flutter/material.dart';

class MonthlyTotalExpenseIncomeWidget extends StatelessWidget {

  final TotalMonthTransactionModel monthTransactionModel;

  const MonthlyTotalExpenseIncomeWidget({super.key, required this.monthTransactionModel});

  @override
  Widget build(BuildContext context) {
    return TotalCardWidget(statsMap: {
      StringConstants.income: monthTransactionModel.income,
      StringConstants.expense: monthTransactionModel.expense,
      StringConstants.total: monthTransactionModel.total
    });
  }
}
