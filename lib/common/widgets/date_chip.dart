import 'package:expense_manager/common/models/total_month_transaction_model.dart';
import 'package:expense_manager/common/widgets/common_text.dart';
import 'package:flutter/material.dart';

class DateChip extends StatelessWidget {
  final String label;
  final TotalMonthTransactionModel? transStats;

  const DateChip({super.key, required this.label, required this.transStats});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: CommonText(
            text: label,

          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
          child: Row(
            children: [
              SizedBox(
                width: 85,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerRight,
                  child: CommonText(
                    text: transStats?.income.toStringAsFixed(2) ?? 0.toStringAsFixed(2),
                    // customColor: AppColors.accentColor,
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
              SizedBox(
                width: 85,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerRight,
                  child: CommonText(
                    text: transStats?.income.toStringAsFixed(2) ?? 0.toStringAsFixed(2),
                    // customColor: AppColors.accentColor,
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
