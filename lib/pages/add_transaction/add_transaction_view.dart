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
import '../../utils/logger_util.dart';
import 'add_transaction_controller.dart';

class AddTransactionView extends GetView<AddTransactionController> {
  const AddTransactionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      showAppBar: true,
      showBackIcon: true,
      showLabel: false,
      titleWidget: CommonText(
        text: "Add Transaction",
        fontSize: FontConstants.font_20,
        fontWeight: FontWeightConstants.bold,
      ),
      bodyPadding: EdgeInsets.all(16),
      body: Form(
        key: controller.addTransactionState.formKey,
        child: Column(
          children: <Widget>[

            CategoryTypeSelector(
              onSelect: (categoryType) {
                controller.addTransactionState.formKey.currentState?.reset();
                controller.setTransactionType(categoryType);
              },
              currentType: controller.addTransactionState.categoryType,
              showTransfer: false,
            ),
            SizedBox(height: 8,),
            CommonTextField(
              hintText: StringConstants.category,
              textEditingController: controller.addTransactionState
                  .categoryController,
              errorMessage: "Transaction must have a category",
              readOnly: true,
              onTap: () async {
                final List<CategoryModel> categories =
                DatabaseUtil().getCategoryByType(categoryType:controller.addTransactionState.categoryType.value);
                if (categories.isEmpty) {
                  CommonWidgets.showSnackBar(
                      success: false,
                      "Please add a category first to continue :) ",
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
            const SizedBox(height: 8),

            CommonTextField(
              hintText: "Amount",
              textEditingController: controller.addTransactionState
                  .amountController,
              errorMessage: "A transaction without any amount? idts :(",
              onTap: () async {
              },

            ),

            const SizedBox(height: 8),

            CommonTextField(
              hintText: "Description",
              textEditingController: controller.addTransactionState
                  .descController,
              errorMessage: "Add a short description",
              onTap: () async {
              },

            ),
            SizedBox(height: 8,),
            Row(
              children: [
                Flexible(
                  flex: 6,
                  child: CommonTextField(
                    hintText: "Date",
                    readOnly: true,
                    textEditingController: controller.addTransactionState
                        .dateController,
                    errorMessage: "Add a short description",
                    onTap: () async {
                      DateTime? dateTime = await showDatePicker(
                          context: context,
                          initialDate: controller.addTransactionState.transactionDate,
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
                  child:  CommonTextField(
                    readOnly: true,
                    hintText: "Time",
                    textEditingController: controller.addTransactionState
                        .timeController,
                    errorMessage: "Add a short description",
                    onTap: () async {
                      TimeOfDay? time = await showTimePicker(
                          context: context,
                          initialTime: controller.addTransactionState.transactionTime);
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
            }, buttonText: "Add Transaction"),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Future showListDialog(List<CategoryModel> categoryModelList, {CategoryModel? selectedItem}) {
    return Get.dialog(AlertDialog(
        content: CategoryListDialog(
          categoryModel: selectedItem,
          categoryModelList: categoryModelList,
        )));
  }
}
