import 'package:auto_route/auto_route.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:remixicon_updated/remixicon_updated.dart';
import 'package:admin_desktop/application/bookings/booking_provider.dart';
import 'package:admin_desktop/application/bookings/create/create_booking_provider.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/components/components.dart';
import '../../../../../styles/style.dart';
import '../widgets/calendar_controller_provider.dart';

class BookingPaymentBottomSheet extends ConsumerStatefulWidget {
  final DateTime? startTime;

  const BookingPaymentBottomSheet({super.key, required this.startTime});

  @override
  ConsumerState<BookingPaymentBottomSheet> createState() =>
      _BookingPaymentBottomSheetState();
}

class _BookingPaymentBottomSheetState
    extends ConsumerState<BookingPaymentBottomSheet> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(createBookingProvider.notifier).fetchPayments();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(createBookingProvider);
    final notifier = ref.read(createBookingProvider.notifier);
    return KeyboardDismisser(
      child: Container(
        width: MediaQuery.sizeOf(context).width / 3,
        height: MediaQuery.sizeOf(context).height / 3,
        decoration: BoxDecoration(
          color: Style.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(24.r),
            topLeft: Radius.circular(24.r),
          ),
        ),
        padding: EdgeInsets.only(
          left: 16.r,
          right: 16.r,
        ),
        child: ListView(
          shrinkWrap: true,
          children: [
            8.verticalSpace,
            Container(
              height: 4.r,
              margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.sizeOf(context).width / 2 - 48.r),
              decoration: BoxDecoration(
                  color: Style.icon,
                  borderRadius: BorderRadius.circular(100.r)),
            ),
            16.verticalSpace,
            Text(
              AppHelpers.getTranslation(TrKeys.payment),
              style: Style.interSemi(size: 22),
            ),
            16.verticalSpace,
            state.isPaymentLoading
                ? const Loading()
                : ListView.builder(
                    reverse: true,
                    padding: EdgeInsets.zero,
                    itemCount: state.payments?.length ?? 0,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          notifier.selectPayment(
                            state.payments?[index].id ?? -1,
                          );
                        },
                        child: Column(
                          children: [
                            8.verticalSpace,
                            Row(
                              children: [
                                Icon(
                                  state.payments?[index].id ==
                                          state.selectPayment
                                      ? Remix.checkbox_circle_fill
                                      : Remix.checkbox_blank_circle_line,
                                  color: state.payments?[index].id ==
                                          state.selectPayment
                                      ? Style.primary
                                      : Style.black,
                                ),
                                10.horizontalSpace,
                                Text(
                                  AppHelpers.getTranslation(
                                      state.payments?[index].tag ?? ""),
                                  style: Style.interNormal(size: 14),
                                )
                              ],
                            ),
                            const Divider(),
                            8.verticalSpace
                          ],
                        ),
                      );
                    }),
            16.verticalSpace,
            CustomButton(
                isLoading: state.isLoading,
                title: TrKeys.confirm,
                onTap: () {
                  if (state.selectPayment != -1) {
                    notifier.createBooking(context, date: widget.startTime,
                        created: (bookingData) {
                      CalendarControllerProvider.of(context)
                          ?.controller
                          .addAll(bookingData);
                      ref.read(bookingProvider.notifier)
                        ..fetchBookings(context: context, isRefresh: true)
                        ..changeStateIndex(0);
                       context.maybePop();
                    });
                  }
                }),
            16.verticalSpace,
          ],
        ),
      ),
    );
  }
}
