import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remixicon_updated/remixicon_updated.dart';

import '../../../../../../../../../domain/models/models.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import '../../../../../../../components/components.dart';
import '../../../../../../../styles/style.dart';

class LooksItem extends StatelessWidget {
  final LooksData look;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final double spacing;

  const LooksItem({
    super.key,
    required this.look,
    required this.onTap,
    this.spacing = 1,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Style.white,
        borderRadius: BorderRadius.circular(12),
      ),
      margin: EdgeInsets.only(bottom: spacing),
      padding: REdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 56,
            padding: const EdgeInsets.symmetric(vertical: 15),
            decoration: BoxDecoration(
              color: look.active ?? false ? Style.green : Style.red,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
          ),
          12.horizontalSpace,
          CommonImage(
            width: 50,
            height: 52,
            url: look.img,
            errorRadius: 0,
            fit: BoxFit.cover,
          ),
          8.horizontalSpace,
          Expanded(
            child: Text(
              AppHelpers.getTranslation(look.translation?.title ?? ''),
              style: Style.interNormal(
                size: 14,
                letterSpacing: -0.3,
              ),
            ),
          ),
          8.horizontalSpace,
          Row(
            children: [
              CircleButton(
                onTap: onTap,
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
    );
  }
}
