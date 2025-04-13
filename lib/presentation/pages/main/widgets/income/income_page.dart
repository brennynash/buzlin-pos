import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:remixicon_updated/remixicon_updated.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:admin_desktop/presentation/styles/style.dart';

import 'package:admin_desktop/application/providers.dart';
import '../../../../../../domain/models/response/income_statistic_response.dart';
import '../../../../assets.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/components/components.dart';
import 'widgets/chart_page.dart';
import 'widgets/pie_chart.dart';
import 'widgets/statistics_page.dart';

class InComePage extends ConsumerStatefulWidget {
  const InComePage({super.key});

  @override
  ConsumerState<InComePage> createState() => _InComePageState();
}

class _InComePageState extends ConsumerState<InComePage> {
  List list = [
    TrKeys.day,
    TrKeys.week,
    TrKeys.month,
  ];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(incomeProvider.notifier)
        ..fetchIncomeCarts()
        ..fetchIncomeCharts()
        ..fetchIncomeStatistic();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(incomeProvider);
    final event = ref.read(incomeProvider.notifier);
    return CustomScaffold(
        body: (colors) => SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppHelpers.getTranslation(TrKeys.income),
                      style: GoogleFonts.inter(
                          fontSize: 22, fontWeight: FontWeight.w600),
                    ),
                    16.verticalSpace,
                    _filter(state, event),
                    16.verticalSpace,
                    _carts(state),
                    16.verticalSpace,
                    ChartPage(
                      isDay: state.selectType == TrKeys.day,
                      price: state.prices,
                      chart: state.incomeCharts ?? [],
                      times: state.time,
                    ),
                    16.verticalSpace,
                    Row(
                      children: [
                        PieChartPage(
                          statistic: state.incomeStatistic ??
                              IncomeStatisticResponse(),
                        ),
                        16.horizontalSpace,
                        StatisticPage(statistic: state.incomeStatistic)
                      ],
                    )
                  ],
                ),
              ),
            ));
  }

  Widget _carts(IncomeState state) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Style.white),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppHelpers.getTranslation(TrKeys.revenue),
                        style: GoogleFonts.inter(
                            fontSize: 22, fontWeight: FontWeight.w600),
                      ),
                      20.verticalSpace,
                      Row(
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Style.revenueColor,
                            ),
                            padding: const EdgeInsets.all(10),
                            child: SvgPicture.asset(Assets.svgRevenue),
                          ),
                          24.horizontalSpace,
                          Text(
                            AppHelpers.numberFormat(
                              number: state.incomeCart?.revenue,
                            ),
                            style: GoogleFonts.inter(
                                fontSize: 22, fontWeight: FontWeight.w600),
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    state.incomeCart?.revenueType == TrKeys.plus
                        ? const Icon(
                            Remix.arrow_up_line,
                            color: Style.primary,
                            size: 18,
                          )
                        : const Icon(
                            Remix.arrow_down_line,
                            color: Style.red,
                            size: 18,
                          ),
                    4.horizontalSpace,
                    Text(
                      "${state.incomeCart?.revenuePercent?.ceil() ?? 0}%",
                      style: GoogleFonts.inter(
                          fontSize: 16,
                          color: state.incomeCart?.revenueType == TrKeys.plus
                              ? Style.primary
                              : Style.red),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        12.horizontalSpace,
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Style.white),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppHelpers.getTranslation(TrKeys.orders),
                      style: GoogleFonts.inter(
                          fontSize: 22, fontWeight: FontWeight.w600),
                    ),
                    Row(
                      children: [
                        state.incomeCart?.ordersType == TrKeys.plus
                            ? const Icon(
                                Remix.arrow_up_line,
                                color: Style.primary,
                                size: 18,
                              )
                            : const Icon(
                                Remix.arrow_down_line,
                                color: Style.red,
                                size: 18,
                              ),
                        4.horizontalSpace,
                        Text(
                          "${state.incomeCart?.ordersPercent?.ceil() ?? 0}%",
                          style: GoogleFonts.inter(
                              fontSize: 16,
                              color: state.incomeCart?.ordersType == TrKeys.plus
                                  ? Style.primary
                                  : Style.red),
                        ),
                      ],
                    )
                  ],
                ),
                16.verticalSpace,
                Row(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Style.primary,
                      ),
                      padding: const EdgeInsets.all(10),
                      child: const Icon(
                        Remix.shopping_cart_fill,
                        color: Style.white,
                      ),
                    ),
                    24.horizontalSpace,
                    Expanded(
                      child: AutoSizeText(
                        AppHelpers.numberFormat(
                          number: state.incomeCart?.orders,
                        ),
                        style: Style.interMedium(size: 24),
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        12.horizontalSpace,
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Style.white),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppHelpers.getTranslation(TrKeys.average),
                      style: GoogleFonts.inter(
                          fontSize: 22, fontWeight: FontWeight.w600),
                    ),
                    20.verticalSpace,
                    Row(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Style.black,
                          ),
                          padding: const EdgeInsets.all(10),
                          child: SvgPicture.asset(Assets.svgAverage),
                        ),
                        24.horizontalSpace,
                        Text(
                          AppHelpers.numberFormat(
                              number: state.incomeCart?.average),
                          style: GoogleFonts.inter(
                              fontSize: 24, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  children: [
                    state.incomeCart?.averageType == TrKeys.plus
                        ? const Icon(
                            Remix.arrow_up_line,
                            color: Style.primary,
                            size: 18,
                          )
                        : const Icon(
                            Remix.arrow_down_line,
                            color: Style.red,
                            size: 18,
                          ),
                    4.horizontalSpace,
                    Text(
                      "${state.incomeCart?.averagePercent?.ceil() ?? 0}%",
                      style: GoogleFonts.inter(
                          fontSize: 16,
                          color: state.incomeCart?.averageType == TrKeys.plus
                              ? Style.primary
                              : Style.red),
                    ),
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _filter(IncomeState state, IncomeNotifier event) {
    return Row(
      children: [
        SvgPicture.asset(Assets.svgMenu),
        8.horizontalSpace,
        ...list.map(
          (e) => Padding(
            padding: const EdgeInsets.only(left: 8),
            child: ConfirmButton(
              paddingSize: 18,
              textSize: 14,
              isActive: state.selectType == e,
              title: AppHelpers.getTranslation(e),
              isTab: true,
              isShadow: true,
              onTap: () => event.changeIndex(e),
            ),
          ),
        ),
        const Spacer(),
        InkWell(
          onTap: () {
            event
              ..fetchIncomeCarts()
              ..fetchIncomeCharts()
              ..fetchIncomeStatistic();
          },
          child: ButtonEffectAnimation(
            child: Container(
                decoration: BoxDecoration(
                    color: Style.white,
                    borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.all(10),
                child: const Icon(Remix.restart_line)),
          ),
        ),
        8.horizontalSpace,
        InkWell(
          onTap: () {
            AppHelpers.showAlertDialog(
              context: context,
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width / 3,
                child: const FilterScreen(),
              ),
            );
          },
          child: ButtonEffectAnimation(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              decoration: BoxDecoration(
                color: Style.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  const Icon(Remix.calendar_check_line),
                  16.horizontalSpace,
                  Text(
                    state.start == null
                        ? AppHelpers.getTranslation(TrKeys.startEnd)
                        : TimeService.dateFormatFilter(
                            start: state.start, end: state.end),
                    style: GoogleFonts.inter(fontSize: 14),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
