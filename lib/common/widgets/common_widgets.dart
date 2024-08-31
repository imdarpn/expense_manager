import 'package:expense_manager/common/constants/color_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/logger_util.dart';
import '../constants/font_constants.dart';

class CommonWidgets {
  static BoxShadow commonBoxShadow() {
    return BoxShadow(
      color: ColorConstants.greyColor.withOpacity(0.2),
      spreadRadius: 1,
      blurRadius: 8,
    );
  }

  static showSnackBar(String message, {bool success = true}) {
    if (Get.isSnackbarOpen) {
      Get.closeCurrentSnackbar();
    }

    Get.snackbar(
      '',
      '',
      snackPosition: SnackPosition.TOP,
      snackStyle: SnackStyle.FLOATING,
      messageText: Text(
        message,
        style: const TextStyle(
          color: ColorConstants.whiteColor,
          fontFamily: FontFamilyConstants.fontName,
          fontWeight: FontWeightConstants.regular,
        ),
      ),
      titleText: Container(),
      // borderColor: ColorConstants.borderColor,
      borderWidth: 1,
      backgroundColor:
          success ? ColorConstants.greenColor : ColorConstants.redColor,
      colorText: Theme.of(Get.context!).colorScheme.surface,
      isDismissible: true,
      animationDuration: const Duration(milliseconds: 500),
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(10.0),
      mainButton: TextButton(
        child: success
            ? const Icon(
                Icons.done,
                color: Colors.white,
              )
            : const Icon(
                Icons.close,
                color: Colors.white,
              ),
        onPressed: () {
          if (Get.isSnackbarOpen) {
            Get.closeCurrentSnackbar();
          }
        },
      ),
    );
  }
}
