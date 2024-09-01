import 'package:expense_manager/api_service/api_constant.dart';
import 'package:expense_manager/common/constants/color_constants.dart';
import 'package:expense_manager/common/constants/font_constants.dart';
import 'package:expense_manager/common/constants/string_constants.dart';
import 'package:expense_manager/common/database/database_util.dart';
import 'package:expense_manager/common/models/category_model.dart';
import 'package:expense_manager/common/widgets/common_filled_button.dart';
import 'package:expense_manager/common/widgets/common_scaffold.dart';
import 'package:expense_manager/common/widgets/common_text.dart';
import 'package:expense_manager/common/widgets/common_text_field.dart';
import 'package:expense_manager/common/widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/enum/category_type.dart';
import '../../common/widgets/category_list_dialog.dart';
import '../../common/widgets/category_type_selector.dart';
import '../../common/widgets/delete_action.dart';
import '../../utils/logger_util.dart';
import 'add_transaction_controller.dart';

class AddTransactionView extends GetView<AddTransactionController> {
  const AddTransactionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return CommonScaffold(
        showAppBar: true,
        showBackIcon: true,
        showLabel: false,
        titleWidget: CommonText(
          text: controller.addTransactionState.isEdit.value ? StringConstants
              .editTransaction : StringConstants.addTransaction,
          fontSize: FontConstants.font_20,
          fontWeight: FontWeightConstants.bold,
        ),
        showActions: true,
        actionsWidgets: controller.addTransactionState.isEdit.value ? DeleteAction(
            onTap: () {
              controller.deleteTransaction();
            },
            thing:
            'transaction ${Get.arguments['transaction'].desc}') : SizedBox.shrink(),
        bodyPadding: EdgeInsets.all(16),
        body: SingleChildScrollView(
          child: Form(
            key: controller.addTransactionState.formKey,
            child: Column(
              children: <Widget>[

                CategoryTypeSelector(
                  onSelect: (categoryType) {
                    controller.addTransactionState.formKey.currentState
                        ?.reset();
                    controller.setTransactionType(categoryType);
                  },
                  currentType: controller.addTransactionState.categoryType,
                  showTransfer: false,
                ),
                SizedBox(height: 12,),
                CommonTextField(
                  hintText: StringConstants.category,
                  textEditingController: controller.addTransactionState
                      .categoryController,
                  errorMessage: StringConstants.errorTransactionCategory,
                  readOnly: true,
                  onTap: () async {
                    final List<CategoryModel> categories =
                    DatabaseUtil().getCategoryByType(
                        categoryType: controller.addTransactionState
                            .categoryType
                            .value);
                    if (categories.isEmpty) {
                      CommonWidgets.showSnackBar(
                        success: false,
                        StringConstants.errorCategoryListEmpty,
                      );
                    } else {
                      CategoryModel? category =
                      await showListDialog(
                        categories,
                      );
                      controller.setCategory(category);
                    }
                  },

                ),
                const SizedBox(height: 12),

                CommonTextField(
                  hintText: StringConstants.amount,
                  textEditingController: controller.addTransactionState
                      .amountController,
                  errorMessage: StringConstants.pleaseEnterAmount,
                  prefixIcon: CommonText(
                    text: ApiConstant.selectedCode,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeightConstants.medium,
                  ),
                  textInputType: TextInputType.numberWithOptions(decimal: true),
                  textInputAction: TextInputAction.next,

                  onTap: () async {},

                ),

                const SizedBox(height: 12),

                CommonTextField(
                  hintText: StringConstants.description,
                  textEditingController: controller.addTransactionState
                      .descController,
                  errorMessage: StringConstants.pleaseEnterDescription,
                  textInputAction: TextInputAction.done,
                  onTap: () async {},

                ),
                SizedBox(height: 12,),
                Row(
                  children: [
                    Flexible(
                      flex: 6,
                      child: CommonTextField(
                        hintText: StringConstants.date,
                        readOnly: true,
                        textEditingController: controller.addTransactionState
                            .dateController,
                        onTap: () async {
                          DateTime? dateTime = await showDatePicker(
                              context: context,
                              initialDate: controller.addTransactionState
                                  .transactionDate,
                              firstDate: DateTime(2000, 2, 13),
                              lastDate: DateTime(2100, 2, 13));
                          controller.setDate(dateTime);
                        },

                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Flexible(
                      flex: 4,
                      child: CommonTextField(
                        readOnly: true,
                        hintText: StringConstants.time,
                        textEditingController: controller.addTransactionState
                            .timeController,
                        onTap: () async {
                          TimeOfDay? time = await showTimePicker(
                              context: context,
                              initialTime: controller.addTransactionState
                                  .transactionTime);
                          controller.setTime(time);
                        },

                      ),
                    ),
                  ],
                ),


                const SizedBox(height: 40),
                CommonFilledButton(onPressed: () {
                  if (controller.addTransactionState.formKey.currentState!
                      .validate()) {
                    controller.saveTransaction();
                  }
                }, buttonText: StringConstants.addTransaction),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Future showListDialog(List<CategoryModel> categoryModelList,
      {CategoryModel? selectedItem}) {
    return Get.dialog(AlertDialog(
        content: CategoryListDialog(
          categoryModel: selectedItem,
          categoryModelList: categoryModelList,
        )));
  }
}
