import 'package:expense_manager/common/widgets/common_text.dart';
import 'package:expense_manager/pages/transactions/transaction_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mat_month_picker_dialog/mat_month_picker_dialog.dart';

import '../constants/font_constants.dart';

class MonthCalender extends StatelessWidget {
  const MonthCalender({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TransactionController>(
      builder: (controller) =>
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                  onPressed: () {
                    controller.goToPreviousMonth();
                  },
                  icon: const Icon(Icons.chevron_left_rounded)),
              InkWell(
                  child: Obx(() {
                    return CommonText(
                        fontSize: FontConstants.font_17,
                        fontWeight: FontWeightConstants.regular,
                        text: DateFormat("MMM y").format(controller.transactionState.currentDate.value));
                  }),
                onTap: () async {
                  final DateTime? dateTime = await showMonthPicker(
                      context: context,
                      initialDate: controller.transactionState.currentDate.value,
                      firstDate: DateTime(2021, 1, 1),
                      lastDate: DateTime(2030, 12, 13));
                  controller.setDate(dateTime);
                },
              ),
              IconButton(
                  onPressed: () {
                    controller.goToNextMonth();
                  },
                  icon: const Icon(Icons.chevron_right_rounded))
            ],
          ),
    );
  }
}
