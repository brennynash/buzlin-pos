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
import 'widgets/extras/color_extras.dart';
import 'widgets/extras/image_extras.dart';
import 'widgets/extras/text_extras.dart';

class AddProductDialog extends ConsumerStatefulWidget {
  final ProductData? product;
  final bool isReplace;

  const AddProductDialog(
      {super.key, required this.product, this.isReplace = false});

  @override
  ConsumerState<AddProductDialog> createState() => _AddProductDialogState();
}

class _AddProductDialogState extends ConsumerState<AddProductDialog> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(addProductProvider.notifier)
        ..setProduct(
          widget.product,
          ref.watch(rightSideProvider).selectedBagIndex,
        )
        ..clearSelectedExtra();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(addProductProvider);
    final orderDetailState = ref.watch(orderDetailsProvider);
    final rightSideState = ref.watch(rightSideProvider);
    final notifier = ref.read(addProductProvider.notifier);
    final orderDetailsNotifier = ref.read(orderDetailsProvider.notifier);
    final rightSideNotifier = ref.read(rightSideProvider.notifier);
    final List<Stocks> stocks = state.product?.stocks ?? <Stocks>[];
    if (stocks.isNotEmpty ? (stocks.first.quantity ?? 0) == 0 : true) {
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
            maxHeight: 900.r,
            maxWidth: 600.r,
          ),
          padding: REdgeInsets.symmetric(horizontal: 40, vertical: 50),
          child: Text(
            '${state.product?.translation?.title} ${AppHelpers.getTranslation(TrKeys.outOfStock).toLowerCase()}',
          ),
        ),
      );
    }
    final bool hasDiscount = (state.selectedStock?.discount != null &&
        (state.selectedStock?.discount ?? 0) > 0);
    final String price = AppHelpers.numberFormat(
        number: hasDiscount
            ? (state.selectedStock?.price ?? 0) -
                (state.selectedStock?.discount ?? 0)
            : (state.selectedStock?.price ?? 0));
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
          maxHeight: MediaQuery.sizeOf(context).height / 1.2,
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
                    flex: 3,
                    child: CommonImage(url: widget.product?.img),
                  ),
                  20.horizontalSpace,
                  Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CircleIconButton(
                              size: 60,
                              backgroundColor: Style.transparent,
                              iconData: Remix.close_line,
                              iconColor: Style.black,
                              onTap: context.maybePop,
                            ),
                          ],
                        ),
                        Text(
                          widget.product?.translation?.title ?? '',
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w600,
                            fontSize: 22.sp,
                            color: Style.black,
                            letterSpacing: -0.4,
                          ),
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                        8.verticalSpace,
                        Text(
                          widget.product?.translation?.description ?? '',
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w500,
                            fontSize: 16.sp,
                            color: Style.iconColor,
                            letterSpacing: -0.4,
                          ),
                        ),
                        const Divider(height: 20),
                        Row(
                          children: [
                            Column(
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
                                    onPressed: () {
                                      notifier.decreaseStockCount(
                                          rightSideState.selectedBagIndex);
                                    },
                                    icon: const Icon(Remix.subtract_line),
                                  ),
                                  13.horizontalSpace,
                                  Text(
                                    '${(state.stockCount == 0 ? 1 : state.stockCount) * (state.product?.interval ?? 1)} ${state.product?.unit?.translation?.title ?? ""}',
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18.sp,
                                      color: Style.black,
                                      letterSpacing: -0.4,
                                    ),
                                  ),
                                  12.horizontalSpace,
                                  IconButton(
                                    onPressed: () {
                                      notifier.increaseStockCount(
                                          rightSideState.selectedBagIndex);
                                    },
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
                                              notifier.updateSelectedIndexes(
                                                  index: typedExtra.groupIndex,
                                                  value: s.index,
                                                  bagIndex: rightSideState
                                                      .selectedBagIndex,
                                                  typedExtra: typedExtra,
                                                  uiExtra: s);
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
                                                  notifier
                                                      .updateSelectedIndexes(
                                                    index:
                                                        typedExtra.groupIndex,
                                                    value: uiExtra.index,
                                                    bagIndex: rightSideState
                                                        .selectedBagIndex,
                                                    typedExtra: typedExtra,
                                                    uiExtra: uiExtra,
                                                  );
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
                        100.verticalSpace,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: 120.w,
                              child: LoginButton(
                                isLoading: state.isLoading,
                                title: AppHelpers.getTranslation(TrKeys.add),
                                onPressed: () {
                                  if (widget.isReplace) {
                                    var stock = orderDetailState.changedStock;
                                    stock = stock?.copyWith(
                                        quantity: state.stockCount != 0
                                            ? state.stockCount
                                            : 1);
                                    orderDetailsNotifier.setNewStock(
                                        state.selectedStock?.copyWith(
                                            product: state.product,
                                            quantity: state.stockCount != 0
                                                ? state.stockCount
                                                : 1),
                                        state.product ?? ProductData());
                                  } else {
                                    notifier.addProductToBag(context,
                                        rightSideState.selectedBagIndex,
                                        (updateProducts) {
                                      rightSideNotifier.fetchCarts(
                                        checkYourNetwork: () {
                                          AppHelpers.showSnackBar(
                                            context,
                                            AppHelpers.getTranslation(TrKeys
                                                .checkYourNetworkConnection),
                                          );
                                        },
                                      );
                                    });
                                  }
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
