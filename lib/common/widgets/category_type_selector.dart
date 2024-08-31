import 'package:expense_manager/common/constants/color_constants.dart';
import 'package:expense_manager/common/constants/string_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../enum/category_type.dart';

class CategoryTypeSelector extends StatelessWidget {
  const CategoryTypeSelector(
      {super.key,
      required this.onSelect,
      required this.currentType,
      this.showTransfer = false});

  final Function(CategoryType) onSelect;
  final Rx<CategoryType> currentType;
  final bool showTransfer;

  @override
  Widget build(BuildContext context) {
    final categories = CategoryType.values.toList();
    return Row(
      children: categories
          .map<Widget>((item) => Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Obx(
                  () => ChoiceChip(
                      onSelected: (selected) {
                        if (selected) {
                          onSelect(item);
                        }
                      },
                      selectedColor: ColorConstants.accentColor,
                      label: Text({
                            CategoryType.expense: StringConstants.expense,
                            CategoryType.income: StringConstants.income,
                          }[item] ??
                          StringConstants.expense),
                      selected: currentType.value == item),
                ),
              ))
          .toList(),
    );
  }
}
