import 'package:expense_manager/common/constants/size_constants.dart';
import 'package:expense_manager/common/widgets/common_text.dart';
import 'package:expense_manager/common/widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constants/color_constants.dart';

class DateListItem extends StatelessWidget {

  const DateListItem(
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(SizeConstants.kTextFieldBorderRadius),
            color: ColorConstants.whiteColor,
            boxShadow: [
              CommonWidgets.commonBoxShadow()
            ],
          ),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: 4,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, pos) {

              return ListTile(

                  onTap: () {},
                  title: const CommonText(
                    text:"transaction.desc",
                  ),
                  subtitle: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonText(
                        text: "CategoryName",
                      )
                    ],
                  ),
                  trailing: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const CommonText(
                        text: "100",
                      ),
                      CommonText(
                         text:  DateFormat('dd-MM-yyyy | hh:mm a')
                              .format(DateTime.now())
                      )
                    ],
                  ));
            },
          ),
        ),
      ],
    );
  }
}
