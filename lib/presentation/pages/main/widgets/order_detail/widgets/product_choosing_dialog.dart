import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:remixicon_updated/remixicon_updated.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import 'package:admin_desktop/application/providers.dart';
import 'package:admin_desktop/domain/models/models.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/components/components.dart';
import '../../add_product/widgets/extras/color_extras.dart';
import '../../add_product/widgets/extras/image_extras.dart';
import '../../add_product/widgets/extras/text_extras.dart';

class ProductChoosingDialog extends ConsumerStatefulWidget {
  const ProductChoosingDialog({super.key});

  @override
  ConsumerState<ProductChoosingDialog> createState() =>
      _ProductChoosingDialogState();
}

class _ProductChoosingDialogState extends ConsumerState<ProductChoosingDialog> {
  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   ref.read(orderDetailsProvider.notifier)
    //
    //     ..clearSelectedExtra();
    // });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(orderDetailsProvider);
    final notifier = ref.read(orderDetailsProvider.notifier);
    final bool hasDiscount = (state.selectedStock?.discount != null &&
        (state.selectedStock?.discount ?? 0) > 0);
    final String price = AppHelpers.numberFormat(
        number: hasDiscount
            ? (state.selectedStock?.totalPrice ?? 0)
            : state.selectedStock?.price ?? 0);
    final lineThroughPrice =
        AppHelpers.numberFormat(number: state.selectedStock?.price);
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: Style.white,
        ),
        constraints: BoxConstraints(
          maxHeight: MediaQuery.sizeOf(context).height / 1.6,
          maxWidth: MediaQuery.sizeOf(context).width / 1.6,
        ),
        padding: REdgeInsets.symmetric(horizontal: 30),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              30.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: CommonImage(
                      url: state.changedStock?.stock?.product?.img,
                    ),
                  ),
                  20.horizontalSpace,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Spacer(),
                            CircleIconButton(
                              size: 60,
                              backgroundColor: Style.transparent,
                              iconData: Remix.close_line,
                              iconColor: Style.black,
                              onTap: context.maybePop,
                            ),
                          ],
                        ),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width / 1.6 - 370.w,
                          child: Text(
                            '${state.changedStock?.stock?.product?.translation?.title}',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w600,
                              fontSize: 22.sp,
                              color: Style.black,
                              letterSpacing: -0.4,
                            ),
                          ),
                        ),
                        8.verticalSpace,
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width / 1.6 - 370.w,
                          child: Text(
                            '${state.changedStock?.stock?.product?.translation?.description}',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w500,
                              fontSize: 16.sp,
                              color: Style.iconColor,
                              letterSpacing: -0.4,
                            ),
                          ),
                        ),
                        const Divider(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Row(
                              children: [
                                if (hasDiscount)
                                  Row(
                                    children: [
                                      Text(
                                        lineThroughPrice,
                                        style: GoogleFonts.inter(
                                          decoration:
                                              TextDecoration.lineThrough,
                                          fontSize: 32.sp,
                                          fontWeight: FontWeight.w600,
                                          color: Style.discountText,
                                          letterSpacing: -14 * 0.02,
                                        ),
                                      ),
                                      10.horizontalSpace,
                                    ],
                                  ),
                                Text(
                                  price,
                                  style: GoogleFonts.inter(
                                    fontSize: 32.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Style.black,
                                    letterSpacing: -14 * 0.02,
                                  ),
                                ),
                                Text(
                                  price,
                                  style: GoogleFonts.inter(
                                    fontSize: 32.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Style.black,
                                    letterSpacing: -14 * 0.02,
                                  ),
                                ),
                                Text(
                                  price,
                                  style: GoogleFonts.inter(
                                    fontSize: 32.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Style.black,
                                    letterSpacing: -14 * 0.02,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.r),
                                border: Border.all(color: Style.iconColor),
                              ),
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: () =>
                                        notifier.decreaseStockCount(),
                                    icon: const Icon(Remix.subtract_line),
                                  ),
                                  13.horizontalSpace,
                                  Text(
                                    '${(state.stockCount == 0 ? 1 : state.stockCount) * (state.productData?.interval ?? 1)} ${state.productData?.unit?.translation?.title ?? ""}',
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18.sp,
                                      color: Style.black,
                                      letterSpacing: -0.4,
                                    ),
                                  ),
                                  12.horizontalSpace,
                                  IconButton(
                                    onPressed: () => notifier
                                        .increaseStockCount(state.changedStock),
                                    icon: const Icon(Remix.add_line),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        48.verticalSpace,
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width / 1.6 - 370.w,
                          child: ListView.builder(
                            physics: const CustomBouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: state.typedExtras.length,
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, index) {
                              final TypedExtra typedExtra =
                                  state.typedExtras[index];
                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.r),
                                  color: Style.white,
                                ),
                                padding: REdgeInsets.symmetric(vertical: 6),
                                margin: REdgeInsets.only(bottom: 2),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    typedExtra.type == ExtrasType.text
                                        ? TextExtras(
                                            type: typedExtra.title,
                                            uiExtras: typedExtra.uiExtras,
                                            groupIndex: typedExtra.groupIndex,
                                            onUpdate: (s) {
                                              // notifier.updateSelectedIndexes(
                                              //     index: typedExtra.groupIndex,
                                              //     value: s.index,
                                              //     bagIndex: rightSideState.selectedBagIndex,
                                              //     typedExtra: typedExtra,
                                              //     uiExtra: s
                                              // );
                                            },
                                          )
                                        : typedExtra.type == ExtrasType.color
                                            ? ColorExtras(
                                                uiExtras: typedExtra.uiExtras,
                                                groupIndex:
                                                    typedExtra.groupIndex,
                                                onUpdate: (uiExtra) {
                                                  if (uiExtra.isSelected) {
                                                    return;
                                                  }
                                                  // notifier.updateSelectedIndexes(
                                                  //   index: typedExtra.groupIndex,
                                                  //   value: uiExtra.index,
                                                  //   bagIndex: rightSideState.selectedBagIndex,
                                                  //   typedExtra: typedExtra,
                                                  //   uiExtra: uiExtra,
                                                  // );
                                                },
                                                type: typedExtra.title,
                                              )
                                            : typedExtra.type ==
                                                    ExtrasType.image
                                                ? ImageExtras(
                                                    uiExtras:
                                                        typedExtra.uiExtras,
                                                    groupIndex:
                                                        typedExtra.groupIndex,
                                                  )
                                                : const SizedBox(),
                                    if (state.typedExtras.length != index + 1)
                                      8.verticalSpace,
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        state.typedExtras.isEmpty
                            ? 170.verticalSpace
                            : 100.verticalSpace,
                        Row(
                          children: [
                            const Spacer(),
                            SizedBox(
                              width: 120.w,
                              child: LoginButton(
                                isLoading: state.isLoading,
                                title: AppHelpers.getTranslation(TrKeys.add),
                                onPressed: () {
                                  // notifier.setNewStock(stocks);
                                  // notifier.addProductToBag(
                                  //     context, rightSideState.selectedBagIndex,
                                  //         (updateProducts) {
                                  //       rightSideNotifier.fetchCarts(
                                  //         checkYourNetwork: () {
                                  //           AppHelpers.showSnackBar(
                                  //             context,
                                  //             AppHelpers.getTranslation(
                                  //                 TrKeys.checkYourNetworkConnection),
                                  //           );
                                  //         },
                                  //       );
                                  //     });
                                  context.maybePop();
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
              24.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
