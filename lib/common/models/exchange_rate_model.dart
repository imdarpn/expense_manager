
import 'dart:convert';

import 'package:expense_manager/common/constants/string_constants.dart';
import 'package:json_annotation/json_annotation.dart';

import '../enum/category_type.dart';

part 'exchange_rate_model.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ExchangeRateModel {

  @JsonKey(name: "result", defaultValue: "")
  String? result;

  @JsonKey(name: "baseCode", defaultValue:  "")
  String? baseCode;

  @JsonKey(name: "conversion_rates", defaultValue: {})
  Map<String,dynamic>? conversionRates;

  @JsonKey(name: "time_last_update_utc", defaultValue: "")
  String? timeLastUpdateUtc;


  ExchangeRateModel({
    this.result,
    required this.baseCode,
    required this.conversionRates,
    this.timeLastUpdateUtc
  });



  factory ExchangeRateModel.fromJson(Map<String, dynamic> json) =>
      _$ExchangeRateModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExchangeRateModelToJson(this);


}