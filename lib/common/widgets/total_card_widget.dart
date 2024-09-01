import 'package:expense_manager/api_service/api_constant.dart';
import 'package:expense_manager/common/constants/color_constants.dart';
import 'package:expense_manager/common/constants/size_constants.dart';
import 'package:expense_manager/common/methods/common_methods.dart';
import 'package:expense_manager/common/widgets/common_text.dart';
import 'package:expense_manager/utils/extension_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/font_constants.dart';
import 'common_widgets.dart';


class TotalCardWidget extends StatelessWidget {
  final Map<String, double> statsMap;
  const TotalCardWidget({super.key, required this.statsMap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(SizeConstants.kTextFieldBorderRadius),
          color: ColorConstants.whiteColor,
          boxShadow: [
            CommonWidgets.commonBoxShadow()
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _StatItem(
              title: statsMap.keys.first,
              value: statsMap.values.first,
              customColor: ColorConstants.greenColor,
            ),
            _StatItem(
              title: statsMap.keys.elementAt(1),
              value: statsMap.values.elementAt(1),
              customColor: ColorConstants.redColor,
            ),
            _StatItem(
              title: statsMap.keys.elementAt(2),
              value: statsMap.values.elementAt(2),
              customColor: ColorConstants.accentColor,
            ),
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String title;
  final double value;
  final Color? customColor;
  const _StatItem(
      {required this.title,
      required this.value,
      this.customColor,});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: SizedBox(
        width: (Get.width - 40) * 0.3,
        child: Column(
          children: [
            CommonText(
              text: title,
              fontWeight: FontWeightConstants.medium,
              fontSize: FontConstants.font_16,
            ),
            const SizedBox(
              height: 4,
            ),
            FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerRight,
              child: CommonText(
                text: "${ApiConstant.selectedCode} ${CommonMethods.getConversionRate(value).formatAmount()}",
                  fontWeight: FontWeightConstants.regular,
                  fontSize: FontConstants.font_14,
                color: customColor
              ),
            )
          ],
        ),
      ),
    );
  }
}
