import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/application/bookings/booking_provider.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/components/components.dart';
import 'package:admin_desktop/presentation/styles/style.dart';

class CalendarTypeModal extends ConsumerWidget {
  const CalendarTypeModal({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(bookingProvider);
    final notifier = ref.read(bookingProvider.notifier);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
            height: 84,
            child: ListView.builder(
                itemCount: 4,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: REdgeInsets.only(right: 16),
                    child: GestureDetector(
                      onTap: () {
                        notifier.changeCalendarType(
                          index: index,
                          context: context,
                        );
                      },
                      child: Column(
                        children: [
                          AbsorbPointer(
                            child: CircleButton(
                              size: 48,
                              borderColor: state.calendarType == index
                                  ? Style.primary
                                  : Style.colorGrey,
                              backgroundColor: state.calendarType == index
                                  ? Style.primary
                                  : Style.greyColor,
                              iconColor: state.calendarType == index
                                  ? Style.white
                                  : Style.black,
                              icon: index == 0
                                  ? Icons.view_day_outlined
                                  : index == 1
                                      ? Icons.width_normal_outlined
                                      : index == 2
                                          ? Icons.calendar_view_week
                                          : Icons.list,
                              onTap: () {},
                            ),
                          ),
                          8.verticalSpace,
                          Text(
                            AppHelpers.getTranslation(
                              index == 0
                                  ? TrKeys.day
                                  : index == 1
                                      ? TrKeys.threeDays
                                      : index == 2
                                          ? TrKeys.week
                                          : TrKeys.list,
                            ),
                            style: Style.interNormal(size: 15),
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),
                  );
                })),
        12.verticalSpace,
        Text(
          AppHelpers.getTranslation(TrKeys.status),
          style: Style.interSemi(),
        ),
        6.verticalSpace,
        Wrap(
          spacing: 8,
          runSpacing: 6,
          children: [
            ...BookingStatus.values.map((e) => _statusItem(
                status: AppHelpers.getBookingStatus(e),
                onTap: () {
                  notifier.changeStatus(
                    status: AppHelpers.getBookingStatus(e),
                    context: context,
                  );
                },
                active: state.status == AppHelpers.getBookingStatus(e))),
          ],
        ),
      ],
    );
  }
}

_statusItem({
  required String status,
  required bool active,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: REdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color:
            AppHelpers.getStatusColor(status).withOpacity(active ? 0.5 : 0.3),
        border: Border.all(
          width: 2,
          color: active ? AppHelpers.getStatusColor(status) : Style.transparent,
        ),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            AppHelpers.getTranslation(status),
            style: Style.interNormal(
              size: 16,
              color: active ? Style.white : Style.black,
            ),
          ),
        ],
      ),
    ),
  );
}
