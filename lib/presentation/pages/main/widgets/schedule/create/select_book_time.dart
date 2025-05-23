import 'package:admin_desktop/application/bookings/booking_provider.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:admin_desktop/application/bookings/create/create_booking_provider.dart';
import 'package:admin_desktop/application/bookings/create/create_booking_state.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/components/components.dart';
import 'package:admin_desktop/presentation/styles/style.dart';

class SelectBookTimePage extends ConsumerStatefulWidget {
  const SelectBookTimePage({super.key});

  @override
  ConsumerState<SelectBookTimePage> createState() => _SelectBookTimePageState();
}

class _SelectBookTimePageState extends ConsumerState<SelectBookTimePage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(createBookingProvider.notifier).checkTime(context: context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(createBookingProvider);
    // List times = state.listDate
    //         ?.firstWhere(
    //             (element) =>
    //                 (element.date?.day == state.selectDateTime?.day) &&
    //                 (element.date?.month == state.selectDateTime?.month),
    //             orElse: () => EnableDate(day: "M"))
    //         .times ??
    //     [];
    List times = [];
    return KeyboardDismisser(
      child: Scaffold(
        backgroundColor: Style.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: REdgeInsets.all(16.0),
              child: Text(
                AppHelpers.getTranslation(TrKeys.selectDateTime),
                style: Style.interMedium(size: 18),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  _days(context, state),
                  16.verticalSpace,
                  times.isEmpty
                      ? Padding(
                          padding: EdgeInsets.only(top: 24.r),
                          child: Text(
                            AppHelpers.getTranslation(TrKeys.noAvailable),
                            style: Style.interNormal(),
                          ),
                        )
                      : _enableTimes(times, context, state),
                ],
              ),
            )
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.r),
            child: Row(
              children: [
                PopButton(
                  popSuccess: () {
                    ref.read(bookingProvider.notifier).changeStateIndex(1);
                  },
                ),
                10.horizontalSpace,
                state.selectBookTime != null
                    ? Expanded(
                        child: CustomButton(
                            title: AppHelpers.getTranslation(TrKeys.next),
                            onTap: () {
                              int hour = int.parse(state.selectBookTime
                                      ?.substring(0,
                                          state.selectBookTime?.indexOf(":")) ??
                                  "0");
                              int minute = int.parse(state.selectBookTime
                                      ?.substring(
                                          (state.selectBookTime?.indexOf(":") ??
                                                  0) +
                                              1) ??
                                  "0");
                              ref
                                  .read(createBookingProvider.notifier)
                                  .selectDateTime(
                                    selectTime: DateTime(
                                      state.selectDateTime?.year ?? 0,
                                      state.selectDateTime?.month ?? 0,
                                      state.selectDateTime?.day ?? 0,
                                      hour,
                                      minute,
                                    ),
                                  );
                              ref
                                  .read(bookingProvider.notifier)
                                  .changeStateIndex(4);
                            }),
                      )
                    : const SizedBox.shrink()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding _days(BuildContext context, CreateBookingState state) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.r),
      child: EasyDateTimeLine(
        locale: LocalStorage.getLanguage()?.locale ?? "en_US",
        initialDate: DateTime.now(),
        onDateChange: (selectedDate) {
          ref.read(createBookingProvider.notifier).selectDateTime(
                selectTime: selectedDate,
              );
        },
        disabledDates: [
          ...List.generate(30,
              (index) => DateTime.now().subtract(Duration(days: index + 1))),
          // ...(state.listDate?.map((e) {
          //       if (e.closed ?? false) {
          //         return e.date ??
          //             DateTime.now().subtract(const Duration(days: 1));
          //       }
          //       return DateTime.now().subtract(const Duration(days: 1));
          //     }).toList() ??
          //     [])
        ],
        headerProps: const EasyHeaderProps(
            monthPickerType: MonthPickerType.switcher,
            dateFormatter: DateFormatter.fullDateDMY()),
        dayProps: EasyDayProps(
          dayStructure: DayStructure.dayStrDayNum,
          todayHighlightColor: Style.black,
          activeDayStyle: DayStyle(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: Style.primary,
            ),
          ),
        ),
      ),
    );
  }

  Expanded _enableTimes(
      List<dynamic> times, BuildContext context, CreateBookingState state) {
    times.removeWhere((element) {
      if ((int.tryParse(element.toString().split(':')[0]) ?? 0) <=
              DateTime.now().hour &&
          (DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
          ).isAtSameMomentAs(DateTime(
            state.selectDateTime?.year ?? 1,
            state.selectDateTime?.month ?? 1,
            state.selectDateTime?.day ?? 1,
          )))) {
        return true;
      }
      return false;
    });
    return Expanded(
      child: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 100.r),
        child: Wrap(
          children: times
              .map((time) => ButtonEffectAnimation(
                    onTap: () {
                      ref
                          .read(createBookingProvider.notifier)
                          .selectBookingTime(time);
                    },
                    child: Container(
                      margin: EdgeInsets.all(8.r),
                      decoration: BoxDecoration(
                          color: state.selectBookTime == time
                              ? Style.primary
                              : Style.transparent,
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(
                              color: state.selectBookTime == time
                                  ? Style.primary
                                  : Style.black)),
                      padding: EdgeInsets.symmetric(
                          vertical: 10.r, horizontal: 20.r),
                      child: Text(
                        time,
                        style: Style.interNormal(
                            color: state.selectBookTime == time
                                ? Style.white
                                : Style.black),
                      ),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
