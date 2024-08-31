import 'package:expense_manager/common/constants/image_constants.dart';
import 'package:expense_manager/common/constants/string_constants.dart';
import 'package:expense_manager/common/database/database_util.dart';
import 'package:expense_manager/common/models/category_model.dart';
import 'package:expense_manager/common/widgets/common_text.dart';
import 'package:expense_manager/common/widgets/no_data_found.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../routes/app_pages.dart';
import '../enum/category_type.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({
    super.key,
    required this.categoryType,
    required this.categoryTypeList,
  });

  final CategoryType categoryType;
  final List<CategoryModel> categoryTypeList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: categoryTypeList.isEmpty
          ? const NoDataFound(
              assetName: ImageConstants.noCategoryFound,
              label: StringConstants.noCategoryFound)
          : ListView.builder(
              itemCount: categoryTypeList.length,
              padding: const EdgeInsets.only(bottom: 75),
              itemBuilder: (context, index) {
                final CategoryModel category = categoryTypeList[index];
                return ListTile(
                  onTap: () {
                    Get.toNamed(Routes.addCategory, arguments:
                      {"edit": true, "category": category}
                    );
                  },
                  title: CommonText(text: category.categoryName),
                  subtitle: category.createdAt != null
                      ? CommonText(
                          text: DateFormat.yMMMMd('en_US')
                              .format(category.createdAt!),
                        )
                      : null,
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                  ),
                );
              },
            ),
    );
  }
}
