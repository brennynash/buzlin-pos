import 'package:admin_desktop/application/main/main_notifier.dart';
import 'package:admin_desktop/presentation/assets.dart';
import 'package:flutter/material.dart';
import 'package:remixicon_updated/remixicon_updated.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import 'package:admin_desktop/domain/models/models.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/components/components.dart';
import '../icon_title.dart';

class DragItem extends StatelessWidget {
  final OrderData orderData;
  final bool isDrag;
  final MainNotifier mainNotifier;

  const DragItem(
      {super.key,
      required this.orderData,
      this.isDrag = false,
      required this.mainNotifier});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Transform.rotate(
        angle: isDrag ? (3.14 * (0.03)) : 0,
        child: Container(
          foregroundDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: isDrag ? Style.iconColor.withOpacity(0.3) : null),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16), color: Style.white),
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.all(6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonImage(
                    url: orderData.user?.img,
                    height: 42,
                    width: 42,
                    radius: 32,
                    isResponsive: false,
                  ),
                  6.horizontalSpace,
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            orderData.user?.firstname ?? "",
                            maxLines: 1,
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              color: Style.black,
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            "#${orderData.id}",
                            style: GoogleFonts.inter(
                                fontSize: 14, color: Style.hint),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // CustomPopup(
                  //   orderData: orderData,
                  //   isLocation: orderData.deliveryType == TrKeys.delivery,
                  // ),
                ],
              ),
              6.verticalSpace,
              const Divider(height: 2),
              12.verticalSpace,
              IconTitle(
                title: AppHelpers.getTranslation(TrKeys.date),
                icon: Remix.calendar_2_line,
                value: TimeService.dateFormatMDHm(orderData.createdAt ?? DateTime.now()),
              ),
              IconTitle(
                title: AppHelpers.getTranslation(TrKeys.amount),
                icon: Remix.money_dollar_circle_line,
                value: AppHelpers.numberFormat(number: orderData.totalPrice),
              ),
              IconTitle(
                title: AppHelpers.getTranslation(TrKeys.paymentType),
                icon: Remix.money_euro_circle_line,
                value: orderData.transaction?.paymentSystem?.tag ?? "- -",
              ),
              (orderData.deliveryman?.firstname?.isNotEmpty ?? false)
                  ? IconTitle(
                      title: AppHelpers.getTranslation(TrKeys.deliveryman),
                      icon: Remix.car_line,
                      value: orderData.deliveryman?.firstname ?? "- -",
                    )
                  : const SizedBox.shrink(),
              (orderData.myAddress?.location?.address?.isNotEmpty ?? false)
                  ? IconTitle(
                      title: AppHelpers.getTranslation(TrKeys.address),
                      icon: Remix.map_pin_2_line,
                      value: orderData.myAddress?.location?.address ?? "- -",
                    )
                  : const SizedBox.shrink(),
              (orderData.transaction?.status?.isNotEmpty ?? false)
                  ? IconTitle(
                      title: AppHelpers.getTranslation(TrKeys.paymentStatus),
                      icon: Remix.money_dollar_circle_line,
                      value: orderData.transaction?.status ?? "- -",
                    )
                  : const SizedBox.shrink(),
              12.verticalSpace,
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Style.borderColor),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          child: Text(
                            AppHelpers.getTranslation(
                                orderData.deliveryType ?? ""),
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              color: Style.black,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(4),
                        height: 28,
                        width: 28,
                        decoration: BoxDecoration(
                            border: Border.all(color: Style.black),
                            shape: BoxShape.circle),
                        child: (orderData.deliveryType ?? "") == TrKeys.dine
                            ? Padding(
                                padding: const EdgeInsets.all(4),
                                child: SvgPicture.asset(Assets.svgDine))
                            : Icon(
                                (orderData.deliveryType ?? "") ==
                                        TrKeys.delivery
                                    ? Remix.e_bike_2_fill
                                    : Remix.walk_line,
                                size: 16,
                              ),
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
      onTap: () {
        mainNotifier.setOrder(orderData);
      },
    );
  }
}
