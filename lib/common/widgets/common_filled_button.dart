import 'package:expense_manager/common/constants/color_constants.dart';
import 'package:expense_manager/common/constants/size_constants.dart';
import 'package:expense_manager/utils/extension_utils.dart';
import 'package:flutter/material.dart';

import '../constants/font_constants.dart';
import '../methods/common_methods.dart';
import 'common_text.dart';

class CommonFilledButton extends StatelessWidget {
  final bool allowAnimation;
  final void Function()? onPressed;
  final String buttonText;
  final Color? buttonColor;
  final Color buttonTextColor;
  final double? fontSize;
  final FontWeight fontWeight;
  final double? buttonWidth;
  final double? buttonHeight;

  const CommonFilledButton({
    super.key,
    this.allowAnimation = true,
    required this.onPressed,
    required this.buttonText,
    this.buttonTextColor = ColorConstants.whiteColor,
    this.buttonColor,
    this.fontSize,
    this.fontWeight = FontWeightConstants.medium,
    this.buttonWidth,
    this.buttonHeight,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () {
        CommonMethods().hideKeyboard(context);
        onPressed?.call();
      },
      style: FilledButton.styleFrom(
        backgroundColor: buttonColor ?? ColorConstants.primaryColor,
        minimumSize: Size(
          buttonWidth ?? double.infinity,
          buttonHeight ?? SizeConstants.kButtonHeight,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SizeConstants.kTextFieldBorderRadius), // Set the radius here
        ),

      ),
      child: CommonText(
        text: buttonText,
        textAlign: TextAlign.center,
        color: buttonTextColor,
        fontSize: fontSize ?? FontConstants.font_18,
        fontWeight: fontWeight,
      ),
    ).addDominoEffect(isEnabled: allowAnimation);
  }
}
