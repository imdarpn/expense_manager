import 'package:expense_manager/common/constants/color_constants.dart';
import 'package:expense_manager/common/models/chart_model.dart';
import 'package:expense_manager/utils/logger_util.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PieChartWidget extends StatelessWidget {
  final List<ChartModel> chartModelList;

  const PieChartWidget(this.chartModelList, {super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: 1.5,
        child: PieChart(PieChartData(
          sections: _chartSections(chartModelList),
          centerSpaceRadius: 80.0,
        )));
  }

  List<PieChartSectionData> _chartSections(List<ChartModel> chartModelList) {
    final List<PieChartSectionData> list = [];
    for (var chartModel in chartModelList) {
      logger.i("TITLE== ${chartModel.categoryName}");
      const double radius = 20.0;
      final data = PieChartSectionData(
        titlePositionPercentageOffset: 2.6,
        color: chartModel.categoryType == "income"? ColorConstants.greenColor : ColorConstants.redColor,
        value: chartModel.total!.abs() ,
        radius: radius,
        title: chartModel.categoryName,
      );
      list.add(data);
    }
    return list;
  }
}
