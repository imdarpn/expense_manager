
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:expense_manager/api_service/api_constant.dart';
import 'package:expense_manager/common/constants/string_constants.dart';
import 'package:expense_manager/utils/logger_util.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../utils/custom_bottombar/custom_bottom_bar.dart';
import '../constants/color_constants.dart';

class CommonMethods {

  hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static Future<bool> checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.none)) {
      return false;
    } else {
      return true;
    }
  }



  static List<CustomBottomBarItem> getTabs(){
    return [

      /// Home
      CustomBottomBarItem(
        icon: const Icon(Icons.menu_book_outlined,color: ColorConstants.dividerColor,),
        activeIcon: const Icon(Icons.menu_book_outlined,color: ColorConstants.darkGreyColor,),
        title: const Text(StringConstants.transactions),
      ),

      /// Category
      CustomBottomBarItem(
        icon:  const Icon(Icons.category_outlined,color: ColorConstants.dividerColor,),
        activeIcon: const Icon(Icons.category_outlined,color: ColorConstants.darkGreyColor,),
        title: Text(StringConstants.category,),
      ),

      /// Setting
      CustomBottomBarItem(
        icon: const Icon(Icons.settings_outlined,color: ColorConstants.dividerColor,),
        activeIcon: const Icon(Icons.settings_outlined,color: ColorConstants.darkGreyColor,),

        title: Text(StringConstants.settings),
      ),


    ];
  }

  static int getFirstDate(DateTime currentDate) {
    return DateTime(currentDate.year, currentDate.month, 1)
        .millisecondsSinceEpoch;
  }

  static int getLastDate(DateTime currentDate) {
    DateTime dateTime = DateTime(currentDate.year, currentDate.month + 1, 0);
    return dateTime.millisecondsSinceEpoch;
  }

  static DateTime getNextMonth(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month + 1, dateTime.day);
  }

  static DateTime getLastAPIDateTime (String? apiDateTime) {
    // Define the date format
    DateFormat dateFormat = DateFormat("EEE, dd MMM yyyy HH:mm:ss Z");

    // Parse the date string to DateTime
    DateTime dateTime = dateFormat.parse(apiDateTime!, true);

    return dateTime;
  }

  static double getConversionRate(double value) {
    final baseRate = ApiConstant.baseCodePrice;
    final selectedRate = ApiConstant.selectedCodePrice;

    if (value == 0) {
      return 0;
    }

    // Calculate the conversion rate from base currency to selected currency
    return value * (selectedRate / baseRate);
  }

  static double storeConversionRateInDB(double value) {
    final baseRate = ApiConstant.baseCodePrice;
    final selectedRate = ApiConstant.selectedCodePrice;

    if (value == 0) {
      return 0;
    }

    // Calculate the conversion rate from base currency to selected currency
    return value * (baseRate / selectedRate);
  }

}
