import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../../../../../../../application/bookings/details/booking_details_provider.dart';
import '../../../comments/widgets/no_item.dart';
import 'activity_item.dart';

class BookingActivityBody extends ConsumerWidget {
  const BookingActivityBody({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(bookingDetailsProvider);
    return (state.bookingData?.activities?.isEmpty ?? true)
        ? const NoItem(title: TrKeys.noActivities)
        : ListView.builder(
            padding: REdgeInsets.all(16),
            itemCount: state.bookingData?.activities?.length ?? 0,
            itemBuilder: (context, index) {
              return ActivityItem(
                  activity: state.bookingData?.activities?[index]);
            });
  }
}
