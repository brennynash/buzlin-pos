import 'package:admin_desktop/app_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:admin_desktop/domain/models/models.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import '../../../../../../../components/components.dart';
import '../../../../../../../styles/style.dart';
import 'membership_details_modal.dart';

class UserMembershipItem extends StatelessWidget {
  final UserMembershipData membership;
  final int spacing;

  const UserMembershipItem({
    super.key,
    required this.membership,
    this.spacing = 10,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppHelpers.showAlertDialog(
          context: context,
          child: SizedBox(
              height: 0.67.sh,
              width: 0.5.sw,
              child: MembershipDetailsModal(userMembership: membership)),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Style.white,
          borderRadius: BorderRadius.circular((AppConstants.radius / 1.4).r),
        ),
        margin: EdgeInsets.only(bottom: spacing.r),
        padding: REdgeInsets.symmetric(vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                Container(
                  width: 4.r,
                  height: 56.r,
                  padding: REdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                      color: membership.memberShip?.color ?? Style.primary,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10.r),
                        bottomRight: Radius.circular(10.r),
                      )),
                ),
                8.horizontalSpace,
                CommonImage(
                  height: 48.r,
                  width: 48.r,
                  radius: AppConstants.radius,
                  url: membership.user?.img,
                ),
                8.horizontalSpace,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        membership.user?.firstname ??
                            AppHelpers.getTranslation(TrKeys.unKnow),
                        style: Style.interNormal(size: 14),
                      ),
                      Text(
                        membership.memberShip?.translation?.title ??
                            AppHelpers.getTranslation(TrKeys.unKnow),
                        style: Style.interNormal(size: 12),
                      ),
                      4.verticalSpace,
                      Text(
                        "${AppHelpers.numberFormat(number: membership.price)} (${membership.memberShip?.time ?? ''})",
                        style: Style.interRegular(size: 12),
                      )
                    ],
                  ),
                ),
                StatusButton(
                    status: membership.transaction?.status ?? TrKeys.notePaid),
                // 8.horizontalSpace,
              ],
            ),
          ],
        ),
      ),
    );
  }
}
