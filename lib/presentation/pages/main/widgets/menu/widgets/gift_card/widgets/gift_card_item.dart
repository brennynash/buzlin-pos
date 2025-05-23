import 'package:admin_desktop/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remixicon_updated/remixicon_updated.dart';
import '../../../../../../../../domain/models/data/gift_card_data.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import '../../../../../../../components/buttons/circle_button.dart';
import '../../../../../../../styles/style.dart';

class GiftCardItem extends StatelessWidget {
  final GiftCardData giftCard;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final int spacing;

  const GiftCardItem({
    super.key,
    required this.giftCard,
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
              8.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(giftCard.translation?.title ??
                        AppHelpers.getTranslation(TrKeys.unKnow)),
                    4.verticalSpace,
                    Text(
                      "${AppHelpers.numberFormat(number: giftCard.price)} (${giftCard.time ?? ''})",
                      style: Style.interRegular(size: 12),
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
