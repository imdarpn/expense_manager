import 'package:expense_manager/common/constants/image_constants.dart';
import 'package:expense_manager/common/constants/string_constants.dart';
import 'package:expense_manager/common/enum/loading_status.dart';
import 'package:expense_manager/common/widgets/common_scaffold.dart';
import 'package:expense_manager/common/widgets/date_list_item.dart';
import 'package:expense_manager/common/widgets/monthly_total_expense_income_widget.dart';
import 'package:expense_manager/common/widgets/no_data_found.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/widgets/month_calender.dart';
import '../../routes/app_pages.dart';
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
        actionsWidgets: Obx(
          () => Container(
            child: controller.transactionState.transactions.isEmpty
                ? Container()
                : Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: IconButton(
                        onPressed: () {
                          Get.toNamed(Routes.monthlyGraph,arguments: {
                            "current_date":controller.transactionState.currentDate
                          });
                        },
                        icon: const Icon(Icons.line_axis_outlined)),
                  ),
          ),
        ),
        body: Obx(() {
          if (controller.transactionState.transactions.isEmpty &&
              controller.transactionState.loadingState.value !=
                  LoadingStatus.loading) {
            return const NoDataFound(
                assetName: ImageConstants.noTransactionFound,
                label: StringConstants.noTransactionForSelectedMonth);
          } else if (controller.transactionState.transactions.isEmpty &&
              controller.transactionState.loadingState.value ==
                  LoadingStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(bottom: 75),
              shrinkWrap: true,
              itemCount: controller.transactionState.transactions.length + 1,
              itemBuilder: (context, pos) {
                if (pos == 0) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0, top: 8),
                    child: MonthlyTotalExpenseIncomeWidget(
                        monthTransactionModel: controller.transactionState
                            .totalMonthlyTransactionModel.value),
                  );
                }
                return DateListItem(
                    date: controller.transactionState.transactions.keys
                        .elementAt(pos - 1),
                    transactions: controller
                        .transactionState.transactions.values
                        .elementAt(pos - 1));
              });
        }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed(Routes.addTransaction,arguments: {
              "edit":false
            });
          },
          tooltip: 'Increment',
          child: const Icon(
            Icons.add,
            color: Colors.black,
          ),
        ));
  }
}
