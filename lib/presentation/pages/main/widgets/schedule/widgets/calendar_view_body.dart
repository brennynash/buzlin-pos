import 'package:admin_desktop/application/masters/accepted_masters/accepted_masters_provider.dart';
import 'package:admin_desktop/presentation/theme/theme/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:remixicon_updated/remixicon_updated.dart';
import 'package:admin_desktop/application/bookings/booking_provider.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/components/components.dart';
import '../../../../../styles/style.dart';
import 'components/calendar_type_modal.dart';
import 'components/zoom_modal.dart';
import 'list_view/booking_list.dart';
import 'three_day_view/three_day_view.dart';
import 'package:flutter/material.dart';
import 'week_view/week_view.dart';
import 'day_view/day_view.dart';

class CalendarViewBody extends ConsumerWidget {
  final double? width;
  final CustomColorSet colors;

  const CalendarViewBody({
    super.key,
    this.width,
    required this.colors,
  });

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(bookingProvider);
    final notifier = ref.read(bookingProvider.notifier);
    return Padding(
      padding: REdgeInsets.only(bottom: 80, top: 6),
      child: Column(
        children: [
          Row(
            children: [
              8.horizontalSpace,
              SizedBox(
                width: MediaQuery.sizeOf(context).width / 5,
                child: Text(
                  AppHelpers.getTranslation(TrKeys.schedule),
                  style: Style.interMedium(),
                ),
              ),
              SizedBox(
                width: 200.w,
                child: CustomDropdown(
                  onChanged: (s) {
                    ref
                        .read(acceptedMastersProvider.notifier)
                        .setMastersQuery(context, s);
                  },
                  dropDownType: DropDownType.masters,
                ),
              ),
              const Spacer(),
              LoginButton(
                bgColor: Style.black,
                icon: Icon(
                  Remix.add_circle_line,
                  color: Style.white,
                  size: 24.r,
                ),
                title: TrKeys.addEvent,
                onPressed: () => notifier.changeStateIndex(1),
              ),
              24.horizontalSpace,
              LoginButton(
                onPressed: () {
                  AppHelpers.showCustomDialog(
                    context: context,
                    title: TrKeys.calendarView,
                    child: const CalendarTypeModal(),
                  );
                },
                title: AppHelpers.getTranslation(TrKeys.calendarView),
              ),
              IconButton(
                onPressed: () {
                  AppHelpers.showCustomDialog(
                    context: context,
                    title: TrKeys.changeZoom,
                    child: const ZoomModal(),
                  );
                },
                icon: const Icon(
                  Icons.zoom_out_map,
                  color: Style.primary,
                ),
              ),
            ],
          ),
          Expanded(
            child: state.calendarType == 0
                ? DayView(
                    startDuration: Duration(hours: DateTime.now().hour - 1),
                    showHalfHours: true,
                    heightPerMinute: state.calendarZoom,
                    onDateTap: (s) {},
                    onDateLongPress: (s) {},
                    onPageChange: (s, i) {
                      notifier.changeDate(context, startDate: s);
                    },
                    minuteSlotSize: MinuteSlotSize.minutes5,
                    timeLineWidth: 48.w,
                    isLoading: state.isLoading,
                  )
                : state.calendarType == 1
                    ? ThreeDayView(
                        startDuration: Duration(hours: DateTime.now().hour - 1),
                        showHalfHours: true,
                        heightPerMinute: state.calendarZoom,
                        onDateTap: (s) {},
                        onDateLongPress: (s) {},
                        onPageChange: (s, i) {
                          notifier.changeDate(context, startDate: s);
                        },
                        minuteSlotSize: MinuteSlotSize.minutes5,
                        timeLineWidth: 48.w,
                        isLoading: state.isLoading,
                      )
                    : state.calendarType == 2
                        ? WeekView(
                            startDuration:
                                Duration(hours: DateTime.now().hour - 1),
                            showHalfHours: true,
                            heightPerMinute: state.calendarZoom,
                            onDateTap: (s) {},
                            onDateLongPress: (s) {},
                            onPageChange: (s, i) {
                              notifier.changeDate(context, startDate: s);
                            },
                            minuteSlotSize: MinuteSlotSize.minutes5,
                            timeLineWidth: 48.w,
                            isLoading: state.isLoading,
                          )
                        : const BookingList(),
          )
        ],
      ),
    );
  }
}
