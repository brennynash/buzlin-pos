import 'package:admin_desktop/app_constants.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../../application/bookings/booking_provider.dart';
import '../../../../../../../application/bookings/details/booking_details_provider.dart';
import 'package:admin_desktop/domain/models/models.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/components/components.dart';
import 'package:admin_desktop/presentation/styles/style.dart';

class BookingItem extends ConsumerWidget {
  final BookingData booking;

  const BookingItem({super.key, required this.booking});

  @override
  Widget build(BuildContext context, ref) {
    return ButtonEffectAnimation(
      child: GestureDetector(
        onTap: () {
          ref.read(bookingDetailsProvider.notifier).setBookingDetail(booking,
              success: () {
            ref.read(bookingProvider.notifier).changeStateIndex(5);
          });
        },
        child: Container(
          height: 110.h,
          width: double.infinity,
          margin: REdgeInsets.only(bottom: 10),
          padding: REdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: Style.white,
            borderRadius: BorderRadius.circular(AppConstants.radius / 1.4.r),
          ),
          child: Row(
            children: [
              Container(
                width: 4,
                decoration: ShapeDecoration(
                  color: AppHelpers.getStatusColor(booking.status),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10.r),
                      bottomRight: Radius.circular(10.r),
                    ),
                  ),
                ),
              ),
              12.horizontalSpace,
              Expanded(
                child: Padding(
                  padding: REdgeInsets.symmetric(vertical: 4),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          CommonImage(
                            url: booking.user?.img,
                            radius: 20,
                            width: 40,
                            height: 40,
                          ),
                          12.horizontalSpace,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    text: '№ ${booking.id ?? ''}',
                                    style: Style.interNormal(
                                      color: Style.black,
                                      size: 14,
                                      letterSpacing: -0.3,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: ' | ',
                                        style: Style.interNormal(
                                          color: Style.borderColor,
                                          size: 14,
                                          letterSpacing: -0.3,
                                        ),
                                      ),
                                      TextSpan(
                                        text: booking.user == null
                                            ? AppHelpers.getTranslation(
                                                TrKeys.deletedUser)
                                            : "${booking.user?.firstname ?? AppHelpers.getTranslation(TrKeys.noName)} ${booking.user?.lastname ?? ''}",
                                        style: Style.interRegular(
                                          size: 14,
                                          color: Style.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                4.verticalSpace,
                                Text(
                                  booking.serviceMaster?.service?.translation
                                          ?.title ??
                                      "",
                                  style: Style.interNormal(
                                    size: 12,
                                    color: Style.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Flexible(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: RichText(
                                      text: TextSpan(
                                        text: '№ ${booking.id ?? ''}',
                                        style: Style.interNormal(
                                          color: Style.black,
                                          size: 14,
                                          letterSpacing: -0.3,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: ' | ',
                                            style: Style.interNormal(
                                              color: Style.borderColor,
                                              size: 14,
                                              letterSpacing: -0.3,
                                            ),
                                          ),
                                          TextSpan(
                                            text: TimeService
                                                .dateFormatForBooking([
                                              booking.startDate,
                                              booking.endDate
                                            ]),
                                            style: Style.interNormal(
                                              color: Style.black,
                                              size: 14,
                                              letterSpacing: -0.3,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  AutoSizeText(
                                    AppHelpers.numberFormat(
                                        number: booking.totalPrice ??
                                            booking.giftCartPrice),
                                    style: Style.interNormal(
                                        size: 14, color: Style.black),
                                    maxLines: 1,
                                    minFontSize: 14,
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              16.horizontalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
