import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PaymentChart extends StatefulWidget {
  const PaymentChart({Key? key}) : super(key: key);

  @override
  State<PaymentChart> createState() => _PaymentChartState();
}

class _PaymentChartState extends State<PaymentChart> {
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SfCartesianChart(
        primaryXAxis: CategoryAxis(
          labelStyle: GoogleFonts.poppins(),
        ),
        primaryYAxis: NumericAxis(
          minimum: 0,
          maximum: 100,
          interval: 10,
          labelStyle: GoogleFonts.poppins(),
        ),
        tooltipBehavior: TooltipBehavior(),
        series: <ChartSeries<_ChartData, String>>[
          ColumnSeries<_ChartData, String>(
            dataSource: [
              _ChartData('JAN', 20),
              _ChartData('FEB', 30),
              _ChartData('MAR', 5),
              _ChartData('APRIL', 10),
              _ChartData('MAY', 14),
              _ChartData('JUNE', 60),
              _ChartData('JULY', 14),
              _ChartData('AUG', 30),
              _ChartData('SEP', 14),
              _ChartData('OCT', 76),
              _ChartData('NOV', 14),
              _ChartData('DEC', 19.20),
            ],
            xValueMapper: (_ChartData data, _) => data.x,
            yValueMapper: (_ChartData data, _) => data.y,
            name: 'Gold',
            color: context.theme.primaryColorDark,
          )
        ],
      ),
    );
  }
}

class _ChartData {
  final String title;
  final double value;

  _ChartData(this.title, this.value);

  String get x => title;

  double get y => value;
}
