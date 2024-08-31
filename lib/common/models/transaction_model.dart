
import 'package:json_annotation/json_annotation.dart';

part 'transaction_model.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class TransactionModel {

  @JsonKey(name: "id", defaultValue: 0)
  int? id;

  @JsonKey(name: "created_at",)
  int createdAt;

  @JsonKey(name: "amount", defaultValue: 0)
  double amount;

  @JsonKey(name: "desc", defaultValue: "")
  String desc;

  @JsonKey(name: "category_id", defaultValue: 0)
  int? categoryId;

  TransactionModel({
    this.id,
    required this.createdAt,
    required this.amount,
    required this.desc,
    this.categoryId,
  });



  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionModelFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionModelToJson(this);
}