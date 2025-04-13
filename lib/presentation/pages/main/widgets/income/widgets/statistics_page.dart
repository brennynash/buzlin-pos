import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../../../../../domain/models/response/income_statistic_response.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';

class StatisticPage extends StatelessWidget {
  final IncomeStatisticResponse? statistic;

  const StatisticPage({super.key, required this.statistic});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 360,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Style.white),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            AppHelpers.getTranslation(TrKeys.statistics),
            style: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.w600),
          ),
          24.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: 14,
                    width: 1,
                    decoration: const BoxDecoration(
                      color: Style.blue,
                      shape: BoxShape.circle,
                    ),
                  ),
                  6.horizontalSpace,
                  Text(
                    AppHelpers.getTranslation(TrKeys.accepted),
                    style: GoogleFonts.inter(fontSize: 14),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    height: 14,
                    width: 14,
                    decoration: const BoxDecoration(
                      color: Style.revenueColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  6.horizontalSpace,
                  Text(
                    AppHelpers.getTranslation(TrKeys.ready),
                    style: GoogleFonts.inter(fontSize: 14),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    height: 14,
                    width: 14,
                    decoration: const BoxDecoration(
                      color: Style.black,
                      shape: BoxShape.circle,
                    ),
                  ),
                  6.horizontalSpace,
                  Text(
                    AppHelpers.getTranslation(TrKeys.onAWay),
                    style: GoogleFonts.inter(fontSize: 14),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    height: 14,
                    width: 14,
                    decoration: const BoxDecoration(
                      color: Style.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                  6.horizontalSpace,
                  Text(
                    AppHelpers.getTranslation(TrKeys.delivered),
                    style: GoogleFonts.inter(fontSize: 14),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    height: 14,
                    width: 14,
                    decoration: const BoxDecoration(
                      color: Style.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                  6.horizontalSpace,
                  Text(
                    AppHelpers.getTranslation(TrKeys.cancel),
                    style: GoogleFonts.inter(fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Style.blue.withOpacity(0.2)),
                child: CircularPercentIndicator(
                  radius: 50,
                  lineWidth: 8,
                  percent: (statistic?.accepted?.percent?.floor() ?? 0) / 100,
                  center: Text("${statistic?.accepted?.percent?.floor()}%",
                      style: GoogleFonts.inter(color: Style.black)),
                  progressColor: Style.blue,
                  backgroundColor: Style.transparent,
                  circularStrokeCap: CircularStrokeCap.round,
                  rotateLinearGradient: true,
                ),
              ),
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Style.revenueColor.withOpacity(0.2)),
                child: CircularPercentIndicator(
                  radius: 50,
                  lineWidth: 8,
                  percent: (statistic?.ready?.percent?.floor() ?? 0) / 100,
                  center: Text("${statistic?.ready?.percent?.floor()}%",
                      style: GoogleFonts.inter(color: Style.black)),
                  progressColor: Style.revenueColor,
                  backgroundColor: Style.transparent,
                  circularStrokeCap: CircularStrokeCap.round,
                  rotateLinearGradient: true,
                ),
              ),
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Style.black.withOpacity(0.2)),
                child: CircularPercentIndicator(
                  radius: 50,
                  lineWidth: 8,
                  percent: (statistic?.onAWay?.percent?.floor() ?? 0) / 100,
                  center: Text("${statistic?.onAWay?.percent?.floor()}%",
                      style: GoogleFonts.inter(color: Style.black)),
                  progressColor: Style.black,
                  backgroundColor: Style.transparent,
                  circularStrokeCap: CircularStrokeCap.round,
                  rotateLinearGradient: true,
                ),
              ),
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Style.primary.withOpacity(0.2)),
                child: CircularPercentIndicator(
                  radius: 50,
                  lineWidth: 8,
                  percent: (statistic?.delivered?.percent?.floor() ?? 0) / 100,
                  center: Text("${statistic?.delivered?.percent?.floor()}%",
                      style: GoogleFonts.inter(color: Style.black)),
                  progressColor: Style.primary,
                  backgroundColor: Style.transparent,
                  circularStrokeCap: CircularStrokeCap.round,
                  rotateLinearGradient: true,
                ),
              ),
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Style.red.withOpacity(0.2)),
                child: CircularPercentIndicator(
                  radius: 50,
                  lineWidth: 8,
                  percent: (statistic?.canceled?.percent?.floor() ?? 0) / 100,
                  center: Text("${statistic?.canceled?.percent?.floor()}%",
                      style: GoogleFonts.inter(color: Style.black)),
                  progressColor: Style.red,
                  backgroundColor: Style.transparent,
                  circularStrokeCap: CircularStrokeCap.round,
                  rotateLinearGradient: true,
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            AppHelpers.getTranslation(TrKeys.everyLarge),
            style: GoogleFonts.inter(fontSize: 14, color: Style.iconColor),
          ),
          12.verticalSpace,
        ]),
      ),
    );
  }
}
