import 'dart:async';
import 'dart:ui';
import 'package:admin_desktop/domain/models/models.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import 'package:remixicon_updated/remixicon_updated.dart';
import 'package:admin_desktop/application/providers.dart';
import '../../../../../assets.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/components/components.dart';
import '../../add_product/add_product_dialog.dart';

class EditStockIdDialog extends ConsumerStatefulWidget {
  final Stocks stock;
  final String? type;

  const EditStockIdDialog({super.key, required this.stock, this.type});

  @override
  ConsumerState<EditStockIdDialog> createState() => _EditStockIdDialogState();
}

class _EditStockIdDialogState extends ConsumerState<EditStockIdDialog> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    Timer(const Duration(milliseconds: 100), () {
      ref.read(orderDetailsProvider.notifier).clear();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDisable(
      child: Scaffold(
        body: Consumer(
          builder: (context, ref, child) {
            final mainState = ref.watch(mainProvider);
            final mainNotifier = ref.read(mainProvider.notifier);
            final state = ref.watch(orderDetailsProvider);
            final notifier = ref.read(orderDetailsProvider.notifier);
            return state.isLoading
                ? const Loading()
                : SafeArea(
                    child: Padding(
                      padding: REdgeInsets.symmetric(horizontal: 16),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  AppHelpers.getTranslation(TrKeys.editStock),
                                  style: Style.interMedium(size: 22),
                                ),
                                const Spacer(),
                                IconButton(
                                    onPressed: () {
                                       context.maybePop();
                                    },
                                    icon: const Icon(Remix.close_fill))
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: MediaQuery.sizeOf(context).width / 4 -
                                      50.r,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ProductGridItem(
                                          product:
                                              widget.stock.stock?.product ??
                                                  ProductData(),
                                          onTap: () {},
                                          isReplaceOrder: true),
                                      Text(
                                          "${widget.stock.stock?.product?.translation?.title}"),
                                      4.verticalSpace,
                                      Text(
                                        '${AppHelpers.getTranslation(TrKeys.amount)} : ${widget.stock.quantity} x ${AppHelpers.numberFormat(number: widget.stock.totalPrice)}',
                                        style: Style.interRegular(size: 14),
                                      ),
                                      4.verticalSpace,
                                      Text(
                                        '${AppHelpers.getTranslation(TrKeys.totalPrice)} : ${AppHelpers.numberFormat(number: ((widget.stock.totalPrice ?? 0) * (widget.stock.quantity ?? 0)))}',
                                        style: Style.interRegular(size: 14),
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(
                                  Remix.swap_box_line,
                                  size: 24.r,
                                ),
                                const Spacer(),
                                SizedBox(
                                  width: MediaQuery.sizeOf(context).width / 4 -
                                      50.r,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      state.productData != null
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                ProductGridItem(
                                                    product:
                                                        state.productData ??
                                                            ProductData(),
                                                    onTap: () {}),
                                                Text(
                                                    "${state.productData?.translation?.title}"),
                                                4.verticalSpace,
                                                Text(
                                                  '${AppHelpers.getTranslation(TrKeys.amount)} : ${state.changedStock?.quantity} x ${AppHelpers.numberFormat(number: state.changedStock?.totalPrice)}',
                                                  style: Style.interRegular(
                                                      size: 14),
                                                ),
                                                4.verticalSpace,
                                                Text(
                                                  '${AppHelpers.getTranslation(TrKeys.totalPrice)} : ${AppHelpers.numberFormat(number: ((state.changedStock?.totalPrice ?? 0) * (state.changedStock?.quantity ?? 0)))}',
                                                  style: Style.interRegular(
                                                      size: 14),
                                                ),
                                              ],
                                            )
                                          : Container(
                                              constraints: BoxConstraints(
                                                maxWidth: 227.r,
                                                maxHeight: 246.r,
                                              ),
                                              margin: REdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10.r),
                                                border: Border.all(
                                                  color: Style.black
                                                      .withOpacity(0.17),
                                                  width: 1.r,
                                                ),
                                              ),
                                              alignment: Alignment.center,
                                              child: Text(
                                                AppHelpers.getTranslation(
                                                    TrKeys.chooseProduct),
                                                style: GoogleFonts.inter(
                                                  fontSize: 16.sp,
                                                  color: Style.black,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            20.verticalSpace,
                            Text(
                              AppHelpers.getTranslation(TrKeys.chooseProduct),
                              style: Style.interMedium(size: 22),
                            ),
                            20.verticalSpace,
                            SizedBox(
                              height: 320.r,
                              child: mainState.isProductsLoading
                                  ? const ProductGridListShimmer()
                                  : mainState.products.isNotEmpty
                                      ? ScrollConfiguration(
                                          behavior:
                                              ScrollConfiguration.of(context)
                                                  .copyWith(dragDevices: {
                                            PointerDeviceKind.touch,
                                            PointerDeviceKind.mouse,
                                            PointerDeviceKind.trackpad,
                                          }),
                                          child: ListView(
                                            scrollDirection: Axis.horizontal,
                                            shrinkWrap: false,
                                            cacheExtent:
                                                (mainState.products.length /
                                                        4) *
                                                    250,
                                            children: [
                                              AnimationLimiter(
                                                child: ListView.separated(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  shrinkWrap: true,
                                                  itemCount:
                                                      mainState.products.length,
                                                  padding: REdgeInsets.only(
                                                      top: 8, bottom: 10),
                                                  itemBuilder:
                                                      (context, index) {
                                                    final product = mainState
                                                        .products[index];
                                                    return AnimationConfiguration
                                                        .staggeredGrid(
                                                      columnCount: mainState
                                                          .products.length,
                                                      position: index,
                                                      duration: const Duration(
                                                          milliseconds: 375),
                                                      child: ScaleAnimation(
                                                        scale: 0.5,
                                                        child: FadeInAnimation(
                                                          child:
                                                              ProductGridItem(
                                                            product: product,
                                                            onTap: () {
                                                              showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return AddProductDialog(
                                                                    product:
                                                                        product,
                                                                    isReplace:
                                                                        true,
                                                                  );
                                                                },
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  separatorBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    return 10.horizontalSpace;
                                                  },
                                                ),
                                              ),
                                              10.verticalSpace,
                                              mainState.isMoreProductsLoading
                                                  ? const ProductGridListShimmer(
                                                      verticalPadding: 0)
                                                  : (mainState.hasMore
                                                      ? Material(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.r),
                                                          color:
                                                              Style.transparent,
                                                          child: InkWell(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.r),
                                                            onTap: () {
                                                              mainNotifier
                                                                  .fetchProducts(
                                                                checkYourNetwork:
                                                                    () {
                                                                  AppHelpers
                                                                      .showSnackBar(
                                                                    context,
                                                                    AppHelpers.getTranslation(
                                                                        TrKeys
                                                                            .checkYourNetworkConnection),
                                                                  );
                                                                },
                                                              );
                                                            },
                                                            child: Container(
                                                              width: 200.r,
                                                              margin:
                                                                  REdgeInsets
                                                                      .all(8),
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.r),
                                                                border:
                                                                    Border.all(
                                                                  color: Style
                                                                      .black
                                                                      .withOpacity(
                                                                          0.17),
                                                                  width: 1.r,
                                                                ),
                                                              ),
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: Text(
                                                                AppHelpers
                                                                    .getTranslation(
                                                                        TrKeys
                                                                            .viewMore),
                                                                style:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontSize:
                                                                      16.sp,
                                                                  color: Style
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      : const SizedBox()),
                                              15.verticalSpace,
                                            ],
                                          ),
                                        )

                                      ///TODO
                                      : Padding(
                                          padding: EdgeInsets.only(left: 64.r),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              170.verticalSpace,
                                              Container(
                                                width: 142.r,
                                                height: 142.r,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.r),
                                                  color: Style.white,
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
                                                '${AppHelpers.getTranslation(TrKeys.thereAreNoItemsInThe)} ${AppHelpers.getTranslation(TrKeys.products).toLowerCase()}',
                                                style: GoogleFonts.inter(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w600,
                                                  letterSpacing: -14 * 0.02,
                                                  color: Style.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                            ),
                            24.verticalSpace,
                            Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  OutlinedBorderTextField(
                                    label:
                                        '${AppHelpers.getTranslation(TrKeys.note)}*',
                                    textInputAction: TextInputAction.next,
                                    // textController: title,
                                    onChanged: notifier.setReplaceNote,
                                    validator: AppValidators.emptyCheck,
                                  ),
                                  if (AppHelpers.getPhoneRequired() &&
                                      (state.order?.user?.phone == null ||
                                          state.order?.myAddress?.phone ==
                                              null))
                                    OutlinedBorderTextField(
                                      label:
                                          '${AppHelpers.getTranslation(TrKeys.phoneNumber)}*',
                                      textInputAction: TextInputAction.next,
                                      // textController: title,
                                      onChanged: notifier.setReplacePhone,
                                      validator: AppValidators.emptyCheck,
                                    ),
                                ],
                              ),
                            ),
                            24.verticalSpace,
                            Row(
                              children: [
                                const Spacer(),
                                CustomButton(
                                  bgColor: Style.primary,
                                  textColor: Style.white,
                                  title: AppHelpers.getTranslation(TrKeys.save),
                                  isLoading: state.isLoading,
                                  onTap: () {
                                    if (_formKey.currentState?.validate() ??
                                        false) {
                                      if (state.productData != null) {
                                        notifier.updateOrderStockId(
                                          context: context,
                                          success: () {
                                             context.maybePop();
                                          },
                                        );
                                      } else {
                                        AppHelpers.errorSnackBar(context,
                                            text: AppHelpers.getTranslation(
                                                TrKeys.chooseProduct));
                                      }
                                    }
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
          },
        ),
        // floatingActionButton: const PopButton(),
      ),
    );
  }
}
