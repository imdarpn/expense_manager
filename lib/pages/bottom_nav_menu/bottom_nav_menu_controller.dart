
import 'dart:convert';

import 'package:expense_manager/api_service/api_constant.dart';
import 'package:expense_manager/common/methods/common_methods.dart';
import 'package:expense_manager/common/remote_repository/api_repository.dart';
import 'package:expense_manager/pages/category/category_binding.dart';
import 'package:expense_manager/pages/category/category_view.dart';
import 'package:expense_manager/pages/setting/setting_binding.dart';
import 'package:expense_manager/pages/setting/setting_view.dart';
import 'package:expense_manager/pages/transactions/transaction_binding.dart';
import 'package:expense_manager/pages/transactions/transaction_view.dart';
import 'package:expense_manager/utils/logger_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/app_pages.dart';
import '../../utils/storage_utils.dart';


class BottomNavMenuController extends GetxController with GetSingleTickerProviderStateMixin  {
   final currentIndex = 0.obs;
   late TabController? tabController;

   final _apiRepository = Get.find<ApiRepository>();


  final pages = <String>[
    Routes.transaction,
    Routes.category,
    Routes.setting,
  ];

  @override
  void onInit() {
    // TODO: implement onInit
    tabController = TabController(vsync: this, length: pages.length);

    getDefaultData();

    super.onInit();
  }

   Future<void> callExchangeRateAPI() async {
     try {
       var response = await _apiRepository.getExchangeRateAPI();

       if (response.result != null && response.result == "success") {
         logger.i("SUCCESS --- $response");
         logger.i("conversion_rates --- ${response.conversionRates}");

         await StorageUtil.setData(
           StorageUtil.keyConversionData,
           json.encode(response),
         );

       }
     } catch (error) {
       logger.e("ERROR -- $error");
     }
   }

   Future<void> getDefaultData() async {
     var selectedCode = await StorageUtil.getData(StorageUtil.keySelectedCode);
     if (selectedCode != null) {
       ApiConstant.selectedCode = selectedCode;
       ApiConstant.selectedCodePrice = await StorageUtil.getData(StorageUtil.keySelectedCodePrice);
     }

     var savedResponse = await StorageUtil.getExchangeRateModel();
     if (savedResponse.result == "failure") {
       callExchangeRateAPI();
     } else if (savedResponse.result == "success") {
       DateTime todayDate = DateTime.now();
       DateTime apiDate = CommonMethods.getLastAPIDateTime(savedResponse.timeLastUpdateUtc);
       if (todayDate.year == apiDate.year &&
           todayDate.month == apiDate.month &&
           todayDate.day == apiDate.day) {
         logger.d("API ALREADY CALLED");
         logger.d("MAP DATA -- ${savedResponse.conversionRates}");
       } else {
         callExchangeRateAPI();
       }
     }
   }

  void changePage(int index) {
      if (index != currentIndex.value) {
        currentIndex.value = index;
        Get.offNamed(pages[index], id: 0);
      }

  }

  @override
  void onReady() {
    super.onReady();

    if (Get.arguments != null) {

    }
  }





  Route? onGenerateRoute(RouteSettings settings) {
    if (settings.name == Routes.transaction) {
      return GetPageRoute(
        settings: settings,
        page: () => const TransactionView(),
        binding: TransactionBinding(),);
    } else if (settings.name == Routes.category) {
      return GetPageRoute(
        settings: settings,
        page: () => const CategoryView(),
        binding: CategoryBinding(),);
    } else if (settings.name == Routes.setting) {
      return GetPageRoute(
        settings: settings,
        page: () => const SettingView(),
        binding: SettingBinding(),);
    }

   return null;

  }

  @override
  void onClose() {
    tabController!.dispose();
    super.onClose();
  }



}
