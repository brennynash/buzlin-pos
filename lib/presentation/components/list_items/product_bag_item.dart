import 'package:admin_desktop/domain/models/models.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:remixicon_updated/remixicon_updated.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import '../components.dart';

class CartOrderItem extends StatelessWidget {
  final Stocks? cart;
  final String? symbol;
  final VoidCallback add;
  final VoidCallback remove;
  final VoidCallback delete;
  final bool isActive;
  final bool isOwn;

  const CartOrderItem({
    super.key,
    required this.add,
    required this.remove,
    required this.cart,
    required this.delete,
    this.isActive = true,
    this.isOwn = true,
    required this.symbol,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        extentRatio: 0.12,
        motion: const ScrollMotion(),
        children: [
          Expanded(
            child: Builder(
              builder: (context) {
                return GestureDetector(
                  onTap: () {
                    Slidable.of(context)?.close();
                    delete.call();
                  },
                  child: Container(
                    width: 50.r,
                    height: 72.r,
                    decoration: BoxDecoration(
                      color: Style.red,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16.r),
                        bottomLeft: Radius.circular(16.r),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      Remix.close_fill,
                      color: Style.white,
                      size: 24.r,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      child: Column(
        children: [
          isActive
              ? Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Style.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.r),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.r),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Wrap(
                                    children: [
                                      Text(
                                        cart?.stock?.product?.translation
                                                ?.title ??
                                            '',
                                        style: Style.interRegular(size: 14.sp),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      for (var e in cart?.stock?.extras ?? [])
                                        Text(
                                          " (${AppHelpers.getNameColor(e.value)})",
                                          style: Style.interRegular(
                                            size: 14.sp,
                                            color: Style.hint,
                                          ),
                                        ),
                                      6.horizontalSpace,
                                      for (var e in cart?.stock?.extras ?? [])
                                        if (ExtrasType.color ==
                                                AppHelpers.getExtraTypeByValue(
                                                    e.group?.type) &&
                                            e.value !=
                                                AppHelpers.getNameColor(
                                                    e.value))
                                          Container(
                                            height: 24.r,
                                            width: 24.r,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Color(int.parse(
                                                    '0xFF${e.value.substring(1, 7)}')),
                                                border: Border.all(
                                                    color: (e.value.substring(
                                                                1, 7) ==
                                                            'ffffff')
                                                        ? Style.black
                                                        : Style.transparent)),
                                          ),
                                    ],
                                  ),
                                  16.verticalSpace,
                                ],
                              ),
                            ),
                          ),
                          4.horizontalSpace,
                          (cart?.stock?.discount != null)
                              ? Positioned(
                                  bottom: 4.r,
                                  right: 4.r,
                                  child: Container(
                                    width: 22.r,
                                    height: 22.r,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Style.blue),
                                    child: Icon(
                                      Remix.gift_2_fill,
                                      size: 14.r,
                                      color: Style.white,
                                    ),
                                  ),
                                )
                              : const SizedBox.shrink(),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10.h, horizontal: 16.w),
                            decoration: BoxDecoration(
                                color: Style.black,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10.r),
                                    bottomRight: Radius.circular(10.r))),
                            child: Text(
                              '${cart!.quantity! * (cart?.stock?.product?.interval ?? 1)} ${cart?.stock?.product?.unit?.translation?.title ?? ""}',
                              style: GoogleFonts.inter(
                                  fontSize: 14.sp,
                                  color: Style.white,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          24.horizontalSpace,
                          (cart?.bonus ?? false)
                              ? Container(
                                  //margin: EdgeInsets.only(top: 8.r),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5.r, horizontal: 10.r),
                                  decoration: BoxDecoration(
                                      color: Style.primary,
                                      borderRadius:
                                          BorderRadius.circular(100.r)),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Remix.gift_line,
                                        color: Style.white,
                                        size: 24.r,
                                      ),
                                      4.horizontalSpace,
                                      Text(
                                        AppHelpers.getTranslation(TrKeys.bonus),
                                        style: Style.interNormal(
                                            color: Style.white, size: 16),
                                      )
                                    ],
                                  ),
                                )
                              : Row(
                                  children: [
                                    GestureDetector(
                                      onTap: remove,
                                      child: ButtonEffectAnimation(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Style.removeButtonColor,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10.r),
                                              bottomLeft: Radius.circular(10.r),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 8.h,
                                                horizontal: 25.w),
                                            child: const Icon(
                                              Icons.remove,
                                              color: Style.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    4.horizontalSpace,
                                    GestureDetector(
                                      onTap: add,
                                      child: ButtonEffectAnimation(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Style.addButtonColor,
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(10.r),
                                              bottomRight:
                                                  Radius.circular(10.r),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 8.h,
                                                horizontal: 25.w),
                                            child: const Icon(
                                              Icons.add,
                                              color: Style.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                          Expanded(
                            child: !(cart?.stock?.discount != null)
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      if ((cart?.discount ?? 0) != 0)
                                        AutoSizeText(
                                          AppHelpers.numberFormat(
                                            number: cart?.price,
                                            symbol: symbol,
                                            isOrder: symbol != null,
                                          ),
                                          style: Style.interMedium(
                                              size: 13.sp,
                                              color: Style.red,
                                              decoration:
                                                  TextDecoration.lineThrough),
                                        ),
                                      AutoSizeText(
                                        AppHelpers.numberFormat(
                                          number: (cart?.discount ?? 0) != 0
                                              ? (cart?.price ?? 0) -
                                                  (cart?.discount ?? 0)
                                              : cart?.price,
                                          symbol: symbol,
                                          isOrder: symbol != null,
                                        ),
                                        style: Style.interMedium(size: 16.sp),
                                        maxLines: 1,
                                      ),
                                    ],
                                  )
                                : const SizedBox.shrink(),
                          ),
                          16.horizontalSpace,
                        ],
                      ),
                    ],
                  ),
                )
              : Container(
                  margin: EdgeInsets.only(bottom: 8.h),
                  padding: EdgeInsets.all(16.r),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Style.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.r),
                      ),
                      border: Border.all(color: Style.borderColor)),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                RichText(
                                    text: TextSpan(
                                        text: cart?.stock?.product?.translation
                                            ?.title,
                                        style: GoogleFonts.inter(
                                          fontSize: 16,
                                          color: Style.black,
                                        ),
                                        children: [
                                      for (var e in cart?.stock?.extras ?? [])
                                        if (ExtrasType.color !=
                                            AppHelpers.getExtraTypeByValue(
                                                e.group?.type))
                                          TextSpan(
                                            text: " (${e.value})",
                                            style: GoogleFonts.inter(
                                              fontSize: 14,
                                              color: Style.hint,
                                            ),
                                          )
                                    ])),
                                8.verticalSpace,
                                Row(
                                  children: [
                                    Text(
                                      "${AppHelpers.numberFormat(
                                        number: (cart?.totalPrice ?? 1) /
                                            (cart?.quantity ?? 1),
                                        symbol: symbol,
                                        isOrder: symbol != null,
                                      )} X ${cart?.quantity ?? 1}",
                                      style: GoogleFonts.inter(
                                        fontSize: 14,
                                        color: Style.black,
                                      ),
                                    ),
                                    const Spacer(),
                                    !(cart?.stock?.discount != null)
                                        ? Column(
                                            children: [
                                              Text(
                                                AppHelpers.numberFormat(
                                                  number:
                                                      (cart?.discount ?? 0) != 0
                                                          ? cart?.totalPrice
                                                          : cart?.price,
                                                  symbol: symbol,
                                                  isOrder: symbol != null,
                                                ),
                                                style: GoogleFonts.inter(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize:
                                                        (cart?.discount ?? 0) !=
                                                                0
                                                            ? 12
                                                            : 16,
                                                    color: Style.black,
                                                    decoration:
                                                        (cart?.discount ?? 0) !=
                                                                0
                                                            ? TextDecoration
                                                                .lineThrough
                                                            : TextDecoration
                                                                .none),
                                              ),
                                              if ((cart?.discount ?? 0) != 0)
                                                Text(
                                                  AppHelpers.numberFormat(
                                                    number: cart?.price,
                                                    symbol: symbol,
                                                    isOrder: symbol != null,
                                                  ),
                                                  style: GoogleFonts.inter(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14.sp,
                                                      color: Style.white),
                                                )
                                            ],
                                          )
                                        : const SizedBox.shrink(),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          4.horizontalSpace,
                          Stack(
                            children: [
                              CommonImage(
                                  url: cart?.stock?.product?.img ?? "",
                                  // : cartTwo?.stock?.product?.img ?? "",
                                  width: 100,
                                  height: 100,
                                  radius: 10.r),
                              (cart?.stock?.discount != null)
                                  ? Positioned(
                                      bottom: 4.r,
                                      right: 4.r,
                                      child: Container(
                                        width: 22.w,
                                        height: 22.h,
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Style.blue),
                                        child: Icon(
                                          Remix.gift_2_fill,
                                          size: 16.r,
                                          color: Style.white,
                                        ),
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
          isActive ? const Divider() : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
