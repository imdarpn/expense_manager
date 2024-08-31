import 'package:expense_manager/common/widgets/common_text.dart';
import 'package:expense_manager/pages/transactions/transaction_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MonthCalender extends StatelessWidget {
  const MonthCalender({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TransactionController>(
      builder: (controller) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
              onPressed: () {
              },
              icon: const Icon(Icons.chevron_left_rounded)),
          InkWell(
            child:CommonText(
          text: DateFormat("MMM y").format(DateTime.now())),
            onTap: () {}
          ),
          IconButton(
              onPressed: () {
              },
              icon: const Icon(Icons.chevron_right_rounded))
        ],
      ),
    );
  }
}
