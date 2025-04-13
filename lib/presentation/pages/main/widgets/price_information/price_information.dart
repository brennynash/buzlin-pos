import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import 'package:intl/intl.dart';
import 'package:admin_desktop/application/providers.dart';
import 'package:admin_desktop/domain/models/models.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/components/components.dart';

class PriceInformation extends ConsumerStatefulWidget {
  final BagData bag;

  const PriceInformation({super.key, required this.bag});

  @override
  ConsumerState<PriceInformation> createState() => _DeliveriesDrawerState();
}

class _DeliveriesDrawerState extends ConsumerState<PriceInformation> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(rightSideProvider.notifier).fetchCarts(
        checkYourNetwork: () {
          AppHelpers.showSnackBar(
            context,
            AppHelpers.getTranslation(TrKeys.checkYourNetworkConnection),
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final rightSideState = ref.watch(rightSideProvider);

    final rightSideNotifier = ref.read(rightSideProvider.notifier);
    return AbsorbPointer(
      absorbing: rightSideState.isProductCalculateLoading,
      child: Drawer(
        backgroundColor: Style.white,
        width: 465.r,
        child: rightSideState.isProductCalculateLoading
            ? Center(
                child: CircularProgressIndicator(
                  strokeWidth: 4.r,
                  color: Style.black,
                ),
              )
            : SingleChildScrollView(
                padding: EdgeInsets.all(24.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppHelpers.getTranslation(TrKeys.orderSummary),
                      style: GoogleFonts.inter(fontSize: 22.sp),
                    ),
                    28.verticalSpace,
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount:
                          rightSideState.paginateResponse?.stocks?.length ?? 0,
                      itemBuilder: (context, index) {
                        return CartOrderItem(
                          symbol: widget.bag.selectedCurrency?.symbol,
                          delete: () {},
                          isActive: false,
                          add: () {},
                          remove: () {},
                          cart:
                              rightSideState.paginateResponse?.stocks?[index] ??
                                  Stocks(),
                        );
                      },
                    ),
                    28.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppHelpers.getTranslation(TrKeys.subtotal),
                          style: GoogleFonts.inter(
                            color: Style.black,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.4,
                          ),
                        ),
                        Text(
                          AppHelpers.numberFormat(
                              number: rightSideState.paginateResponse?.price),
                          style: GoogleFonts.inter(
                            color: Style.black,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.4,
                          ),
                        ),
                      ],
                    ),
                    20.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppHelpers.getTranslation(TrKeys.tax),
                          style: GoogleFonts.inter(
                            color: Style.black,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.4,
                          ),
                        ),
                        Text(
                          AppHelpers.numberFormat(
                              number:
                                  rightSideState.paginateResponse?.totalTax),
                          style: GoogleFonts.inter(
                            color: Style.black,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.4,
                          ),
                        ),
                      ],
                    ),
                    20.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppHelpers.getTranslation(TrKeys.deliveryFee),
                          style: GoogleFonts.inter(
                            color: Style.black,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.4,
                          ),
                        ),
                        Text(
                          AppHelpers.numberFormat(
                              number:
                                  rightSideState.paginateResponse?.couponPrice),
                          style: GoogleFonts.inter(
                            color: Style.black,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.4,
                          ),
                        ),
                      ],
                    ),
                    20.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppHelpers.getTranslation(TrKeys.discount),
                          style: GoogleFonts.inter(
                            color: Style.black,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.4,
                          ),
                        ),
                        Text(
                          "-${AppHelpers.numberFormat(number: rightSideState.paginateResponse?.totalDiscount)}",
                          style: GoogleFonts.inter(
                            color: Style.red,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.4,
                          ),
                        ),
                      ],
                    ),
                    20.verticalSpace,
                    rightSideState.paginateResponse?.couponPrice != 0
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppHelpers.getTranslation(TrKeys.promoCode),
                                style: GoogleFonts.inter(
                                  color: Style.black,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: -0.4,
                                ),
                              ),
                              Text(
                                "-${AppHelpers.numberFormat(number: rightSideState.paginateResponse?.couponPrice)}",
                                style: GoogleFonts.inter(
                                  color: Style.red,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: -0.4,
                                ),
                              ),
                            ],
                          )
                        : const SizedBox.shrink(),
                    const Divider(),
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
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.4,
                          ),
                        ),
                        Text(
                          AppHelpers.numberFormat(
                              number:
                                  rightSideState.paginateResponse?.totalPrice),
                          style: GoogleFonts.inter(
                            color: Style.black,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.4,
                          ),
                        ),
                      ],
                    ),
                    20.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: ConfirmButton(
                            height: 72.r,
                            title:
                                AppHelpers.getTranslation(TrKeys.confirmOrder),
                            onTap: () {
                              rightSideState.pickupAddress?.deliveryPoint?.id !=
                                      null
                                  ? rightSideNotifier.createOrder(
                                      context,
                                      OrderBodyData(
                                          currencyId: rightSideState
                                                  .selectedCurrency?.id ??
                                              LocalStorage.getSelectedCurrency()
                                                  ?.id ??
                                              0,
                                          rate: rightSideState.selectedCurrency?.rate ??
                                              0,
                                          bagData: widget.bag,
                                          userId:
                                              rightSideState.selectedUser?.id ??
                                                  0,
                                          deliveryFee: (rightSideState
                                                  .paginateResponse
                                                  ?.couponPrice ??
                                              0),
                                          deliveryType:
                                              rightSideState.orderType,
                                          address: AddressModel(
                                            location: rightSideState
                                                    .selectedAddress
                                                    ?.location ??
                                                LocationData(
                                                    latitude: 0, longitude: 0),
                                            address:
                                                "${rightSideState.selectedAddress?.title}, ${rightSideState.selectedAddress?.address}",
                                          ),
                                          deliveryDate: DateFormat("yyyy-MM-dd")
                                              .format(rightSideState.orderDate ??
                                                  DateTime.now()),
                                          deliveryTime: rightSideState.orderTime !=
                                                  null
                                              ? rightSideState.orderTime?.hour
                                                          .toString()
                                                          .length ==
                                                      2
                                                  ? "${rightSideState.orderTime?.hour}:${rightSideState.orderTime?.minute.toString().padLeft(2, '0')}"
                                                  : "0${rightSideState.orderTime?.hour}:${rightSideState.orderTime?.minute.toString().padLeft(2, '0')}"
                                              : DateFormat.Hm().format(DateTime.now()),
                                          pointId: rightSideState.pickupAddress?.deliveryPoint?.id,
                                          stocks: rightSideState.paginateResponse?.stocks))
                                  : null;
                            },
                            isLoading: rightSideState.isOrderLoading,
                          ),
                        ),
                        24.horizontalSpace,
                        Expanded(
                          child: ConfirmButton(
                            textColor: Style.black,
                            borderColor: Style.black,
                            bgColor: Style.transparent,
                            height: 72.r,
                            title: AppHelpers.getTranslation(TrKeys.close),
                            onTap: () {
                              context.maybePop();
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
