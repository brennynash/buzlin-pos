import 'package:admin_desktop/domain/models/models.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';

class ProductPriceWidget extends StatelessWidget {
  final ProductData? product;
  final Stocks? stock;

  const ProductPriceWidget({super.key, required this.product, this.stock});

  @override
  Widget build(BuildContext context) {
    bool isOutOfStock;
    isOutOfStock = (stock?.quantity ?? 0) == 0;
    final bool hasDiscount = isOutOfStock
        ? false
        : (stock?.discount != null && (stock?.discount ?? 0) > 0);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          isOutOfStock
              ? ""
              : '${AppHelpers.getTranslation(TrKeys.inStock)} - ${stock?.quantity ?? 0}',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.inter(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            letterSpacing: -14 * 0.02,
            color: isOutOfStock ? Style.red : Style.inStockText,
          ),
        ),
        6.verticalSpace,
        isOutOfStock
            ? Text(
                AppHelpers.getTranslation(TrKeys.outOfStock),
                style: Style.interSemi(
                  size: 14,
                  color: Style.red,
                  letterSpacing: -0.3,
                ),
              )
            : (hasDiscount
                ? AppHelpers.numberFormat(number: stock?.price ?? 0).length < 9
                    ? Row(
                        children: [
                          Text(
                            AppHelpers.numberFormat(
                                number: (stock?.price ?? 0) -
                                    (stock?.discount ?? 0)),
                            style: Style.interSemi(size: 14.sp),
                          ),
                          if (stock?.discount != null)
                            Padding(
                              padding: EdgeInsets.only(left: 10.r),
                              child: Text(
                                AppHelpers.numberFormat(
                                    number: stock?.price ?? 0),
                                style: Style.interSemi(
                                    color: Style.red,
                                    size: 12.sp,
                                    decoration: TextDecoration.lineThrough),
                              ),
                            ),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppHelpers.numberFormat(
                                number: (stock?.price ?? 0) -
                                    (stock?.discount ?? 0)),
                            style: Style.interSemi(size: 20),
                          ),
                          if (stock?.discount != null)
                            Padding(
                              padding: EdgeInsets.only(right: 10.r),
                              child: Text(
                                AppHelpers.numberFormat(
                                    number: stock?.price ?? 0),
                                style: Style.interSemi(
                                  color: Style.red,
                                  size: 14,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                            ),
                        ],
                      )
                : AutoSizeText(
                    AppHelpers.numberFormat(number: stock?.totalPrice ?? 0),
                    style: Style.interMedium(
                      size: 16.sp,
                      color: Style.black,
                      letterSpacing: -0.2,
                    ),
                  )),
      ],
    );
  }
}
