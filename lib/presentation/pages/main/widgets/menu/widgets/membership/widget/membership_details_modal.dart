import 'package:admin_desktop/presentation/components/header_item.dart';
import 'package:admin_desktop/presentation/components/list_items/custom_detail_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/domain/models/models.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';

class MembershipDetailsModal extends StatelessWidget {
  final UserMembershipData userMembership;

  const MembershipDetailsModal({super.key, required this.userMembership});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const HeaderItem(title: TrKeys.membershipDetails),
          CustomDetailItem(
            title: TrKeys.id,
            value: "#${userMembership.id ?? 0}",
          ),
          CustomDetailItem(
            title: TrKeys.fullName,
            value:
                "${userMembership.user?.firstname ?? TrKeys.deletedUser} ${userMembership.user?.lastname ?? ''}",
          ),
          CustomDetailItem(
            title: TrKeys.purchase,
            value: TimeService.dateFormatDMY(userMembership.createdAt),
          ),
          CustomDetailItem(
            title: TrKeys.time,
            value: "${userMembership.memberShip?.time ?? 0}",
          ),
          CustomDetailItem(
            title: TrKeys.expiredAt,
            value: TimeService.dateFormatDMY(userMembership.expiredAt),
          ),
          CustomDetailItem(
            title: TrKeys.membership,
            value: userMembership.memberShip?.translation?.title ?? '',
          ),
          CustomDetailItem(
            title: TrKeys.sessions,
            value: "${userMembership.memberShip?.sessions ?? 0}",
          ),
          CustomDetailItem(
            title: TrKeys.sessionsCount,
            value: "${userMembership.memberShip?.sessionsCount ?? 0}",
          ),
          CustomDetailItem(
            title: TrKeys.price,
            value: AppHelpers.numberFormat(
                number: userMembership.memberShip?.price),
          ),
          CustomDetailItem(
            title: TrKeys.transactionStatus,
            value: AppHelpers.getTranslation(
                userMembership.transaction?.status ?? TrKeys.notePaid),
          ),
          28.verticalSpace,
        ],
      ),
    );
  }
}
