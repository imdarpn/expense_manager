import 'package:expense_manager/common/constants/color_constants.dart';
import 'package:expense_manager/common/widgets/common_scaffold.dart';
import 'package:expense_manager/common/widgets/common_text.dart';
import 'package:expense_manager/common/widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../common/widgets/pie_chart.dart';
import 'monthly_graph_controller.dart';

class MonthlyGraphView extends GetView<MonthlyGraphController> {
  const MonthlyGraphView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
        showAppBar: true,
        showBackIcon: true,
        titleWidget: Padding(
          padding: const EdgeInsets.only(right: 20),
          child: CommonText(
            text: DateFormat("MMM y").format(Get.arguments['current_date'].value),

          ),
        ),
        body: Obx(() {
          return Column(
            children: [
              PieChartWidget(controller.monthlyGraphState.chartModelList),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.symmetric(vertical: 4,horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [CommonWidgets.commonBoxShadow()]
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 8,),
                        Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            color: controller.monthlyGraphState
                                .chartModelList[index].categoryType ==
                                "income"
                                ? ColorConstants.greenColor
                                : ColorConstants.redColor,
                          ),
                        ),
                        const SizedBox(width: 12,),
                        Expanded(
                          child: CommonText(
                            text: controller.monthlyGraphState.chartModelList[index]
                                .categoryName ??
                                "",
                            color: Colors.black,
                          ),
                        ),
                        CommonText(
                          text: controller
                              .monthlyGraphState.chartModelList[index].total!
                              .toStringAsFixed(2),
                        ),
                      ],
                    ),


                  );
                },
                itemCount: controller.monthlyGraphState.chartModelList.length,
              )
            ],
          );
        }));
  }
}
