import 'package:expense_manager/common/constants/color_constants.dart';
import 'package:flutter/cupertino.dart';

class CommonWidgets {
  static BoxShadow commonBoxShadow () {
    return BoxShadow(
      color: ColorConstants.greyColor.withOpacity(0.2),
      spreadRadius: 1,
      blurRadius: 8,
    );
  }
}