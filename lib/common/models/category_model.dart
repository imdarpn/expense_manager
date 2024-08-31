
import 'dart:convert';

import 'package:expense_manager/common/constants/string_constants.dart';
import 'package:json_annotation/json_annotation.dart';

import '../enum/category_type.dart';

part 'category_model.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class CategoryModel {

  @JsonKey(name: "id", defaultValue: 0)
  int? id;

  @JsonKey(name: "created_at",)
  DateTime createdAt;

  @JsonKey(name: "category_name", defaultValue: "")
  String categoryName;

  @JsonKey(name: "category_type", defaultValue: CategoryType.expense)
 CategoryType categoryType;

  @JsonKey(name: "is_deleted", defaultValue: 0)
  int? isDeleted;


  CategoryModel({
    this.id,
    required this.createdAt,
    required this.categoryType,
    required this.categoryName,
    this.isDeleted,
  });



  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);

  static List<CategoryModel> categoryFromJson(List<Map<String, Object?>> list) =>
      List<CategoryModel>.from(
        list.map((x) => CategoryModel.fromJson(x)),
      );

  static String categoryToJson(List<CategoryModel> data) =>
      json.encode(List<dynamic>.from(data.map(
            (categoryModel) => categoryModel.toJson(),
      )));
}