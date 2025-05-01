import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import '../../../application/providers.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import '../pages/main/widgets/income/widgets/custom_date_picker.dart';
import 'components.dart';

class FilterScreen extends StatefulWidget {
  final DateTime? start;
  final DateTime? end;
  final bool isOrder;

  const FilterScreen({
    super.key,
    this.start,
    this.end,
    this.isOrder = false,
  });

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  List<DateTime?> _rangeDatePicker = [];
  List<DateTime?> _newList = [];

  @override
  void initState() {
    _rangeDatePicker = [
      widget.start ?? DateTime.now(),
      widget.end ?? DateTime.now(),
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text(
            AppHelpers.getTranslation(TrKeys.selectDesiredOrderHistory),
            style: GoogleFonts.inter(
                fontSize: 14.sp, color: Style.black, letterSpacing: -0.3),
          ),
        ),
        CustomDatePicker(
          range: _rangeDatePicker,
          onValueChanged: (n) {
            _newList = n;
          },
        ),
        16.verticalSpace,
        SizedBox(
          width: 200.w,
          child: Padding(
            padding: EdgeInsets.only(left: 16.r),
            child: Consumer(builder: (context, ref, child) {
              return LoginButton(
                title: AppHelpers.getTranslation(TrKeys.save),
                onPressed: () {
                  if (widget.isOrder) {
                    ref
                        .read(orderTableProvider.notifier)
                        .setTime(_newList.first, _newList.last);
                    ref.read(newOrdersProvider.notifier).fetchNewOrders(
                        start: _newList.first,
                        end: _newList.last,
                        isRefresh: true);
                    ref
                        .read(acceptedOrdersProvider.notifier)
                        .fetchAcceptedOrders(
                            start: _newList.first,
                            end: _newList.last,
                            isRefresh: true);
                    ref.read(onAWayOrdersProvider.notifier).fetchOnAWayOrders(
                        start: _newList.first,
                        end: _newList.last,
                        isRefresh: true);
                    ref.read(readyOrdersProvider.notifier).fetchReadyOrders(
                        start: _newList.first,
                        end: _newList.last,
                        isRefresh: true);
                    ref
                        .read(deliveredOrdersProvider.notifier)
                        .fetchDeliveredOrders(
                            start: _newList.first,
                            end: _newList.last,
                            isRefresh: true);
                    ref
                        .read(canceledOrdersProvider.notifier)
                        .fetchCanceledOrders(
                            start: _newList.first,
                            end: _newList.last,
                            isRefresh: true);
                  } else {
                    ref.read(incomeProvider.notifier)
                      ..fetchIncomeCarts(
                          start: _newList.first, end: _newList.last)
                      ..fetchIncomeCharts(
                          start: _newList.first, end: _newList.last)
                      ..fetchIncomeStatistic(
                          start: _newList.first, end: _newList.last);
                  }

                  context.maybePop();
                },
              );
            }),
          ),
        ),
        8.verticalSpace,
      ],
    );
  }
}
