import 'package:expense_manager/common/constants/color_constants.dart';
import 'package:expense_manager/common/constants/font_constants.dart';
import 'package:expense_manager/common/constants/size_constants.dart';
import 'package:expense_manager/common/constants/string_constants.dart';
import 'package:expense_manager/common/widgets/common_scaffold.dart';
import 'package:expense_manager/common/widgets/common_text.dart';
import 'package:expense_manager/common/widgets/common_widgets.dart';
import 'package:expense_manager/common/widgets/date_list_item.dart';
import 'package:expense_manager/common/widgets/monthly_total_expense_income_widget.dart';
import 'package:expense_manager/common/widgets/no_data_found.dart';
import 'package:expense_manager/utils/extension_utils.dart';
import 'package:expense_manager/utils/logger_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../common/constants/image_constants.dart';
import '../../common/enum/category_type.dart';
import '../../common/models/category_model.dart';
import '../../common/widgets/month_calender.dart';
import '../../routes/app_pages.dart';
import 'category_controller.dart';

class CategoryView extends GetView<CategoryController> {
  const CategoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: CommonScaffold(
          showAppBar: true,
          showBackIcon: false,
          showLabel: false,
          titleWidget: const CommonText(
            text: StringConstants.categories,
            fontSize: FontConstants.font_20,
            fontWeight: FontWeightConstants.bold,
          ),
          body: Column(
            children: [
              TabBar(
                dividerColor:ColorConstants.transparentColor,
                controller: controller.categoryState.tabController,
                tabs: const [
                  Tab(
                    text: StringConstants.expense,
                  ),
                  Tab(
                    text: StringConstants.income,
                  )
                ],
                onTap: (index) {
                  controller.changeIndex(index);
                },
              ),
              Expanded(
                child: TabBarView(
                  controller: controller.categoryState.tabController,
                  children: [
                    categoryExpenseList(),
                    categoryIncomeList(),
                  ],
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Get.toNamed(Routes.addCategory, arguments: {
                "edit": false,
                "type": controller.categoryState.tabController.index == 0
                    ? CategoryType.expense
                    : CategoryType.income
              })!
                  .then((value) {
                logger.i("VALUE -- $value");
                if (value != null && value == true) {
                  controller.getCategoryTypeData(
                      index: controller.categoryState.tabController.index);
                  controller.categoryState.categoryIncomeModelList.refresh();
                  controller.categoryState.categoryExpenseModelList.refresh();
                  controller.update();
                }
              });
            },
            child: const Icon(
              Icons.add,
              color: Colors.black,
            ),
          )),
    );
  }

  Widget categoryExpenseList() {
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: controller.categoryState.categoryExpenseModelList.isEmpty
            ? const NoDataFound(
                assetName: ImageConstants.noCategoryFound,
                label: StringConstants.noCategoryFound)
            : ListView.builder(
                itemCount:
                    controller.categoryState.categoryExpenseModelList.length,
                padding: const EdgeInsets.only(bottom: 75),
                itemBuilder: (context, index) {
                  final CategoryModel category =
                      controller.categoryState.categoryExpenseModelList[index];
                  return GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.addCategory,
                          arguments: {"edit": true, "category": category});
                    },
                    child: Container(

                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                              SizeConstants.kTextFieldBorderRadius),
                          boxShadow: [CommonWidgets.commonBoxShadow()]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CommonText(text: category.categoryName),
                              CommonText(
                                text: DateFormat.yMMMMd('en_US')
                                    .format(category.createdAt!),
                              )
                            ],
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                          ),
                        ],
                      ),
                    ),
                  ).addDominoEffect();
                },
              ),
      );
    });
  }

  Widget categoryIncomeList() {
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: controller.categoryState.categoryIncomeModelList.isEmpty
            ? const NoDataFound(
                assetName: ImageConstants.noCategoryFound,
                label: StringConstants.noCategoryFound)
            : ListView.builder(
                itemCount:
                    controller.categoryState.categoryIncomeModelList.length,
                padding: const EdgeInsets.only(bottom: 75),
                itemBuilder: (context, index) {
                  final CategoryModel category =
                      controller.categoryState.categoryIncomeModelList[index];
                  return GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.addCategory,
                          arguments: {"edit": true, "category": category});
                    },
                    child: Container(

                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                              SizeConstants.kTextFieldBorderRadius),
                          boxShadow: [CommonWidgets.commonBoxShadow()]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CommonText(text: category.categoryName),
                              CommonText(
                                text: DateFormat.yMMMMd('en_US')
                                    .format(category.createdAt!),
                              )
                            ],
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                          ),
                        ],
                      ),
                    ),
                  ).addDominoEffect();
                },
              ),
      );
    });
  }
}
