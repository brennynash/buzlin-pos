import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../../application/bookings/booking_provider.dart';
import '../../../../../../../application/bookings/details/booking_details_provider.dart';
import 'package:admin_desktop/domain/models/models.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/styles/style.dart';

class EventWidget extends ConsumerStatefulWidget {
  final BookingData bookingData;
  final CalendarType calendarType;

  const EventWidget({
    super.key,
    required this.bookingData,
    required this.calendarType,
  });

  @override
  ConsumerState<EventWidget> createState() => _EventWidgetState();
}

class _EventWidgetState extends ConsumerState<EventWidget> {
  late double minFontSize;
  late double maxFontSize;

  getFontSize() {
    switch (widget.calendarType) {
      case CalendarType.day:
        minFontSize = 12;
        maxFontSize = 12;
        break;
      case CalendarType.threeDay:
        minFontSize = 10;
        maxFontSize = 10;
        break;
      case CalendarType.week:
        minFontSize = 8;
        maxFontSize = 8;
        break;
    }
  }

  @override
  void initState() {
    getFontSize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ref
            .read(bookingDetailsProvider.notifier)
            .setBookingDetail(widget.bookingData, success: () {
          ref.read(bookingProvider.notifier).changeStateIndex(5);
        });
      },
      child: LayoutBuilder(builder: (context, constraints) {
        final height = constraints.maxHeight;
        return Container(
          padding:
              REdgeInsets.all(widget.calendarType == CalendarType.week ? 4 : 6),
          margin: REdgeInsets.only(right: 1, bottom: 1),
          decoration: BoxDecoration(
            color: AppHelpers.getStatusColor(widget.bookingData.status)
                .withOpacity(0.9),
            borderRadius: BorderRadius.circular(
                widget.calendarType == CalendarType.week ? 8 : 10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              AutoSizeText(
                TimeService.timeFormatMulti(
                    [widget.bookingData.startDate, widget.bookingData.endDate]),
                style:
                    Style.interRegular(color: Style.white, size: maxFontSize),
                minFontSize: minFontSize,
                maxLines: widget.calendarType == CalendarType.week ? 1 : 1,
              ),
              (height / 30).verticalSpace,
              if (widget.bookingData.user?.firstname != null)
                Flexible(
                  child: AutoSizeText(
                    widget.bookingData.user?.firstname ?? '',
                    style: Style.interNormal(
                        color: Style.white, size: maxFontSize),
                    maxLines: 1,
                    minFontSize: minFontSize,
                  ),
                ),
              if (widget.bookingData.serviceMaster?.service?.translation
                          ?.title !=
                      null &&
                  height > 55)
                Flexible(
                  child: AutoSizeText(
                    "${widget.bookingData.serviceMaster?.service?.translation?.title ?? ''} (${widget.bookingData.master?.firstname ?? ''})",
                    style: Style.interNormal(
                      color: Style.white,
                      size: maxFontSize,
                    ),
                    maxLines: widget.calendarType == CalendarType.week ? 1 : 2,
                    minFontSize: minFontSize,
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }
}

class FullDayEventView extends StatelessWidget {
  const FullDayEventView({
    super.key,
    this.boxConstraints = const BoxConstraints(maxHeight: 100),
    required this.events,
    this.padding,
    this.itemView,
    this.onEventTap,
    required this.date,
  });

  final BoxConstraints boxConstraints;

  final List<BookingData> events;

  final EdgeInsets? padding;
  final Widget Function(BookingData? event)? itemView;
  final Function(BookingData event, DateTime date)? onEventTap;
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: boxConstraints,
      child: ListView.builder(
        itemCount: events.length,
        padding: padding ?? EdgeInsets.zero,
        shrinkWrap: true,
        itemBuilder: (context, index) => InkWell(
          onTap: () => onEventTap?.call(events[index], date),
          child: itemView?.call(events[index]) ??
              Container(
                margin: const EdgeInsets.all(5),
                padding: const EdgeInsets.all(1),
                height: 24,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                alignment: Alignment.centerLeft,
                child: Text(
                  events[index].serviceMaster?.translation?.title ?? '',
                  style: Style.interNormal(),
                  maxLines: 1,
                ),
              ),
        ),
      ),
    );
  }
}
