import 'package:admin_desktop/presentation/assets.dart';
import 'package:flutter/material.dart';
import 'package:remixicon_updated/remixicon_updated.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import 'package:admin_desktop/domain/models/models.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/components/components.dart';

class DocumentScreen extends StatelessWidget {
  final OrderData? order;

  const DocumentScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Style.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Style.borderColor),
      ),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${AppHelpers.getTranslation(TrKeys.order)} #${AppHelpers.getTranslation(TrKeys.id).toUpperCase()}${order?.id}",
                    style: Style.interMedium(size: 20),
                  ),
                  2.verticalSpace,
                  Text(
                    TimeService.dateFormatMDYHm(order?.createdAt?.toLocal()),
                    style: Style.interNormal(color: Style.hint),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    AppHelpers.getTranslation(TrKeys.orderType),
                    style: Style.interMedium(size: 16),
                  ),
                  2.verticalSpace,
                  Text(
                    AppHelpers.getTranslation(
                        order?.type == 2 ? TrKeys.ownSeller : TrKeys.warehouse),
                    style: Style.interNormal(color: Style.hint, size: 14),
                  ),
                ],
              ),
            ],
          ),
          12.verticalSpace,
          Row(
            children: [
              Expanded(
                child: OutlinedBorderTextField(
                  readOnly: true,
                  label: null,
                  textController: TextEditingController(
                      text:
                          "${order?.user?.firstname ?? ""} ${order?.user?.lastname ?? ""}"),
                  suffixIcon: const Icon(Remix.arrow_down_s_line),
                ),
              ),
              32.horizontalSpace,
              Expanded(
                child: OutlinedBorderTextField(
                  readOnly: true,
                  textController: TextEditingController(
                      text: order?.myAddress?.location?.address ??
                          order?.deliveryPoint?.address?.address ??
                          ''),
                  label: null,
                  suffixIcon: const Icon(Remix.arrow_down_s_line),
                ),
              ),
            ],
          ),
          12.verticalSpace,
          Row(
            children: [
              Expanded(
                child: OutlinedBorderTextField(
                  readOnly: true,
                  textController: TextEditingController(
                      text:
                          "${order?.currency?.title ?? ""} (${order?.currency?.symbol ?? ""})"),
                  label: null,
                  suffixIcon: const Icon(Remix.arrow_down_s_line),
                ),
              ),
              32.horizontalSpace,
              Expanded(
                child: OutlinedBorderTextField(
                  readOnly: true,
                  textController: TextEditingController(
                      text: AppHelpers.getTranslation(
                          order?.transaction?.paymentSystem?.tag ?? "")),
                  label: null,
                  suffixIcon: const Icon(Remix.arrow_down_s_line),
                ),
              ),
            ],
          ),
          8.verticalSpace,
          const Divider(),
          8.verticalSpace,
          Text(
            AppHelpers.getTranslation(TrKeys.shippingInformation),
            style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 18),
          ),
          16.verticalSpace,
          _shippingType(),
          16.verticalSpace,
          Row(
            children: [
              Expanded(
                child: OutlinedBorderTextField(
                  readOnly: true,
                  textController: TextEditingController(
                      text: TimeService.dateFormat(order?.deliveryDate)),
                  label: null,
                  suffixIcon: const Icon(Remix.arrow_down_s_line),
                ),
              ),
              32.horizontalSpace,
              Expanded(
                child: OutlinedBorderTextField(
                  readOnly: true,
                  textController: TextEditingController(
                    text: TimeService.timeFormat(order?.deliveryDate),
                  ),
                  label: null,
                  suffixIcon: const Icon(Remix.arrow_down_s_line),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Row _shippingType() {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: order?.deliveryType == TrKeys.delivery
                  ? Style.primary
                  : Style.editProfileCircle,
              borderRadius: BorderRadius.circular(6),
            ),
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Style.transparent,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: order?.deliveryType == TrKeys.delivery
                            ? Style.white
                            : Style.black,
                      ),
                    ),
                    padding: const EdgeInsets.all(6),
                    child: Icon(
                      Remix.takeaway_fill,
                      size: 18,
                      color: order?.deliveryType == TrKeys.delivery
                          ? Style.white
                          : Style.black,
                    ),
                  ),
                  8.horizontalSpace,
                  Text(
                    AppHelpers.getTranslation(TrKeys.delivery),
                    style: Style.interMedium(
                      size: 14,
                      color: order?.deliveryType == TrKeys.delivery
                          ? Style.white
                          : Style.black,
                      letterSpacing: 0.4,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        12.horizontalSpace,
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: order?.deliveryType == TrKeys.pickup
                  ? Style.primary
                  : Style.editProfileCircle,
              borderRadius: BorderRadius.circular(6),
            ),
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Style.transparent,
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: order?.deliveryType == TrKeys.pickup
                              ? Style.white
                              : Style.black),
                    ),
                    padding: const EdgeInsets.all(6),
                    child: SvgPicture.asset(Assets.svgPickup,
                        colorFilter: ColorFilter.mode(
                            order?.deliveryType == TrKeys.pickup
                                ? Style.white
                                : Style.black,
                            BlendMode.srcIn)),
                  ),
                  8.horizontalSpace,
                  Text(
                    AppHelpers.getTranslation(TrKeys.takeAway),
                    style: Style.interMedium(
                      size: 14,
                      color: order?.deliveryType == TrKeys.pickup
                          ? Style.white
                          : Style.black,
                      letterSpacing: 0.4,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        12.horizontalSpace,
      ],
    );
  }
}
