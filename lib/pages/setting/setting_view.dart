import 'package:expense_manager/api_service/api_constant.dart';
import 'package:expense_manager/common/constants/color_constants.dart';
import 'package:expense_manager/common/constants/font_constants.dart';
import 'package:expense_manager/common/widgets/common_scaffold.dart';
import 'package:expense_manager/common/widgets/common_text.dart';
import 'package:expense_manager/common/widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/storage_utils.dart';
import 'setting_controller.dart';

class SettingView extends GetView<SettingController> {
  const SettingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
        showAppBar: true,
        showBackIcon: false,
        showLabel: false,
        titleWidget: const CommonText(
          text: "Rate Conversation",
          fontSize: FontConstants.font_20,
          fontWeight: FontWeightConstants.bold,
        ),
        body: Obx(() {
          return ListView.builder(
            itemCount: controller.currencyList!.value.length,
            itemBuilder: (context, index) {
              final currency = controller.currencyList![index].key;
              final rate = controller.currencyList![index].value;

              return GestureDetector(
                onTap: () async {
                  ApiConstant.selectedCode = currency;
                  ApiConstant.selectedCodePrice = double.parse(rate.toStringAsFixed(5));
                  controller.update();
                  controller.currencyList.refresh();

                  await StorageUtil.setData(
                    StorageUtil.keySelectedCode,
                    currency,
                  );
                  await StorageUtil.setData(
                    StorageUtil.keySelectedCodePrice,
                    double.parse(rate.toStringAsFixed(5)),
                  );
                },
                child: Container(
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                  decoration: BoxDecoration(
                    boxShadow: [CommonWidgets.commonBoxShadow()],
                    color: ApiConstant.selectedCode == currency ? ColorConstants.primaryColor : ColorConstants.whiteColor,

                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CommonText(
                        text: currency,
                        fontWeight: FontWeightConstants.medium,
                      ),
                      CommonText(
                        text: rate.toStringAsFixed(5),
                        fontWeight: FontWeightConstants.semiBold,
                        color: ColorConstants.accentColor,
                      )
                    ],
                  ),
                  // Display up to 5 decimal places
                ),
              );
            },
          );
        }),
    );
  }


}
