
import 'dart:convert';

import 'package:expense_manager/common/constants/string_constants.dart';
import 'package:json_annotation/json_annotation.dart';

import '../enum/category_type.dart';

part 'chart_model.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ChartModel {

  @JsonKey(name: "total", defaultValue: 0.00)
  double? total;

  @JsonKey(name: "share", defaultValue: 0)
  int? share;

  @JsonKey(name: "category_type", defaultValue: '')
 String? categoryType;

  @JsonKey(name: "category_name", defaultValue: '')
  String? categoryName;



  ChartModel({
    this.total,
    this.share,
    this.categoryType,
    this.categoryName
  });



  factory ChartModel.fromJson(Map<String, dynamic> json) =>
      _$ChartModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChartModelToJson(this);


}