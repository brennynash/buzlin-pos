import 'package:admin_desktop/domain/models/response/income_statistic_response.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';

class PieChartPage extends StatefulWidget {
  final IncomeStatisticResponse statistic;

  const PieChartPage({super.key, required this.statistic});

  @override
  State<PieChartPage> createState() => _PieChartState();
}

class _PieChartState extends State<PieChartPage> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width / 3,
      height: 360,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Style.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppHelpers.getTranslation(TrKeys.statistics),
            style: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.w600),
          ),
          16.verticalSpace,
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: widget.statistic.group?.active?.percent == 0 &&
                          widget.statistic.group?.completed?.percent == 0 &&
                          widget.statistic.group?.ended?.percent == 0
                      ? Center(
                          child: Text(
                            AppHelpers.getTranslation(TrKeys.needOrder),
                            style: GoogleFonts.inter(
                                fontSize: 22, fontWeight: FontWeight.w600),
                          ),
                        )
                      : PieChart(
                          PieChartData(
                            pieTouchData: PieTouchData(
                              touchCallback:
                                  (FlTouchEvent event, pieTouchResponse) {
                                setState(() {
                                  if (!event.isInterestedForInteractions ||
                                      pieTouchResponse == null ||
                                      pieTouchResponse.touchedSection == null) {
                                    touchedIndex = -1;
                                    return;
                                  }
                                  touchedIndex = pieTouchResponse
                                      .touchedSection!.touchedSectionIndex;
                                });
                              },
                            ),
                            borderData: FlBorderData(
                              show: false,
                            ),
                            sectionsSpace: 2,
                            centerSpaceRadius: 64,
                            sections: showingSections(widget.statistic),
                          ),
                        ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border:
                                  Border.all(color: Style.primary, width: 3)),
                        ),
                        8.horizontalSpace,
                        Text(
                          AppHelpers.getTranslation(TrKeys.active),
                          style: GoogleFonts.inter(fontSize: 14),
                        ),
                      ],
                    ),
                    10.verticalSpace,
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border:
                                Border.all(color: Style.starColor, width: 3),
                          ),
                        ),
                        8.horizontalSpace,
                        Text(
                          AppHelpers.getTranslation(TrKeys.completed),
                          style: GoogleFonts.inter(fontSize: 14),
                        ),
                      ],
                    ),
                    10.verticalSpace,
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Style.red, width: 3)),
                        ),
                        8.horizontalSpace,
                        Text(
                          AppHelpers.getTranslation(TrKeys.ended),
                          style: GoogleFonts.inter(fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections(IncomeStatisticResponse statistic) {
    return List.generate(3, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 24.r : 16.r;
      final radius = isTouched ? 60.r : 50.r;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Style.primary,
            value: statistic.group?.active?.percent?.toDouble(),
            title: '${statistic.group?.active?.percent?.floor()}%',
            radius: radius,
            titleStyle: Style.interSemi(color: Style.white, size: fontSize),
          );
        case 1:
          return PieChartSectionData(
            color: Style.starColor,
            value: statistic.group?.completed?.percent?.toDouble(),
            title: '${statistic.group?.completed?.percent?.floor()}%',
            radius: radius,
            titleStyle: Style.interSemi(color: Style.white, size: fontSize),
          );
        case 2:
          return PieChartSectionData(
            color: Style.red,
            value: statistic.group?.ended?.percent?.toDouble(),
            title: '${statistic.group?.ended?.percent?.floor()}%',
            radius: radius,
            titleStyle: Style.interSemi(color: Style.white, size: fontSize),
          );
        default:
          throw Error();
      }
    });
  }
}
