import 'package:admin_desktop/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remixicon_updated/remixicon_updated.dart';
import 'package:admin_desktop/domain/models/models.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import '../../../../../../../components/components.dart';
import '../../../../../../../styles/style.dart';

class MembershipItem extends StatelessWidget {
  final MembershipData membership;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final int spacing;

  const MembershipItem({
    super.key,
    required this.membership,
    required this.onEdit,
    this.spacing = 10,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                width: 6.r,
                height: 56.r,
                padding: REdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                    color: membership.color ?? Style.primary,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10.r),
                      bottomRight: Radius.circular(10.r),
                    )),
              ),
              12.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      membership.translation?.title ??
                          AppHelpers.getTranslation(TrKeys.unKnow),
                      style: Style.interNormal(),
                    ),
                    4.verticalSpace,
                    Text(
                      "${AppHelpers.numberFormat(number: membership.price)} (${membership.time ?? ''})",
                      style: Style.interRegular(size: 14),
                    )
                  ],
                ),
              ),
              8.horizontalSpace,
              Row(
                children: [
                  CircleButton(
                    onTap: onEdit,
                    icon: Remix.pencil_line,
                  ),
                  8.horizontalSpace,
                  CircleButton(
                    onTap: onDelete,
                    icon: Remix.delete_bin_line,
                  ),
                ],
              ),
              12.horizontalSpace,
            ],
          ),
        ],
      ),
    );
  }
}
