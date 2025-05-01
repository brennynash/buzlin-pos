import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remixicon_updated/remixicon_updated.dart';

import 'package:admin_desktop/domain/models/models.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/components/components.dart';
import 'package:admin_desktop/presentation/styles/style.dart';

class ServiceItem extends StatelessWidget {
  final ServiceData service;
  final VoidCallback? onTap;
  final bool booked;
  final int? shopId;

  const ServiceItem({
    super.key,
    required this.service,
    this.onTap,
    this.shopId,
    this.booked = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(),
          16.verticalSpace,
          Row(
            children: [
              Expanded(
                child: Text(
                  service.translation?.title ?? "",
                  style: Style.interNormal(size: 18),
                ),
              ),
              Text(
                service.master?.firstname ?? '',
                style: Style.interNormal(size: 14),
              ),
              4.horizontalSpace,
              Container(
                padding: REdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: Style.black.withOpacity(0.05),
                ),
                child: CommonImage(
                  url: service.master?.img,
                  width: 32,
                  height: 32,
                  radius: 18,
                  errorRadius: 18,
                ),
              ),
            ],
          ),
          8.verticalSpace,
          Wrap(
            spacing: 12,
            runSpacing: 8,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.r),
                    border: Border.all(color: Style.textHint)),
                padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 8.r),
                child: Text(
                  "${AppHelpers.getTranslation(TrKeys.from)} ${AppHelpers.numberFormat(number: service.price)}",
                  style: Style.interNormal(color: Style.textHint, size: 12),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.r),
                    border: Border.all(color: Style.textHint)),
                padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 8.r),
                child: Text(
                  "${service.interval ?? 0} ${AppHelpers.getTranslation(TrKeys.minute)}",
                  style: Style.interNormal(color: Style.textHint, size: 12),
                ),
              ),
              if (service.type != null)
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.r),
                      border: Border.all(color: Style.textHint)),
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.r, vertical: 8.r),
                  child: Text(
                    AppHelpers.getTranslation(service.type ?? ""),
                    style: Style.interNormal(color: Style.textHint, size: 12),
                  ),
                ),
              if (service.gender != null && service.gender != TrKeys.all)
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.r),
                      border: Border.all(color: Style.textHint)),
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.r, vertical: 8.r),
                  child: Text(
                    AppHelpers.getTranslation(service.gender ?? ""),
                    style: Style.interNormal(color: Style.textHint, size: 12),
                  ),
                )
            ],
          ),
          16.verticalSpace,
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppHelpers.getTranslation(TrKeys.price),
                    style: Style.interNormal(color: Style.textHint, size: 14),
                  ),
                  Text(
                    AppHelpers.numberFormat(number: service.totalPrice),
                    style: Style.interNormal(size: 22),
                  )
                ],
              ),
              const Spacer(),
              ButtonEffectAnimation(
                onTap: () {
                  onTap?.call();
                  // if (bookButton) {
                  //   context
                  //       .read<ServiceBloc>()
                  //       .add(ServiceEvent.selectService(service: service));
                  //   return;
                  // }
                  // AppRoute.goServiceListPage(context: context, shopId: shopId);
                },
                child: onTap != null
                    ? Container(
                        width: 36.r,
                        height: 36.r,
                        decoration: BoxDecoration(
                            color: booked ? Style.primary : Style.transparent,
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: booked ? Style.primary : Style.black)),
                        child: Center(
                          child: Icon(
                            booked ? Remix.check_fill : Remix.add_fill,
                            color: booked ? Style.white : Style.black,
                          ),
                        ),
                      )
                    : Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 8.r, horizontal: 16.r),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(color: Style.black)),
                        child: Text(
                          AppHelpers.getTranslation(TrKeys.book),
                          style: Style.interNormal(size: 16),
                        ),
                      ),
              ),
            ],
          ),
          8.verticalSpace,
        ],
      ),
    );
  }
}
