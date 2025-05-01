import 'package:admin_desktop/presentation/components/components.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/application/providers.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import 'create/create_event_page.dart';
import 'widgets/calendar_controller_provider.dart';
import 'widgets/calendar_view_body.dart';
import 'widgets/event_controller.dart';
import 'create/add_note_page.dart';
import 'create/select_book_time.dart';
import 'create/select_masters_page.dart';
import 'details/booking_details_page.dart';

class SchedulePage extends ConsumerStatefulWidget {
  const SchedulePage({super.key});

  @override
  ConsumerState<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends ConsumerState<SchedulePage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(bookingProvider.notifier).fetchBookings(
            context: context,
            isRefresh: true,
            startTime: DateTime.now(),
            endTime: DateTime.now(),
          );
      ref.read(acceptedMastersProvider.notifier).fetchMembers(isRefresh: true);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(bookingProvider);
    return CalendarControllerProvider(
      controller: EventController()..addAll(state.bookings),
      child: CustomScaffold(
        backgroundColor: Style.transparent,
        body: (colors) => ColoredBox(
            color: Style.white,
            child: state.stateIndex == 0
                ?  CalendarViewBody(colors:colors)
                : state.stateIndex == 1
                    ? const CreateEventPage()
                    : state.stateIndex == 2
                        ? const SelectMastersPage()
                        : state.stateIndex == 3
                            ? const SelectBookTimePage()
                            : state.stateIndex == 4
                                ? const AddNotePage()
                                : const BookingDetailsPage()),
        floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
        floatingActionButton: (c) => state.stateIndex == 0
            ? Padding(
                padding: REdgeInsets.only(bottom: 76),
                child: Container(
                  margin: REdgeInsets.symmetric(horizontal: 16),
                  padding: REdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Style.greyColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: IntrinsicHeight(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        10.horizontalSpace,
                        Text(
                          AppHelpers.getTranslation(TrKeys.status),
                          style: Style.interSemi(size: 14.sp),
                        ),
                        10.horizontalSpace,
                        const VerticalDivider(),
                        ...BookingStatus.values.mapIndexed((e, i) =>
                            _statusColorItem(AppHelpers.getBookingStatus(e))),
                      ],
                    ),
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ),
    );
  }

  _statusColorItem(String status) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        20.horizontalSpace,
        Container(
          height: 16.r,
          width: 16.r,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppHelpers.getStatusColor(status),
          ),
        ),
        10.horizontalSpace,
        Text(
          AppHelpers.getTranslation(status),
          style: Style.interNormal(size: 12.sp),
        ),
        10.horizontalSpace,
      ],
    );
  }
}
