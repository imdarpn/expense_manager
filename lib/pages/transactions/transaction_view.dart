import 'package:expense_manager/common/widgets/common_scaffold.dart';
import 'package:expense_manager/common/widgets/date_list_item.dart';
import 'package:expense_manager/common/widgets/monthly_total_expense_income_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/widgets/month_calender.dart';
import 'transaction_controller.dart';

class TransactionView extends GetView<TransactionController> {
  const TransactionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
        showAppBar: true,
        showBackIcon: false,
        titleWidget: const MonthCalender(),
        showActions: true,
        actionsWidgets: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: IconButton(
              onPressed: () async {}, icon: const Icon(Icons.search_rounded)),
        ),
        body: ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(bottom: 75),
            shrinkWrap: true,
            itemCount: 5,
            itemBuilder: (context, pos) {
              if (pos == 0) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0, top: 8),
                  child: MonthlyTotalExpenseIncomeWidget(
                      monthTransactionModel: controller
                          .transactionState.totalMonthlyTransactionModel.value),
                );
              }
              return const DateListItem();
            }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          tooltip: 'Increment',
          child: const Icon(
            Icons.add,
            color: Colors.black,
          ),
        ));
  }
}
