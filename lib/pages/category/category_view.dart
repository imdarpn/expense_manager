import 'package:expense_manager/common/constants/font_constants.dart';
import 'package:expense_manager/common/constants/string_constants.dart';
import 'package:expense_manager/common/widgets/common_scaffold.dart';
import 'package:expense_manager/common/widgets/common_text.dart';
import 'package:expense_manager/common/widgets/date_list_item.dart';
import 'package:expense_manager/common/widgets/monthly_total_expense_income_widget.dart';
import 'package:expense_manager/utils/logger_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/enum/category_type.dart';
import '../../common/widgets/category_list.dart';
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
                    CategoryList(
                      categoryType: CategoryType.expense,
                      categoryTypeList:
                      controller.categoryState.categoryExpenseModelList,
                    ),
                    CategoryList(
                      categoryType: CategoryType.income,
                      categoryTypeList:
                      controller.categoryState.categoryIncomeModelList,
                    )
                  ],
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Get.toNamed(Routes.addCategory, arguments: {
                "type": controller.categoryState.tabController.index == 0
                    ? CategoryType.expense
                    : CategoryType.income
              })!
                  .then((value) {
                    logger.i("VALUE -- $value");
                if (value != null && value == true) {
                  controller.getCategoryTypeData(index:
                      controller.categoryState.tabController.index);
                  controller.categoryState.categoryIncomeModelList.refresh();
                  controller.categoryState.categoryExpenseModelList.refresh();
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
}
