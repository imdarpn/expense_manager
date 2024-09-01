import 'package:expense_manager/common/constants/font_constants.dart';
import 'package:expense_manager/common/constants/size_constants.dart';
import 'package:expense_manager/common/database/database_util.dart';
import 'package:expense_manager/common/enum/category_type.dart';
import 'package:expense_manager/common/models/category_model.dart';
import 'package:expense_manager/common/models/transaction_model.dart';
import 'package:expense_manager/common/widgets/common_text.dart';
import 'package:expense_manager/common/widgets/common_widgets.dart';
import 'package:expense_manager/pages/transactions/transaction_controller.dart';
import 'package:expense_manager/utils/extension_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../api_service/api_constant.dart';
import '../../routes/app_pages.dart';
import '../constants/color_constants.dart';
import '../methods/common_methods.dart';
import 'date_chip.dart';

class DateListItem extends StatelessWidget {
  final String date;
  final List<TransactionModel> transactions;

  const DateListItem(
      {super.key,
        required this.date,
        required this.transactions,
      });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: DateChip(
            label: date,
            transStats: Get.find<TransactionController>().transactionState.dailyStats[date],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(SizeConstants.kTextFieldBorderRadius),
            color: ColorConstants.whiteColor,
            boxShadow: [
              CommonWidgets.commonBoxShadow()
            ],
          ),
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: transactions.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, pos) {
              TransactionModel transaction = transactions[pos];
              CategoryModel? categoryModel;
              try {
                categoryModel = Get.find<DatabaseUtil>().categories.firstWhere(
                      (element) => element.id == transaction.categoryId,
                );
              } catch (e) {
                debugPrint('error in cat');
              }
              return ListTile(

                  onTap: () {
                    Get.toNamed(Routes.addTransaction,arguments: {
                    "edit": true,
                    "transaction": transaction
                    });
                  },
                  title: CommonText(
                    text:transaction.desc,
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonText(
                        text: categoryModel!.categoryName ,
                      )
                    ],
                  ),
                  trailing: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      CommonText(
                        text: "${ApiConstant.selectedCode} ${CommonMethods.getConversionRate(transaction.amount).formatAmount()}",
                        color: categoryModel.categoryType == CategoryType.income ? ColorConstants.greenColor : ColorConstants.redColor ,
                        fontSize: FontConstants.font_13,
                        fontWeight: FontWeightConstants.medium,
                      ),
                    ],
                  ));
            },
            separatorBuilder: (context,index) {
              return Divider(color: ColorConstants.greyColor.withOpacity(0.5),);
            },
          ),
        ),
      ],
    );
  }
}
