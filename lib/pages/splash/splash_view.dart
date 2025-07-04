import 'package:expense_manager/common/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: ColorConstants.whiteColor,
      child: const Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: FlutterLogo(
            size: 100, // Customize the size of the logo
          ),
        ),
      ),
    );
  }
}
