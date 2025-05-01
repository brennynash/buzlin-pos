import 'package:admin_desktop/application/right_side/right_side_notifier.dart';
import 'package:admin_desktop/application/right_side/right_side_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import 'package:intl/intl.dart' as intl;
import 'package:admin_desktop/application/providers.dart';
import 'package:admin_desktop/domain/models/models.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/components/components.dart';

class PriceInfo extends StatelessWidget {
  final BagData bag;
  final RightSideState state;
  final RightSideNotifier notifier;
  final MainNotifier mainNotifier;

  const PriceInfo(
      {super.key,
      required this.state,
      required this.notifier,
      required this.bag,
      required this.mainNotifier});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppHelpers.getTranslation(TrKeys.subtotal),
              style: GoogleFonts.inter(
                color: Style.black,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                letterSpacing: -0.4,
              ),
            ),
            Text(
              AppHelpers.numberFormat(
                number: state.paginateResponse?.price,
                symbol: bag.selectedCurrency?.symbol,
                isOrder: bag.selectedCurrency?.symbol != null,
              ),
              style: GoogleFonts.inter(
                color: Style.black,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                letterSpacing: -0.4,
              ),
            ),
          ],
        ),
        12.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppHelpers.getTranslation(TrKeys.tax),
              style: GoogleFonts.inter(
                color: Style.black,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                letterSpacing: -0.4,
              ),
            ),
            Text(
              AppHelpers.numberFormat(
                  symbol: bag.selectedCurrency?.symbol,
                  number: state.paginateResponse?.totalTax),
              style: GoogleFonts.inter(
                color: Style.black,
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                letterSpacing: -0.4,
              ),
            ),
          ],
        ),
        12.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppHelpers.getTranslation(TrKeys.deliveryFee),
              style: GoogleFonts.inter(
                color: Style.black,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                letterSpacing: -0.4,
              ),
            ),
            Text(
              AppHelpers.numberFormat(
                  symbol: bag.selectedCurrency?.symbol,
                  number: state.orderType == TrKeys.delivery
                      ? state.deliveryPrice?.price ?? 0
                      : state.deliveryFee),
              style: GoogleFonts.inter(
                color: Style.black,
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                letterSpacing: -0.4,
              ),
            ),
          ],
        ),
        12.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppHelpers.getTranslation(TrKeys.serviceFee),
              style: GoogleFonts.inter(
                color: Style.black,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                letterSpacing: -0.4,
              ),
            ),
            Text(
              AppHelpers.numberFormat(
                  symbol: bag.selectedCurrency?.symbol,
                  number: state.serviceFee),
              style: GoogleFonts.inter(
                color: Style.black,
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                letterSpacing: -0.4,
              ),
            ),
          ],
        ),
        12.verticalSpace,
        if (state.paginateResponse?.totalDiscount != null &&
            state.paginateResponse?.totalDiscount != 0)
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppHelpers.getTranslation(TrKeys.discount),
                    style: GoogleFonts.inter(
                      color: Style.black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.4,
                    ),
                  ),
                  Text(
                    "-${AppHelpers.numberFormat(symbol: bag.selectedCurrency?.symbol, number: state.paginateResponse?.totalDiscount)}",
                    style: GoogleFonts.inter(
                      color: Style.red,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      letterSpacing: -0.4,
                    ),
                  ),
                ],
              ),
              12.verticalSpace,
            ],
          ),
        if (state.paginateResponse?.couponPrice != null &&
            state.paginateResponse?.couponPrice != 0)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppHelpers.getTranslation(TrKeys.coupon),
                style: GoogleFonts.inter(
                  color: Style.black,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.4,
                ),
              ),
              Text(
                "-${AppHelpers.numberFormat(symbol: bag.selectedCurrency?.symbol, number: state.paginateResponse?.couponPrice)}",
                style: GoogleFonts.inter(
                  color: Style.red,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  letterSpacing: -0.4,
                ),
              ),
            ],
          ),
        const Divider(),
        20.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppHelpers.getTranslation(TrKeys.totalPrice),
              style: GoogleFonts.inter(
                color: Style.black,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                letterSpacing: -0.4,
              ),
            ),
            Text(
              AppHelpers.numberFormat(number: state.totalFee),
              style: GoogleFonts.inter(
                color: Style.black,
                fontSize: 22.sp,
                fontWeight: FontWeight.w600,
                letterSpacing: -0.4,
              ),
            ),
          ],
        ),
        20.verticalSpace,
        state.calculate.isEmpty
            ? const SizedBox.shrink()
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppHelpers.getTranslation(TrKeys.refund),
                    style: GoogleFonts.inter(
                      color: Style.black,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.4,
                    ),
                  ),
                  Text(
                    AppHelpers.numberFormat(
                        symbol: bag.selectedCurrency?.symbol,
                        number: (state.totalFee) -
                            (double.tryParse(state.calculate) ?? 0)),
                    style: GoogleFonts.inter(
                      color: Style.black,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.4,
                    ),
                  ),
                ],
              ),
        32.verticalSpace,
        Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            return LoginButton(
                isLoading: state.isOrderLoading,
                title: AppHelpers.getTranslation(TrKeys.confirmOrder),
                onPressed: () {
                  notifier.createOrder(
                      context,
                      OrderBodyData(
                        pointId: state.pickupAddress?.deliveryPoint?.id,
                        bagData: bag,
                        coupon: state.coupon,
                        note: state.comment,
                        userId: state.selectedUser?.id ?? 0,
                        deliveryFee: (state.paginateResponse?.couponPrice ?? 0),
                        deliveryType: state.orderType,
                        address: AddressModel(
                            location: state.selectedAddress?.location ??
                                LocationData(latitude: 0, longitude: 0),
                            address: state.selectedAddress?.address,
                            zipCode: state.zipCode,
                            homeNumber: state.homeNumber,
                            details: state.details,
                            phoneNumber: state.phoneNumberController?.text),
                        deliveryDate: intl.DateFormat("yyyy-MM-dd HH:mm")
                            .format(state.orderDate ?? DateTime.now()),
                        deliveryTime: state.orderTime != null
                            ? (state.orderTime?.hour.toString().length == 2
                                ? "${state.orderTime?.hour}:${state.orderTime?.minute.toString().padLeft(2, '0')}"
                                : "0${state.orderTime?.hour}:${state.orderTime?.minute.toString().padLeft(2, '0')}")
                            : (TimeOfDay.now().hour.toString().length == 2
                                ? "${TimeOfDay.now().hour}:${TimeOfDay.now().minute.toString().padLeft(2, '0')}"
                                : "0${TimeOfDay.now().hour}:${TimeOfDay.now().minute.toString().padLeft(2, '0')}"),
                        currencyId: state.selectedCurrency?.id ??
                            LocalStorage.getSelectedCurrency()?.id ??
                            0,
                        rate: state.selectedCurrency?.rate ?? 0,
                        deliveryPriceId: state.orderType == TrKeys.delivery
                            ? state.deliveryPrice?.id
                            : null,
                        stocks: state.paginateResponse?.stocks,
                      ), onSuccess: () {
                    ref
                        .read(newOrdersProvider.notifier)
                        .fetchNewOrders(isRefresh: true);
                    ref
                        .read(acceptedOrdersProvider.notifier)
                        .fetchAcceptedOrders(isRefresh: true);
                    AppHelpers.showAlertDialog(
                        context: context,
                        child: Container(
                          width: 200.w,
                          height: 200.w,
                          padding: EdgeInsets.all(30.r),
                          decoration: BoxDecoration(
                              color: Style.white,
                              borderRadius: BorderRadius.circular(10.r)),
                          child: Column(
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                    color: Style.primary,
                                    shape: BoxShape.circle),
                                padding: EdgeInsets.all(12.r),
                                child: Icon(
                                  Icons.check,
                                  size: 56.r,
                                  color: Style.white,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                AppHelpers.getTranslation(
                                    TrKeys.thankYouForOrder),
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 22.r),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        ));
                    mainNotifier.setPriceDate(null);
                  });
                });
          },
        )
      ],
    );
  }
}
