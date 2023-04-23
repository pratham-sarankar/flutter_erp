import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PaymentChart extends StatefulWidget {
  const PaymentChart({Key? key, required this.data}) : super(key: key);
  final List<num> data;

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
    return SfCartesianChart(
      primaryXAxis: CategoryAxis(
        labelStyle: GoogleFonts.poppins(),
        majorGridLines: const MajorGridLines(width: 0),
        minorGridLines: const MinorGridLines(width: 0),
      ),
      primaryYAxis: NumericAxis(
        minimum: 0,
        maximum: 100000,
        interval: 10000,
        labelStyle: GoogleFonts.poppins(),
      ),
      tooltipBehavior: TooltipBehavior(),
      series: <ChartSeries<_ChartData, String>>[
        ColumnSeries<_ChartData, String>(
          dataSource: [
            _ChartData('JAN', (widget.data[0] ?? 0).toDouble()),
            _ChartData('FEB', (widget.data[1] ?? 0).toDouble()),
            _ChartData('MAR', (widget.data[2] ?? 0).toDouble()),
            _ChartData('APRIL', (widget.data[3] ?? 0).toDouble()),
            _ChartData('MAY', (widget.data[4] ?? 0).toDouble()),
            _ChartData('JUNE', (widget.data[5] ?? 0).toDouble()),
            _ChartData('JULY', (widget.data[6] ?? 0).toDouble()),
            _ChartData('AUG', (widget.data[7] ?? 0).toDouble()),
            _ChartData('SEP', (widget.data[8] ?? 0).toDouble()),
            _ChartData('OCT', (widget.data[9] ?? 0).toDouble()),
            _ChartData('NOV', (widget.data[10] ?? 0).toDouble()),
            _ChartData('DEC', (widget.data[11] ?? 0).toDouble()),
          ],
          xValueMapper: (_ChartData data, _) => data.x,
          yValueMapper: (_ChartData data, _) => data.y,
          name: 'Gold',
          color: context.theme.primaryColorDark,
          spacing: 0.1,
        ),
      ],
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
