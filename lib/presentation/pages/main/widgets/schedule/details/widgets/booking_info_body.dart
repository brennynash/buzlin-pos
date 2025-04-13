import 'package:admin_desktop/application/bookings/details/booking_details_state.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:remixicon_updated/remixicon_updated.dart';
import 'package:admin_desktop/application/bookings/details/booking_details_provider.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/components/components.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import '../../create/widgets/select_master_bottom_sheet.dart';
import 'client_widget.dart';
import 'service_widget.dart';

class BookingInfoBody extends ConsumerWidget {
  const BookingInfoBody({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(bookingDetailsProvider);
    final notifier = ref.read(bookingDetailsProvider.notifier);
    return state.isLoading
        ? const Loading()
        : SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: REdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        ClientWidget(
                          title: TrKeys.client,
                          user: state.bookingData?.user,
                        ),
                        8.verticalSpace,
                        ClientWidget(
                          title: TrKeys.master,
                          onTap: state.bookingData?.status == 'ended' ||
                                  state.bookingData?.status == 'cancelled'
                              ? null
                              : () {
                                  AppHelpers.showAlertDialog(
                                    context: context,
                                    child: SizedBox(
                                        child: SelectMasterBottomSheet(
                                      // controller: c,
                                      title: state.bookingData?.serviceMaster
                                              ?.service?.translation?.title ??
                                          "",
                                      serviceId: state.bookingData
                                          ?.serviceMaster?.service?.id,
                                      masterId: state.bookingData?.master?.id,
                                      onSelect: (master) {
                                        notifier.updateBooking(
                                          context,
                                          selectedMaster: master,
                                        );
                                      },
                                    )),
                                  );
                                },
                          user: state.bookingData?.master,
                        ),
                        8.verticalSpace,
                        ServiceWidget(
                          title: TrKeys.service,
                          bookingData: state.bookingData,
                        ),
                        100.verticalSpace,
                      ],
                    ),
                  ),
                  16.horizontalSpace,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _priceInfo(state),
                        100.verticalSpace,
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  _priceInfo(BookingDetailsState state) {
    return Column(children: [
      _priceItem(
        title: TrKeys.subtotal,
        price: state.bookingData?.price,
      ),
      _priceItem(
        title: TrKeys.serviceFee,
        price: state.bookingData?.serviceFee,
      ),
      // _priceItem(
      //   title: TrKeys.commissionFee,
      //   price: state.bookingData?.commissionFee,
      // ),
      _priceItem(
        title: TrKeys.giftCarts,
        price: state.bookingData?.giftCartPrice,
      ),
      _priceItem(
        isDiscount: true,
        title: TrKeys.discount,
        price: state.bookingData?.discount,
      ),
      _priceItem(
        isDiscount: true,
        title: TrKeys.coupon,
        price: state.bookingData?.couponPrice,
      ),
      _priceItem(
        isTotal: true,
        title: TrKeys.total,
        price: state.bookingData?.totalPrice,
      ),
      const Divider(color: Style.colorGrey),
      if (state.bookingData?.note != null)
        Container(
          decoration: BoxDecoration(
            color: Style.white,
            borderRadius: BorderRadius.circular(10.r),
          ),
          margin: REdgeInsets.only(top: 8),
          padding: REdgeInsets.symmetric(vertical: 14, horizontal: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Remix.chat_1_fill,
                size: 24.r,
                color: Style.black,
              ),
              12.horizontalSpace,
              Expanded(
                child: Text(
                  state.bookingData?.note ?? '',
                  style: Style.interRegular(
                    size: 13,
                    color: Style.black,
                  ),
                ),
              ),
            ],
          ),
        ),
    ]);
  }

  _priceItem({
    required String title,
    required num? price,
    bool isTotal = false,
    bool isDiscount = false,
  }) {
    return (price ?? 0) == 0
        ? const SizedBox.shrink()
        : Column(
            children: [
              4.verticalSpace,
              Divider(color: Style.black.withOpacity(0.4)),
              4.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppHelpers.getTranslation(title),
                    style: isTotal
                        ? Style.interSemi(size: 16.sp, letterSpacing: -0.3)
                        : Style.interNormal(
                            size: 15.sp,
                            letterSpacing: -0.3,
                            color: isDiscount ? Style.redColor : Style.black,
                          ),
                  ),
                  Text(
                    (isDiscount ? '-' : '') +
                        AppHelpers.numberFormat(number: price),
                    style: isTotal
                        ? Style.interSemi(size: 16.sp, letterSpacing: -0.3)
                        : Style.interNormal(
                            size: 14.sp,
                            letterSpacing: -0.3,
                            color: isDiscount ? Style.redColor : Style.black,
                          ),
                  )
                ],
              ),
            ],
          );
  }
}
