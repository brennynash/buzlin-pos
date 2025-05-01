// ignore_for_file: must_be_immutable
import 'package:admin_desktop/application/right_side/right_side_notifier.dart';
import 'package:admin_desktop/presentation/routes/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:remixicon_updated/remixicon_updated.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import 'package:intl/intl.dart';
import 'package:admin_desktop/application/providers.dart';
import 'package:admin_desktop/domain/models/models.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/components/components.dart';
import 'address/country/country_modal.dart';
import 'address/select_address_page.dart';
import 'delivery_info_widget.dart';
import 'package:admin_desktop/application/right_side/right_side_state.dart';

class OrderInformation extends ConsumerStatefulWidget {
  const OrderInformation({super.key});

  @override
  ConsumerState<OrderInformation> createState() => _OrderInformationState();
}

class _OrderInformationState extends ConsumerState<OrderInformation> {
  final GlobalKey<FormState> form = GlobalKey<FormState>();

  List listOfType = [
    TrKeys.delivery,
    TrKeys.pickup,
  ];

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(rightSideProvider.notifier);
    final state = ref.watch(rightSideProvider);
    final BagData bag = state.bags[state.selectedBagIndex];
    return Container(
      width: MediaQuery.sizeOf(context).width / 2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: Style.white,
      ),
      child: SingleChildScrollView(
        padding: REdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: form,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    AppHelpers.getTranslation(TrKeys.order),
                    style: GoogleFonts.inter(
                        fontSize: 22.r, fontWeight: FontWeight.w600),
                  ),
                  const Spacer(),
                  IconButton(
                      splashRadius: 5.r,
                      onPressed: () {
                        context.maybePop();
                      },
                      icon: const Icon(Remix.close_line))
                ],
              ),
              16.verticalSpace,
              _detailWidget(notifier: notifier, bag: bag, state: state),
              12.verticalSpace,
              const Divider(),
              12.verticalSpace,
              Text(
                AppHelpers.getTranslation(TrKeys.shippingInformation),
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600, fontSize: 22.r),
              ),
              16.verticalSpace,
              Row(
                children: [
                  ...listOfType.map((e) {
                    final color = state.orderType.toLowerCase() ==
                            e.toString().toLowerCase()
                        ? Style.white
                        : Style.black;
                    return Expanded(
                      child: InkWell(
                        onTap: () {
                          // showDialog(
                          //   context: context,
                          //   builder: (context) {
                          //     return const SelectDeliveryOrPoint();
                          //   },
                          // );
                          notifier.setSelectedOrderType(e);
                          if (state.orderType.toLowerCase() !=
                              e.toString().toLowerCase()) {
                            ref.read(rightSideProvider.notifier).fetchCarts(
                                checkYourNetwork: () {
                                  AppHelpers.showSnackBar(
                                    context,
                                    AppHelpers.getTranslation(
                                        TrKeys.checkYourNetworkConnection),
                                  );
                                },
                                isNotLoading: true);
                          }
                        },
                        child: ButtonEffectAnimation(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 4.r),
                            decoration: BoxDecoration(
                              color: state.orderType.toLowerCase() ==
                                      e.toString().toLowerCase()
                                  ? Style.primary
                                  : Style.editProfileCircle,
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 10.r),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Style.transparent,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: color,
                                      ),
                                    ),
                                    padding: EdgeInsets.all(6.r),
                                    child: e == TrKeys.delivery
                                        ? Icon(
                                            Remix.takeaway_fill,
                                            size: 18.sp,
                                            color: color,
                                          )
                                        : SvgPicture.asset(
                                            "assets/svg/pickup.svg",
                                            colorFilter: ColorFilter.mode(
                                                color, BlendMode.srcIn)),
                                  ),
                                  8.horizontalSpace,
                                  Text(
                                    AppHelpers.getTranslation(e),
                                    style: Style.interMedium(
                                      size: 14.sp,
                                      color: color,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
              12.verticalSpace,
              const Divider(),
              24.verticalSpace,
              Row(
                children: [
                  Expanded(
                      child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          AppHelpers.showAlertDialog(
                            context: context,
                            child: SizedBox(
                              height: MediaQuery.sizeOf(context).width * .8,
                              width: MediaQuery.sizeOf(context).width / 2 * 3,
                              child: CountryModal(
                                bagIndex: state.selectedBagIndex,
                              ),
                            ),
                          );
                        },
                        child: SelectFromButton(
                          isNonSelect: true,
                          title: state.pickupAddress?.country == null
                              ? AppHelpers.getTranslation(TrKeys.selectAddress)
                              : " ${state.pickupAddress?.country?.translation?.title ?? ""} , ${state.pickupAddress?.city?.translation?.title ?? ""}",
                        ),
                      ),
                      if (state.orderType == TrKeys.delivery)
                        Column(
                          children: [
                            24.verticalSpace,
                            OutlinedBorderTextField(
                              label: null,
                              validator: AppValidators.emptyCheck,
                              hintText: TrKeys.homeNumber,
                              onChanged: notifier.setHomeNumber,
                            ),
                          ],
                        ),
                    ],
                  )),
                  16.horizontalSpace,
                  Expanded(
                      child: Column(
                    children: [
                      state.orderType != TrKeys.delivery
                          ? Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    state.pickupAddress?.country?.id != null &&
                                            ref
                                                .watch(pickupPointsProvider)
                                                .deliveryPoints
                                                .isNotEmpty
                                        ? context.pushRoute(PickupMapRoute(
                                            countryId: state
                                                .pickupAddress!.country!.id!,
                                            regionId: state.pickupAddress!
                                                .country?.regionId))
                                        : null;
                                  },
                                  child: SelectFromButton(
                                    isLoading: ref
                                        .watch(pickupPointsProvider)
                                        .isLoading,
                                    isNonSelect: true,
                                    title: state.pickupAddress?.deliveryPoint
                                                ?.translation?.title !=
                                            null
                                        ? state.pickupAddress?.deliveryPoint
                                                ?.translation?.title ??
                                            AppHelpers.getTranslation(
                                                TrKeys.noTitle)
                                        : AppHelpers.getTranslation(
                                            TrKeys.pickup),
                                  ),
                                ),
                                Visibility(
                                  visible: state.selectPaymentError != null,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(top: 6.r, left: 4.r),
                                    child: Text(
                                      AppHelpers.getTranslation(
                                          state.selectPaymentError ?? ""),
                                      style: GoogleFonts.inter(
                                          color: Style.red, fontSize: 14.sp),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : OutlinedBorderTextField(
                              label: null,
                              hintText: TrKeys.zipCode,
                              validator: AppValidators.emptyCheck,
                              onChanged: notifier.setZipCode,
                            ),
                      state.orderType == TrKeys.delivery
                          ? Column(
                              children: [
                                24.verticalSpace,
                                if (state.orderType == TrKeys.delivery)
                                  Column(
                                    children: [
                                      PopupMenuButton<int>(
                                        itemBuilder: (context) {
                                          AppHelpers.showAlertDialog(
                                              context: context,
                                              child: SizedBox(
                                                child: SelectAddressPage(
                                                  location: state
                                                      .selectedAddress
                                                      ?.location,
                                                  onSelect: (address) {
                                                    notifier.setSelectedAddress(
                                                        address: address);
                                                    ref
                                                        .read(rightSideProvider
                                                            .notifier)
                                                        .fetchCarts(
                                                            checkYourNetwork:
                                                                () {
                                                              AppHelpers
                                                                  .showSnackBar(
                                                                context,
                                                                AppHelpers
                                                                    .getTranslation(
                                                                        TrKeys
                                                                            .checkYourNetworkConnection),
                                                              );
                                                            },
                                                            isNotLoading: true);
                                                  },
                                                ),
                                              ));

                                          return [];
                                        },
                                        onSelected: (s) =>
                                            notifier.setSelectedAddress(),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                        ),
                                        color: Style.white,
                                        elevation: 10,
                                        child: SelectFromButton(
                                          title:
                                              state.selectedAddress?.address ??
                                                  AppHelpers.getTranslation(
                                                      TrKeys.selectAddress),
                                        ),
                                      ),
                                      Visibility(
                                        visible:
                                            state.selectAddressError != null,
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              top: 6.r, left: 4.r),
                                          child: Text(
                                            AppHelpers.getTranslation(
                                                state.selectAddressError ?? ""),
                                            style: GoogleFonts.inter(
                                                color: Style.red,
                                                fontSize: 14.sp),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                              ],
                            )
                          : const SizedBox.shrink(),
                    ],
                  ))
                ],
              ),
              if (state.orderType == TrKeys.delivery) 24.verticalSpace,
              if (state.orderType == TrKeys.delivery)
                OutlinedBorderTextField(
                  label: null,
                  hintText: TrKeys.detail,
                  validator: AppValidators.emptyCheck,
                  onChanged: notifier.setDetail,
                ),
              24.verticalSpace,
              _priceInformation(
                  state: state,
                  notifier: notifier,
                  bag: bag,
                  context: context,
                  mainNotifier: ref.read(mainProvider.notifier))
            ],
          ),
        ),
      ),
    );
  }

  Widget _priceInformation(
      {required RightSideState state,
      required RightSideNotifier notifier,
      required MainNotifier mainNotifier,
      required BagData bag,
      required BuildContext context}) {
    return Column(
      children: [
        if (state.paginateResponse?.price != null &&
            state.paginateResponse?.price != 0)
          DeliveryInfoWidget(
              title: TrKeys.subtotal,
              textDelivery: AppHelpers.numberFormat(
                  symbol: bag.selectedCurrency?.symbol,
                  isOrder: bag.selectedCurrency?.symbol != null,
                  number: state.paginateResponse?.price)),
        if (state.paginateResponse?.totalTax != null &&
            state.paginateResponse?.totalTax != 0)
          Column(
            children: [
              12.verticalSpace,
              DeliveryInfoWidget(
                  title: TrKeys.tax,
                  textDelivery: AppHelpers.numberFormat(
                      symbol: bag.selectedCurrency?.symbol,
                      isOrder: bag.selectedCurrency?.symbol != null,
                      number: state.paginateResponse?.totalTax)),
            ],
          ),
        if (state.deliveryPrice?.id != null ||
            (state.paginateResponse?.deliveryFee ?? 0) != 0)
          Column(
            children: [
              12.verticalSpace,
              DeliveryInfoWidget(
                  title: TrKeys.deliveryFee,
                  textDelivery: AppHelpers.numberFormat(
                      symbol: bag.selectedCurrency?.symbol,
                      isOrder: bag.selectedCurrency?.symbol != null,
                      number: state.orderType == TrKeys.delivery
                          ? state.deliveryPrice?.price ?? 0
                          : state.paginateResponse?.deliveryFee)),
            ],
          ),
        if (state.serviceFee != 0)
          Column(
            children: [
              12.verticalSpace,
              DeliveryInfoWidget(
                title: TrKeys.serviceFee,
                textDelivery: AppHelpers.numberFormat(
                    symbol: bag.selectedCurrency?.symbol,
                    isOrder: bag.selectedCurrency?.symbol != null,
                    number: state.serviceFee),
              ),
            ],
          ),
        if (state.paginateResponse?.totalDiscount != null &&
            state.paginateResponse?.totalDiscount != 0)
          Column(
            children: [
              12.verticalSpace,
              DeliveryInfoWidget(
                title: TrKeys.discount,
                textDelivery: "-${AppHelpers.numberFormat(
                  number: state.paginateResponse?.totalDiscount,
                  isOrder: bag.selectedCurrency?.symbol != null,
                  symbol: state.selectedCurrency?.symbol,
                )}",
                textColor: Style.red,
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
                  isOrder: bag.selectedCurrency?.symbol != null,
                  symbol: state.selectedCurrency?.symbol,
                )}",
                textColor: Style.red,
              ),
            ],
          ),
        const Divider(),
        20.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 186.w,
              child: LoginButton(
                  title: AppHelpers.getTranslation(TrKeys.placeOrder),
                  onPressed: () {
                    if (form.currentState?.validate() ?? false) {
                      if (state.paginateResponse?.stocks?.isEmpty ?? true) {
                        AppHelpers.errorSnackBar(context,
                            text: AppHelpers.getTranslation(TrKeys.cartEmpty));
                        return;
                      }
                      if (state.selectedUser == null) {
                        AppHelpers.errorSnackBar(context,
                            text: AppHelpers.getTranslation(
                                TrKeys.pleaseSelectAUser));
                        return;
                      }
                      if ((state.orderType == TrKeys.pickup) &&
                          state.pickupAddress?.deliveryPoint == null) {
                        AppHelpers.errorSnackBar(context,
                            text: AppHelpers.getTranslation(
                                TrKeys.selectPointAddress));
                        return;
                      }
                      if ((state.orderType == TrKeys.delivery) &&
                          state.deliveryPrice == null) {
                        AppHelpers.errorSnackBar(context,
                            text: AppHelpers.getTranslation(
                                TrKeys.selectAddress));
                        return;
                      }

                      if (state.orderType == TrKeys.delivery) {
                        notifier.placeOrder(
                          checkYourNetwork: () {
                            AppHelpers.showSnackBar(
                              context,
                              AppHelpers.getTranslation(
                                  TrKeys.checkYourNetworkConnection),
                            );
                          },
                          openSelectDeliveriesDrawer: () {
                            mainNotifier.setPriceDate(state.paginateResponse);
                            context.maybePop();
                          },
                        );
                      } else {
                        state.pickupAddress?.deliveryPoint != null
                            ? notifier.placeOrder(
                                checkYourNetwork: () {
                                  AppHelpers.showSnackBar(
                                    context,
                                    AppHelpers.getTranslation(
                                        TrKeys.checkYourNetworkConnection),
                                  );
                                },
                                openSelectDeliveriesDrawer: () {
                                  mainNotifier
                                      .setPriceDate(state.paginateResponse);
                                  context.maybePop();
                                },
                              )
                            : null;
                      }
                    }
                  }),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                    symbol: bag.selectedCurrency?.symbol,
                    isOrder: bag.selectedCurrency?.symbol != null,
                    number: (state.paginateResponse?.totalPrice ?? 0) +
                        (state.orderType == 'delivery'
                            ? (state.deliveryPrice?.price ?? 0)
                            : 0),
                  ),
                  style: GoogleFonts.inter(
                    color: Style.black,
                    fontSize: 30.sp,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.4,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _detailWidget({
    required RightSideNotifier notifier,
    required BagData bag,
    required RightSideState state,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: Style.unselectedBottomBarBack,
                    width: 1.r,
                  ),
                ),
                alignment: Alignment.center,
                height: 56.r,
                padding: EdgeInsets.only(left: 16.r),
                child: CustomDropdown(
                  hintText: AppHelpers.getTranslation(TrKeys.selectUser),
                  searchHintText: AppHelpers.getTranslation(TrKeys.searchUser),
                  dropDownType: DropDownType.users,
                  onChanged: (value) {
                    notifier.setUsersQuery(context, value);
                  },
                  initialUser: bag.selectedUser,
                ),
              ),
              Visibility(
                visible: state.selectUserError != null,
                child: Padding(
                  padding: EdgeInsets.only(top: 6.r, left: 4.r),
                  child: Text(
                    AppHelpers.getTranslation(state.selectUserError ?? ""),
                    style: GoogleFonts.inter(color: Style.red, fontSize: 14.sp),
                  ),
                ),
              ),
              26.verticalSpace,
              PopupMenuButton<int>(
                itemBuilder: (context) {
                  return state.currencies
                      .map(
                        (currency) => PopupMenuItem<int>(
                          value: currency.id,
                          child: Text(
                            '${currency.title}(${currency.symbol})',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                              color: Style.black,
                              letterSpacing: -14 * 0.02,
                            ),
                          ),
                        ),
                      )
                      .toList();
                },
                onSelected: notifier.setSelectedCurrency,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                color: Style.white,
                elevation: 10,
                child: SelectFromButton(
                  title: AppHelpers.getTranslation(
                      state.selectedCurrency?.title ?? TrKeys.selectPayment),
                ),
              ),
              // PopupMenuButton<CurrencyData>(
              //   initialValue: LocalStorage.getSelectedCurrency(),
              //
              //   itemBuilder: (context) {
              //     return state.currencies
              //         .map(
              //           (currency) => PopupMenuItem<CurrencyData>(
              //         child: Text(
              //           '${currency.title}(${currency.symbol})',
              //           style: GoogleFonts.inter(
              //             fontWeight: FontWeight.w500,
              //             fontSize: 14.sp,
              //             color: Style.black,
              //             letterSpacing: -14 * 0.02,
              //           ),
              //         ),
              //       ),
              //     )
              //         .toList();
              //   },
              //   onSelected: notifier.setSelectedCurrency,
              //   shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(10.r),
              //   ),
              //   color: Style.white,
              //   elevation: 10,
              //   child: SelectFromButton(
              //     title: state.selectedCurrency?.title ??
              //         AppHelpers.getTranslation(TrKeys.selectCurrency),
              //   ),
              // ),
              Visibility(
                visible: state.selectCurrencyError != null,
                child: Padding(
                  padding: EdgeInsets.only(top: 6.r, left: 4.r),
                  child: Text(
                    AppHelpers.getTranslation(state.selectCurrencyError ?? ""),
                    style: GoogleFonts.inter(color: Style.red, fontSize: 14.sp),
                  ),
                ),
              ),
              24.verticalSpace,
              PopupMenuButton<int>(
                itemBuilder: (context) {
                  showDatePicker(
                    context: context,
                    initialDate: state.orderDate ?? DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(
                      const Duration(days: 1000),
                    ),
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: const ColorScheme.light(
                            primary: Style.primary,
                            onPrimary: Style.white,
                            onSurface: Style.black,
                          ),
                          textButtonTheme: TextButtonThemeData(
                            style: TextButton.styleFrom(
                              foregroundColor: Style.black,
                            ),
                          ),
                        ),
                        child: child!,
                      );
                    },
                  ).then((date) {
                    if (date != null) {
                      notifier.setDate(date);
                    }
                  });
                  return [];
                },
                onSelected: (s) {},
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                color: Style.white,
                elevation: 10,
                child: SelectFromButton(
                  title: state.orderDate == null
                      ? DateFormat("MMM dd").format(DateTime.now())
                      : DateFormat("MMM dd")
                          .format(state.orderDate ?? DateTime.now()),
                ),
              ),
            ],
          ),
        ),
        16.horizontalSpace,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PopupMenuButton<int>(
                itemBuilder: (context) {
                  return state.payments
                      .map(
                        (payment) => PopupMenuItem<int>(
                          value: payment.id,
                          child: Text(
                            AppHelpers.getTranslation(payment.tag ?? ""),
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                              color: Style.black,
                              letterSpacing: -14 * 0.02,
                            ),
                          ),
                        ),
                      )
                      .toList();
                },
                onSelected: notifier.setSelectedPayment,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                color: Style.white,
                elevation: 10,
                child: SelectFromButton(
                  title: AppHelpers.getTranslation(
                      state.selectedPayment?.tag ?? TrKeys.paymentType),
                ),
              ),
              24.verticalSpace,
              PopupMenuButton<int>(
                itemBuilder: (context) {
                  showTimePicker(
                    context: context,
                    initialTime: state.orderTime ?? TimeOfDay.now(),
                    builder: (context, child) {
                      return MediaQuery(
                        data: MediaQuery.of(context).copyWith(
                          alwaysUse24HourFormat: AppHelpers.getHourFormat24(),
                        ),
                        child: Theme(
                          data: Theme.of(context).copyWith(
                            colorScheme: const ColorScheme.light(
                              primary: Style.primary,
                              onPrimary: Style.black,
                              onSurface: Style.black,
                            ),
                            textButtonTheme: TextButtonThemeData(
                              style: TextButton.styleFrom(
                                foregroundColor: Style.black,
                              ),
                            ),
                          ),
                          child: child!,
                        ),
                      );
                    },
                  ).then((time) {
                    if (time != null) {
                      notifier.setTime(time);
                    }
                  });
                  return [];
                },
                onSelected: (s) {},
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                color: Style.white,
                elevation: 10,
                child: SelectFromButton(
                  title: state.orderTime == null
                      ? TimeService.timeFormat(DateTime.now())
                      : TimeService.timeFormatTime(
                          state.orderTime?.format(context)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
