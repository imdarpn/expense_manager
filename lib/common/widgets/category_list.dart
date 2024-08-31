import 'package:expense_manager/common/constants/image_constants.dart';
import 'package:expense_manager/common/constants/string_constants.dart';
import 'package:expense_manager/common/widgets/no_data_found.dart';
import 'package:flutter/material.dart';

import '../enum/category_type.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({
    super.key,
    required this.categoryType,
  });

  final CategoryType categoryType;

  @override
  Widget build(BuildContext context) {
    return const NoDataFound(
        assetName: ImageConstants.noCategoryFound,
        label: StringConstants.noCategoryFound);
  }
}
