import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import 'package:intl/intl.dart';
import 'package:admin_desktop/domain/models/models.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';

class ChartPage extends StatefulWidget {
  final List<num> price;
  final List<DateTime> times;
  final List<IncomeChartResponse> chart;
  final bool isDay;

  const ChartPage(
      {super.key,
      required this.price,
      required this.chart,
      required this.times,
      required this.isDay});

  @override
  State<ChartPage> createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  List<Color> gradientColors = [
    Style.primary.withOpacity(0.5),
    Style.transparent,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 326,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Style.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppHelpers.getTranslation(TrKeys.saleChart),
            style: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.w600),
          ),
          24.verticalSpace,
          Expanded(
            child: widget.chart.isNotEmpty
                ? LineChart(
                    mainData(),
                  )
                : Center(
                    child: Text(
                      AppHelpers.getTranslation(TrKeys.needOrder),
                      style: GoogleFonts.inter(
                          fontSize: 22, fontWeight: FontWeight.w600),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    final style = GoogleFonts.inter(
      fontSize: 12,
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
          DateFormat(widget.isDay ? "HH:00" : "MMM d")
              .format(widget.times[value.ceil()]),
          style: style),
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    final style = GoogleFonts.inter(
      fontSize: 14,
    );
    return Text(
      AppHelpers.numberFormat(number: widget.price[value.toInt()]),
      style: style,
      textAlign: TextAlign.left,
    );
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
              color: Style.iconButtonBack, strokeWidth: 1, dashArray: [10]);
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 80,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      minX: 0,
      maxX: widget.times.length.toDouble() - 1,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: [
            for (int index = 0; index < widget.times.length; index++)
              FlSpot(
                  index.toDouble(),
                  widget.price.findPriceIndex(widget.isDay
                      ? widget.chart.findPriceWithHour(widget.times[index])
                      : widget.chart.findPrice(widget.times[index]))),
          ],
          isCurved: true,
          color: Style.primary,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: gradientColors,
            ),
          ),
        ),
      ],
    );
  }
}
