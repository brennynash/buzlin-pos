import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import 'package:remixicon_updated/remixicon_updated.dart';
import 'package:admin_desktop/domain/models/models.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'order_detail_pop_up.dart';

class ProductTable extends StatelessWidget {
  final List<Stocks>? detail;
  final String? symbol;
  final String status;

  const ProductTable(
      {super.key, required this.detail, this.symbol, required this.status});

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: const {
        0: FixedColumnWidth(56),
        2: FixedColumnWidth(70),
        3: FixedColumnWidth(84),
        4: FixedColumnWidth(56),
      },
      // defaultColumnWidth:
      // FixedColumnWidth((MediaQuery.sizeOf(context).width - 90.r) / 5),
      border: TableBorder.all(color: Style.transparent),
      children: [
        TableRow(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppHelpers.getTranslation(TrKeys.id),
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    color: Style.black,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.3,
                  ),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppHelpers.getTranslation(TrKeys.productName),
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    color: Style.black,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.3,
                  ),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppHelpers.getTranslation(TrKeys.quantity),
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    color: Style.black,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.3,
                  ),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppHelpers.getTranslation(TrKeys.totalPrice),
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    color: Style.black,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.3,
                  ),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  " ",
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    color: Style.black,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.3,
                  ),
                )
              ],
            ),
          ],
        ),
        for (int i = 0; i < (detail?.length ?? 0); i++)
          TableRow(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Divider(),
                    Text(
                      "#${detail?[i].id ?? 0}",
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: Style.textColor,
                        letterSpacing: -0.3,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Divider(),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            (detail?[i].stock?.product?.translation?.title ??
                                ""),
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              color: Style.textColor,
                              letterSpacing: -0.3,
                            ),
                          ),
                        ),
                        4.horizontalSpace,
                        for (var e in detail?[i].stock?.extras ?? [])
                          if (ExtrasType.color !=
                              AppHelpers.getExtraTypeByValue(e.group?.type))
                            Row(
                              children: [
                                Text(
                                  "(${e.value ?? ''})",
                                  style: Style.interRegular(
                                    size: 14,
                                    color: Style.textColor,
                                  ),
                                ),
                                6.horizontalSpace,
                              ],
                            ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Divider(),
                    Text(
                      "${detail?[i].quantity ?? 0}",
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: Style.textColor,
                        letterSpacing: -0.3,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: REdgeInsets.symmetric(vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Divider(),
                    !(detail?[i].bonus ?? false)
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppHelpers.numberFormat(
                                    symbol: symbol,
                                    number: detail?[i].totalPrice ?? 0),
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  color: Style.textColor,
                                  letterSpacing: -0.3,
                                ),
                              ),
                            ],
                          )
                        : Container(
                            //margin: EdgeInsets.only(top: 8.r),
                            padding: EdgeInsets.symmetric(
                                vertical: 5.r, horizontal: 10.r),
                            decoration: BoxDecoration(
                                color: Style.primary,
                                borderRadius: BorderRadius.circular(100.r)),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
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
                  ],
                ),
              ),
              Padding(
                padding: REdgeInsets.symmetric(vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Divider(),
                    if ((status == "accepted" || status == "new") &&
                        !(detail?[i].bonus ?? false))
                      OrderDetailPopup(stocks: detail?[i] ?? Stocks()),
                  ],
                ),
              ),
            ],
          ),
      ],
    );
  }
}
