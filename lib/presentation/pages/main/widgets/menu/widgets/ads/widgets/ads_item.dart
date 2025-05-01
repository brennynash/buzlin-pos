import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/domain/models/models.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/components/components.dart';
import '../../../../../../../styles/style.dart';

class AdsItem extends StatelessWidget {
  final AdsData ads;
  final VoidCallback purchase;

  const AdsItem({super.key, required this.ads, required this.purchase});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: Style.white,
      ),
      padding: REdgeInsets.symmetric(vertical: 10),
      margin: REdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          StatusIndicator(status: ads.status),
          6.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${AppHelpers.getTranslation(TrKeys.package)} : ${ads.adsPackage?.translation?.title ?? ''}",
                  style: Style.interNormal(size: 14),
                ),
                2.verticalSpace,
                Text(
                  "${AppHelpers.getTranslation(TrKeys.expireAt)} : ${TimeService.dateFormatForNotification(ads.transaction?.performTime)}",
                  style: Style.interNormal(size: 13, color: Style.textColor),
                ),
              ],
            ),
          ),
          LoginButton(
              titleColor: Style.white,
              bgColor: ads.transaction?.status != TrKeys.paid
                  ? Style.primary
                  : Style.green,
              //isActive: ads.transaction?.status != TrKeys.paid,
              title: ads.transaction?.status != TrKeys.paid
                  ? TrKeys.purchase
                  : TrKeys.paid,
              onPressed: purchase),
          12.horizontalSpace,
        ],
      ),
    );
  }
}
