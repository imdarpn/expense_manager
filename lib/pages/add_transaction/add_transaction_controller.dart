import 'package:expense_manager/common/database/database_util.dart';
import 'package:expense_manager/common/database/table_name.dart';
import 'package:expense_manager/common/methods/common_methods.dart';
import 'package:expense_manager/common/models/category_model.dart';
import 'package:expense_manager/common/models/transaction_model.dart';
import 'package:expense_manager/pages/add_category/add_category_state.dart';
import 'package:expense_manager/pages/transactions/transaction_controller.dart';
import 'package:expense_manager/utils/extension_utils.dart';
import 'package:expense_manager/utils/logger_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/enum/category_type.dart';
import 'add_transaction_state.dart';

class AddTransactionController extends GetxController {
  var addTransactionState = AddTransactionState();
  @override
  void onInit() {
    super.onInit();
    getDataFromPreviousPage();
  }

  void getDataFromPreviousPage() {
    addTransactionState.isEdit.value = Get.arguments?['edit'] ?? false;
    if (addTransactionState.isEdit.value) {
      prefillTransaction(Get.arguments['transaction']);
    } else {
      setDate(DateTime.now());
      setTime(TimeOfDay.now());
    }

  }


  void setCategory(CategoryModel? category) {
    if (category == null) return;
    addTransactionState.selectedCategory = category;
    addTransactionState.categoryController.text = category.categoryName;
  }

  void setTransactionType(CategoryType newTransactionType) {
    addTransactionState.categoryType.value = newTransactionType;
    addTransactionState.selectedCategory = null;
    addTransactionState.categoryController.text = "";
  }

  void setDate(DateTime? dateTime) {
    if (dateTime == null) return;
    addTransactionState.transactionDate = dateTime;
    addTransactionState.dateController.text = dateTime.formatDate();
  }

  void setTime(TimeOfDay? time) {
    if (time == null) return;
    addTransactionState.transactionTime = time;
    addTransactionState.timeController.text = DateTime.now().copyTime(time).formatTime();
  }

  void saveTransaction() async {
    if (addTransactionState.isEdit.value) {
      await deleteTransaction(fromDelete: false);
    }
    DateTime combinedDateTime = addTransactionState.transactionDate.copyTime(addTransactionState.transactionTime);

    TransactionModel newTransaction = TransactionModel(
      createdAt: combinedDateTime.millisecondsSinceEpoch,
      amount: CommonMethods.storeConversionRateInDB(double.parse("${addTransactionState.categoryType.value == CategoryType.expense ? '-' : '+'}${addTransactionState.amountController.text}")),
      desc: addTransactionState.descController.text,
      categoryId: addTransactionState.selectedCategory!.id!,
    );
    newTransaction.id = await Get.find<DatabaseUtil>().db.insert(TableName.transaction, newTransaction.toJson());
    Get.back();
    Get.find<TransactionController>().refreshListIfNeeded(combinedDateTime);
  }

  Future<void> deleteTransaction({bool fromDelete = true}) async {

    await Get.find<DatabaseUtil>().db.delete(TableName.transaction,
        where: "id = ?", whereArgs: [addTransactionState.previousTransaction?.id]);
    if (fromDelete) {
      Get.back();
      Get.find<TransactionController>().fetchTransactions();
    }
  }

  void prefillTransaction(TransactionModel transaction) {
    addTransactionState.previousTransaction = transaction;
    setDate(DateTime.fromMillisecondsSinceEpoch(transaction.createdAt));
    setTime(TimeOfDay.fromDateTime(DateTime.fromMillisecondsSinceEpoch(transaction.createdAt)));
    addTransactionState.amountController.text = transaction.amount.toString().replaceFirst("-", "");
    addTransactionState.descController.text = transaction.desc;
      CategoryModel category = Get.find<DatabaseUtil>().categories
          .firstWhere((element) => element.id == transaction.categoryId);
      setTransactionType(category.categoryType);
      setCategory(category);

  }



}
