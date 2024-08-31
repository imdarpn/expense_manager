import 'package:expense_manager/common/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryListDialog extends StatelessWidget {
  const CategoryListDialog(
      {super.key, required this.categoryModel, required this.categoryModelList});
  final CategoryModel? categoryModel;
  final List<CategoryModel> categoryModelList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: categoryModelList.length,
          itemBuilder: (context, pos) {
            return InkWell(
              onTap: () {
                Get.back(result: categoryModelList[pos]);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(categoryModelList[pos].categoryName.toString()),
              ),
            );
          }),
    );
  }
}
