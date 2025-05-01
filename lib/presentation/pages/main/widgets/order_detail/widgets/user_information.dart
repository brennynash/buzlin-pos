import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import 'package:admin_desktop/domain/models/models.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/components/components.dart';
import '../../orders_table/widgets/status/order_status_modal.dart';

class UserInformation extends StatelessWidget {
  final OrderData? order;

  const UserInformation({super.key, this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Style.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Style.borderColor),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CommonImage(
                url: order?.user?.img ?? "",
                width: 56,
                height: 56,
                radius: 30,
                isResponsive: false,
              ),
              16.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      "${order?.user?.firstname ?? ''} ${order?.user?.lastname ?? ''}",
                      style: Style.interMedium(size: 20),
                      minFontSize: 16,
                      maxLines: 1,
                    ),
                    2.verticalSpace,
                    Text(
                      order?.user?.phone ?? order?.user?.email ?? '',
                      style: Style.interRegular(
                        size: 16,
                        color: Style.iconColor,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          8.verticalSpace,
          const Divider(),
          8.verticalSpace,
          Text(
            AppHelpers.getTranslation(order?.deliveryType == TrKeys.pickup
                ? TrKeys.pointAddress
                : TrKeys.deliveryAddress),
            style: GoogleFonts.inter(fontSize: 16, color: Style.iconColor),
          ),
          12.verticalSpace,
          Text(
            order?.myAddress?.location?.address ??
                order?.deliveryPoint?.address?.address ??
                '' "",
            style: GoogleFonts.inter(
              fontSize: 18,
            ),
          ),
          8.verticalSpace,
          const Divider(),
          8.verticalSpace,
          _priceInformation(),
          8.verticalSpace,
          const Divider(),
          8.verticalSpace,
          CustomButton(
            title: AppHelpers.getTranslation(TrKeys.editStatusNote),
            onTap: () {
              AppHelpers.showAlertDialog(
                  context: context,
                  child: OrderStatusModal(
                    onlyShow: (order?.type == 1),
                  ),
                  backgroundColor: Style.bg);
            },
          ),
        ],
      ),
    );
  }

  Column _priceInformation() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppHelpers.getTranslation(TrKeys.subtotal),
              style: GoogleFonts.inter(
                color: Style.black,
                fontSize: 16,
                fontWeight: FontWeight.w400,
                letterSpacing: -0.4,
              ),
            ),
            Text(
              AppHelpers.numberFormat(
                number: order?.originPrice,
                isOrder: true,
                symbol: order?.currency?.symbol,
              ),
              style: GoogleFonts.inter(
                color: Style.black,
                fontSize: 16,
                fontWeight: FontWeight.w400,
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
                fontSize: 16,
                fontWeight: FontWeight.w400,
                letterSpacing: -0.4,
              ),
            ),
            Text(
              AppHelpers.numberFormat(
                number: order?.totalTax,
                isOrder: true,
                symbol: order?.currency?.symbol,
              ),
              style: GoogleFonts.inter(
                color: Style.black,
                fontSize: 16,
                fontWeight: FontWeight.w400,
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
              AppHelpers.getTranslation(TrKeys.serviceFee),
              style: GoogleFonts.inter(
                color: Style.black,
                fontSize: 16,
                fontWeight: FontWeight.w400,
                letterSpacing: -0.4,
              ),
            ),
            Text(
              AppHelpers.numberFormat(
                number: order?.serviceFee,
                isOrder: true,
                symbol: order?.currency?.symbol,
              ),
              style: GoogleFonts.inter(
                color: Style.black,
                fontSize: 16,
                fontWeight: FontWeight.w400,
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
                fontSize: 16,
                fontWeight: FontWeight.w400,
                letterSpacing: -0.4,
              ),
            ),
            Text(
              AppHelpers.numberFormat(
                number: order?.deliveryFee,
                isOrder: true,
                symbol: order?.currency?.symbol,
              ),
              style: GoogleFonts.inter(
                color: Style.black,
                fontSize: 16,
                fontWeight: FontWeight.w400,
                letterSpacing: -0.4,
              ),
            ),
          ],
        ),
        if ((order?.totalDiscount ?? 0) != 0)
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
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      letterSpacing: -0.4,
                    ),
                  ),
                  Text(
                    "-${AppHelpers.numberFormat(
                      number: order?.totalDiscount,
                      isOrder: true,
                      symbol: order?.currency?.symbol,
                    )}",
                    style: GoogleFonts.inter(
                      color: Style.red,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      letterSpacing: -0.4,
                    ),
                  ),
                ],
              ),
            ],
          ),
        if ((order?.coupon?.price ?? 0) != 0)
          Column(
            children: [
              20.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppHelpers.getTranslation(TrKeys.coupon),
                    style: GoogleFonts.inter(
                      color: Style.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      letterSpacing: -0.4,
                    ),
                  ),
                  Text(
                    "-${AppHelpers.numberFormat(
                      number: order?.coupon?.price,
                      isOrder: true,
                      symbol: order?.currency?.symbol,
                    )}",
                    style: GoogleFonts.inter(
                      color: Style.red,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      letterSpacing: -0.4,
                    ),
                  ),
                ],
              ),
            ],
          ),
        20.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppHelpers.getTranslation(TrKeys.totalPrice),
              style: GoogleFonts.inter(
                color: Style.black,
                fontSize: 18,
                fontWeight: FontWeight.w500,
                letterSpacing: -0.4,
              ),
            ),
            Text(
              AppHelpers.numberFormat(
                number: order?.totalPrice,
                isOrder: true,
                symbol: order?.currency?.symbol,
              ),
              style: GoogleFonts.inter(
                color: Style.black,
                fontSize: 32,
                fontWeight: FontWeight.w400,
                letterSpacing: -0.4,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
