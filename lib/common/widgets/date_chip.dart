import 'package:expense_manager/common/constants/color_constants.dart';
import 'package:expense_manager/common/constants/font_constants.dart';
import 'package:expense_manager/common/models/total_month_transaction_model.dart';
import 'package:expense_manager/common/widgets/common_text.dart';
import 'package:expense_manager/utils/extension_utils.dart';
import 'package:flutter/material.dart';

import '../../api_service/api_constant.dart';
import '../methods/common_methods.dart';

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
            color: ColorConstants.accentColor,
            fontSize: FontConstants.font_14,
            fontWeight: FontWeightConstants.medium,


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
                    text: "${ApiConstant.selectedCode} ${CommonMethods.getConversionRate(transStats?.income ?? 0).formatAmount()}",

                    color: ColorConstants.greenColor,
                    textAlign: TextAlign.end,
                    fontSize: FontConstants.font_14,
                    fontWeight: FontWeightConstants.regular,
                  ),
                ),
              ),
              SizedBox(
                width: 85,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerRight,
                  child: CommonText(
                    text: "${ApiConstant.selectedCode} ${CommonMethods.getConversionRate(transStats?.expense ?? 0).formatAmount()}",
                    color: ColorConstants.redColor,
                    textAlign: TextAlign.end,
                    fontSize: FontConstants.font_14,
                    fontWeight: FontWeightConstants.regular,
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
