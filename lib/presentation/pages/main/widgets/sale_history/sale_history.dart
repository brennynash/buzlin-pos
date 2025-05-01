import 'package:admin_desktop/presentation/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:admin_desktop/application/providers.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/components/components.dart';
import '../../../../styles/style.dart';
import 'sale_tab.dart';

class SaleHistory extends ConsumerStatefulWidget {
  const SaleHistory({super.key});

  @override
  ConsumerState<SaleHistory> createState() => _SaleHistoryState();
}

class _SaleHistoryState extends ConsumerState<SaleHistory> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(saleHistoryProvider.notifier)
        ..fetchSale()
        ..fetchSaleCarts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(saleHistoryProvider);
    final event = ref.read(saleHistoryProvider.notifier);
    return CustomScaffold(
        body: (colors) => ListView(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              shrinkWrap: true,
              children: [
                GestureDetector(
                  onTap: () {
                    ref.read(saleHistoryProvider.notifier)
                      ..fetchSale()
                      ..fetchSaleCarts();
                  },
                  child: Text(
                    AppHelpers.getTranslation(TrKeys.saleHistory),
                    style: Style.interMedium(size: 20),
                  ),
                ),
                16.verticalSpace,
                _topWidgets(state, event),
                16.verticalSpace,
                if (state.selectIndex == 2) _saleCarts(state),
                16.verticalSpace,
                SaleTab(
                  isMoreLoading: state.isMoreLoading,
                  isLoading: state.isLoading,
                  list: state.selectIndex == 0
                      ? state.listDriver
                      : state.selectIndex == 1
                          ? state.listToday
                          : state.listHistory,
                  hasMore: state.hasMore,
                  viewMore: () {
                    event.fetchSalePage();
                  },
                )
              ],
            ));
  }

  Widget _saleCarts(SaleHistoryState state) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 30),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Style.white),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppHelpers.getTranslation(TrKeys.openingDrawerAmount),
                        style: Style.interRegular(size: 16),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      20.verticalSpace,
                      Text(
                        AppHelpers.numberFormat(
                            number: state.saleCart?.deliveryFee),
                        style: Style.interMedium(size: 24),
                      ),
                    ],
                  ),
                ),
                Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Style.primary.withOpacity(0.01),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 32,
                            spreadRadius: 12,
                            color: Style.primary.withOpacity(0.5),
                          )
                        ]),
                    child: SvgPicture.asset(Assets.svgCart))
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
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppHelpers.getTranslation(TrKeys.cashPaymentSale),
                      style: Style.interRegular(size: 16),
                    ),
                    20.verticalSpace,
                    Text(
                      AppHelpers.numberFormat(number: state.saleCart?.cash),
                      style: Style.interMedium(size: 24),
                    ),
                  ],
                ),
                const Spacer(),
                Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Style.starColor.withOpacity(0.01),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 32,
                            spreadRadius: 12,
                            color: Style.starColor.withOpacity(0.5),
                          )
                        ]),
                    child: SvgPicture.asset(Assets.svgDollar))
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
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppHelpers.getTranslation(TrKeys.otherPaymentSale),
                      style: Style.interRegular(size: 16),
                    ),
                    20.verticalSpace,
                    Text(
                      AppHelpers.numberFormat(number: state.saleCart?.other),
                      style: Style.interMedium(size: 24),
                    ),
                  ],
                ),
                const Spacer(),
                Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Style.blue.withOpacity(0.01),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 32,
                            spreadRadius: 12,
                            color: Style.blue.withOpacity(0.5),
                          )
                        ]),
                    child: SvgPicture.asset(Assets.svgCart2))
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _topWidgets(SaleHistoryState state, SaleHistoryNotifier notifier) {
    List statusList = [TrKeys.cashDrawer, TrKeys.todaySale, TrKeys.saleHistory];
    return Row(
      children: [
        SvgPicture.asset(Assets.svgMenu),
        for (int i = 0; i < statusList.length; i++)
          Padding(
            padding: REdgeInsets.only(left: 8),
            child: ConfirmButton(
              paddingSize: 18,
              textSize: 14,
              isActive: state.selectIndex == i,
              title: AppHelpers.getTranslation(statusList[i]),
              isTab: true,
              isShadow: true,
              onTap: () => notifier.changeIndex(i),
            ),
          )
      ],
    );
  }
}
