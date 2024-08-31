import 'package:expense_manager/common/widgets/common_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NoDataFound extends StatelessWidget {
  const NoDataFound({super.key, required this.assetName, required this.label});
  final String assetName;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            assetName,
            semanticsLabel: 'No Data',
            height: 200,
            width: 200,
          ),
          const SizedBox(
            height: 30,
          ),
          CommonText(text: label,textAlign: TextAlign.center,)
        ],
      ),
    );
  }
}
