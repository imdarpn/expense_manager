
import 'package:expense_manager/common/constants/string_constants.dart';
import 'package:flutter/material.dart';
import '../../utils/custom_bottombar/custom_bottom_bar.dart';
import '../constants/color_constants.dart';

class CommonMethods {

  hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
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

}
