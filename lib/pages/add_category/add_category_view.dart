import 'package:expense_manager/common/constants/font_constants.dart';
import 'package:expense_manager/common/constants/string_constants.dart';
import 'package:expense_manager/common/widgets/common_filled_button.dart';
import 'package:expense_manager/common/widgets/common_scaffold.dart';
import 'package:expense_manager/common/widgets/common_text.dart';
import 'package:expense_manager/common/widgets/common_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/enum/category_type.dart';
import '../../common/widgets/category_list.dart';
import '../../common/widgets/category_type_selector.dart';
import '../../utils/logger_util.dart';
import 'add_category_controller.dart';

class AddCategoryView extends GetView<AddCategoryController> {
  const AddCategoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
        showAppBar: true,
        showBackIcon: true,
        showLabel: false,
        titleWidget: const CommonText(
          text: StringConstants.addCategory,
          fontSize: FontConstants.font_20,
          fontWeight: FontWeightConstants.bold,
        ),
        bodyPadding: EdgeInsets.all(16),
        body: Form(
          key: controller.addCategoryState.formKey,
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              CommonTextField(
                hintText: StringConstants.addCategory,
                textEditingController: controller.addCategoryState.categoryNameController,
                errorMessage: StringConstants.errorCategoryName,

              ),
              const SizedBox(height: 8),
              CategoryTypeSelector(
                onSelect: controller.setTransactionType,
                currentType: controller.addCategoryState.categoryType,
              ),

              const SizedBox(height: 40),
              CommonFilledButton(onPressed: (){}, buttonText: StringConstants.addCategory),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
       );
  }
}
