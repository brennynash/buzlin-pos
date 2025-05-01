import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../../../../domain/models/models.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import '../../../../../../../components/components.dart';
import '../../../../../../../styles/style.dart';

class AdsPackagesItem extends StatelessWidget {
  final AdsPackage ads;
  final VoidCallback assign;

  const AdsPackagesItem({super.key, required this.ads, required this.assign});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: Style.white,
      ),
      padding: REdgeInsets.symmetric(vertical: 6),
      margin: REdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          6.horizontalSpace,
          CommonImage(
            height: 52,
            width: 52,
            url: ads.galleries?.isNotEmpty ?? false
                ? ads.galleries?.first.path
                : null,
          ),
          8.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ads.translation?.title ?? '',
                  style: Style.interNormal(size: 14),
                ),
                Text(
                  "${AppHelpers.numberFormat(number: ads.price)}  (${ads.time} ${ads.timeType})",
                  style: Style.interRegular(size: 14),
                ),
              ],
            ),
          ),
          CustomButton(
              bgColor: Style.primary,
              textColor: Style.white,
              title: TrKeys.assign,
              onTap: assign),
          12.horizontalSpace,
        ],
      ),
    );
  }
}
