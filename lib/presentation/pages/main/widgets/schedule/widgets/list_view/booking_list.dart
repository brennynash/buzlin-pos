import 'package:admin_desktop/presentation/components/buttons/view_more_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../../application/bookings/booking_provider.dart';
import '../../../../../../components/loading.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import 'booking_item.dart';

class BookingList extends StatefulWidget {
  const BookingList({super.key});

  @override
  State<BookingList> createState() => _BookingListState();
}

class _BookingListState extends State<BookingList> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final notifier = ref.read(bookingProvider.notifier);
      final state = ref.watch(bookingProvider);
      return Column(
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(color: Style.bg),
              child: state.isLoading
                  ? const Loading()
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: state.bookings.length,
                              shrinkWrap: true,
                              padding: REdgeInsets.symmetric(
                                  vertical: 16, horizontal: 16),
                              itemBuilder: (context, index) {
                                return BookingItem(
                                    booking: state.bookings[index]);
                              }),
                          if (state.hasMore)
                            ViewMoreButton(
                              onTap: () {
                                notifier.fetchBookings(
                                  context: context,
                                );
                              },
                            ),
                        ],
                      ),
                    ),
            ),
          ),
          40.verticalSpace,
        ],
      );
    });
  }
}
