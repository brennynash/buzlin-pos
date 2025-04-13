import 'package:admin_desktop/application/right_side/right_side_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import 'package:admin_desktop/domain/models/models.dart';
import '../../../../assets.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/components/components.dart';
import 'delivery_info_widget.dart';
import 'note_dialog.dart';
import 'order_information.dart';
import 'promo_code_dialog.dart';
import 'package:admin_desktop/application/right_side/right_side_provider.dart';

class PageViewItem extends ConsumerStatefulWidget {
  final BagData bag;

  const PageViewItem({super.key, required this.bag});

  @override
  ConsumerState<PageViewItem> createState() => _PageViewItemState();
}

class _PageViewItemState extends ConsumerState<PageViewItem> {
  late TextEditingController coupon;

  @override
  void initState() {
    super.initState();
    coupon = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref
          .read(rightSideProvider.notifier)
          .setInitialBagData(context, widget.bag);
    });
  }

  @override
  void dispose() {
    coupon.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(rightSideProvider.notifier);
    final state = ref.watch(rightSideProvider);
    return AbsorbPointer(
      absorbing: state.isUserDetailsLoading ||
          state.isPaymentsLoading ||
          state.isBagsLoading ||
          state.isUsersLoading ||
          state.isCurrenciesLoading ||
          state.isProductCalculateLoading,
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: Style.white,
                  ),
                  child: (state.paginateResponse?.stocks?.isNotEmpty ?? false)
                      ? Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                top: 8.r,
                                right: 24.r,
                                left: 24.r,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    AppHelpers.getTranslation(TrKeys.products),
                                    style: GoogleFonts.inter(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      notifier.clearBag(context);
                                    },
                                    child: Padding(
                                        padding: EdgeInsets.all(8.r),
                                        child: Text(
                                          AppHelpers.getTranslation(
                                              TrKeys.clearAllOrders),
                                          style: Style.interNormal(
                                              color: Style.red, size: 14.sp),
                                        )),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount:
                                  state.paginateResponse?.stocks?.length ?? 0,
                              itemBuilder: (context, index) {
                                return CartOrderItem(
                                  symbol: widget.bag.selectedCurrency?.symbol,
                                  add: () {
                                    notifier.increaseProductCount(
                                        productIndex: index);
                                  },
                                  remove: () {
                                    notifier.decreaseProductCount(
                                        productIndex: index);
                                  },
                                  cart:
                                      state.paginateResponse?.stocks?[index] ??
                                          Stocks(),
                                  delete: () {
                                    notifier.deleteProductCount(
                                        bagProductData: state
                                            .bags[state.selectedBagIndex]
                                            .bagProducts?[index],
                                        productIndex: index);
                                  },
                                );
                              },
                            ),
                            8.verticalSpace,
                            Column(
                              children: [
                                Padding(
                                  padding:
                                      REdgeInsets.symmetric(horizontal: 20),
                                  child: Row(
                                    children: [
                                      Text(
                                        AppHelpers.getTranslation(TrKeys.add),
                                        style: GoogleFonts.inter(
                                            color: Style.black,
                                            fontSize: 14.sp),
                                      ),
                                      const Spacer(),
                                      InkWell(
                                        onTap: () {
                                          AppHelpers.showAlertDialog(
                                              context: context,
                                              child: const PromoCodeDialog());
                                        },
                                        child: ButtonEffectAnimation(
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10.r,
                                                horizontal: 18.r),
                                            decoration: BoxDecoration(
                                                color: Style.addButtonColor,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.r)),
                                            child: Text(
                                              AppHelpers.getTranslation(
                                                  TrKeys.promoCode),
                                              style: GoogleFonts.inter(
                                                  fontSize: 14.sp),
                                            ),
                                          ),
                                        ),
                                      ),
                                      26.horizontalSpace,
                                      InkWell(
                                        onTap: () {
                                          AppHelpers.showAlertDialog(
                                              context: context,
                                              child: const NoteDialog());
                                        },
                                        child: ButtonEffectAnimation(
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10.r,
                                                horizontal: 18.r),
                                            decoration: BoxDecoration(
                                                color: Style.addButtonColor,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.r)),
                                            child: Text(
                                              AppHelpers.getTranslation(
                                                  TrKeys.note),
                                              style: GoogleFonts.inter(
                                                  fontSize: 14.sp),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                _price(state),
                              ],
                            ),
                            28.verticalSpace,
                          ],
                        )
                      : Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            170.verticalSpace,
                            Container(
                              width: 142.r,
                              height: 142.r,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                color: Style.dontHaveAccBtnBack,
                              ),
                              alignment: Alignment.center,
                              child: Image.asset(
                                Assets.pngNoProducts,
                                width: 87.r,
                                height: 60.r,
                                fit: BoxFit.cover,
                              ),
                            ),
                            14.verticalSpace,
                            Text(
                              '${AppHelpers.getTranslation(TrKeys.thereAreNoItemsInThe)} ${AppHelpers.getTranslation(TrKeys.bag).toLowerCase()}',
                              style: GoogleFonts.inter(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                letterSpacing: -14 * 0.02,
                                color: Style.black,
                              ),
                            ),
                            SizedBox(height: 170.r, width: double.infinity),
                          ],
                        ),
                ),
                15.verticalSpace,
              ],
            ),
          ),
          BlurLoadingWidget(
            isLoading: state.isUserDetailsLoading ||
                state.isPaymentsLoading ||
                state.isBagsLoading ||
                state.isUsersLoading ||
                state.isCurrenciesLoading ||
                state.isProductCalculateLoading,
          ),
        ],
      ),
    );
  }

  Column _price(RightSideState state) {
    return Column(
      children: [
        8.verticalSpace,
        const Divider(),
        8.verticalSpace,
        Padding(
          padding: REdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              if ((state.paginateResponse?.price ?? 0) != 0)
                DeliveryInfoWidget(
                  title: TrKeys.subtotal,
                  textDelivery: AppHelpers.numberFormat(
                    number: state.paginateResponse?.price,
                    symbol: widget.bag.selectedCurrency?.symbol,
                    isOrder: widget.bag.selectedCurrency?.symbol != null,
                  ),
                ),
              if (state.serviceFee != 0)
                Column(
                  children: [
                    20.verticalSpace,
                    DeliveryInfoWidget(
                      title: TrKeys.serviceFee,
                      textDelivery: AppHelpers.numberFormat(
                        number: state.serviceFee,
                        symbol: widget.bag.selectedCurrency?.symbol,
                        isOrder: widget.bag.selectedCurrency?.symbol != null,
                      ),
                    ),
                  ],
                ),
              if (state.deliveryPrice?.id != null || state.deliveryFee != 0)
                Column(
                  children: [
                    12.verticalSpace,
                    DeliveryInfoWidget(
                        title: TrKeys.deliveryFee,
                        textDelivery: AppHelpers.numberFormat(
                            symbol: widget.bag.selectedCurrency?.symbol,
                            isOrder:
                                widget.bag.selectedCurrency?.symbol != null,
                            number: state.orderType == TrKeys.delivery
                                ? state.deliveryPrice?.price ?? 0
                                : state.deliveryFee)),
                  ],
                ),
              if (state.paginateResponse?.totalTax != null &&
                  state.paginateResponse?.totalTax != 0)
                Column(
                  children: [
                    20.verticalSpace,
                    DeliveryInfoWidget(
                      title: TrKeys.tax,
                      textDelivery: AppHelpers.numberFormat(
                        number: state.paginateResponse?.totalTax,
                        symbol: widget.bag.selectedCurrency?.symbol,
                        isOrder: widget.bag.selectedCurrency?.symbol != null,
                      ),
                    ),
                  ],
                ),
              if (state.paginateResponse?.totalDiscount != null &&
                  state.paginateResponse?.totalDiscount != 0)
                Column(
                  children: [
                    20.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppHelpers.getTranslation(TrKeys.discount),
                          style: GoogleFonts.inter(
                            color: Style.black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.4,
                          ),
                        ),
                        Text(
                          "-${AppHelpers.numberFormat(
                            number: state.paginateResponse?.totalDiscount,
                            symbol: widget.bag.selectedCurrency?.symbol,
                            isOrder:
                                widget.bag.selectedCurrency?.symbol != null,
                          )}",
                          style: GoogleFonts.inter(
                            color: Style.red,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            letterSpacing: -0.4,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              if (state.paginateResponse?.couponPrice != null &&
                  state.paginateResponse?.couponPrice != 0)
                Column(
                  children: [
                    12.verticalSpace,
                    DeliveryInfoWidget(
                      title: TrKeys.coupon,
                      textDelivery: "-${AppHelpers.numberFormat(
                        number: state.paginateResponse?.couponPrice,
                        symbol: widget.bag.selectedCurrency?.symbol,
                        isOrder: widget.bag.selectedCurrency?.symbol != null,
                      )}",
                      textColor: Style.red,
                    ),
                  ],
                ),
            ],
          ),
        ),
        8.verticalSpace,
        const Divider(),
        8.verticalSpace,
        Padding(
          padding: REdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppHelpers.getTranslation(TrKeys.totalPrice),
                    style: GoogleFonts.inter(
                      color: Style.black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.4,
                    ),
                  ),
                  Text(
                    AppHelpers.numberFormat(
                      number: state.totalFee,
                      symbol: widget.bag.selectedCurrency?.symbol,
                      isOrder: widget.bag.selectedCurrency?.symbol != null,
                    ),
                    style: GoogleFonts.inter(
                      color: Style.black,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.4,
                    ),
                  ),
                ],
              ),
              24.verticalSpace,
              LoginButton(
                borderRadius: 15.r,
                isLoading: state.isButtonLoading,
                title: TrKeys.order,
                onPressed: () {
                  ref.read(rightSideProvider.notifier).clear();
                  AppHelpers.showAlertDialog(
                      context: context, child: const OrderInformation());
                },
              )
            ],
          ),
        ),
      ],
    );
  }
}
