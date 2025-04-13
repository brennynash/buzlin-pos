import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import '../../../../../../../../../domain/models/models.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import '../../../../../../../components/components.dart';
import '../../../../../../../styles/style.dart';

class DeliverymanItem extends StatelessWidget {
  final UserData user;
  final ValueChanged<String> onTap;

  const DeliverymanItem({
    super.key,
    required this.user,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final status = user.invitations
            ?.where((element) => element.shopId == LocalStorage.getShop()?.id)
            .last
            .status ??
        TrKeys.unKnow;
    return Container(
      margin: REdgeInsets.only(bottom: 8),
      width: double.infinity,
      height: 124.r,
      decoration: BoxDecoration(
        color: Style.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            margin: REdgeInsets.symmetric(vertical: 10),
            decoration: ShapeDecoration(
              color: (user.invitations?.isNotEmpty ?? false)
                  ? AppHelpers.getStatusColor(status)
                  : Style.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10.r),
                  bottomRight: Radius.circular(10.r),
                ),
              ),
            ),
          ),
          12.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    CommonImage(
                      url: user.img,
                      width: 48,
                      height: 48,
                      radius: 14,
                      errorRadius: 14,
                    ),
                    10.horizontalSpace,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AutoSizeText(
                            '${user.firstname} ${user.lastname ?? ''}',
                            style: Style.interSemi(size: 16.sp),
                            maxLines: 1,
                          ),
                          4.verticalSpace,
                          Text(
                            user.phone ?? '',
                            style: Style.interNormal(
                                size: 16.sp, color: Style.textColor),
                          ),
                          const Divider(height: 4),
                        ],
                      ),
                    ),
                    16.horizontalSpace,
                    if (status.isNotEmpty)
                      StatusButton(
                        status: status,
                        onTap: () => onTap(status),
                      ),
                    if (status.isNotEmpty) 24.horizontalSpace,
                  ],
                ),
                4.verticalSpace,
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            AppHelpers.getTranslation(TrKeys.email),
                            style: Style.interNormal(
                              size: 16.sp,
                              color: Style.textColor,
                            ),
                          ),
                          2.verticalSpace,
                          Text(
                            user.email ?? '',
                            style: Style.interNormal(size: 16.sp),
                          ),
                        ],
                      ),
                    ),
                    12.horizontalSpace,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          AppHelpers.getTranslation(TrKeys.gender),
                          style: Style.interNormal(
                            size: 16.sp,
                            color: Style.textColor,
                          ),
                        ),
                        2.verticalSpace,
                        Text(
                          AppHelpers.getTranslation(user.gender ?? ""),
                          style: Style.interNormal(size: 16.sp),
                        ),
                      ],
                    ),
                    24.horizontalSpace,
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
