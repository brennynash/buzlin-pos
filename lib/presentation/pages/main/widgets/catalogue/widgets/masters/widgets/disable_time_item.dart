import 'package:admin_desktop/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:remixicon_updated/remixicon_updated.dart';

import '../../../../../../../../infrastructure/services/time_service.dart';
import 'package:admin_desktop/domain/models/models.dart';
import '../../../../../../../components/components.dart';
import '../../../../../../../styles/style.dart';

class DisableTimeItem extends StatelessWidget {
  final DisableTimes disableTime;
  final VoidCallback onDelete;
  final VoidCallback onTap;

  const DisableTimeItem({
    super.key,
    required this.disableTime,
    required this.onDelete,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.only(bottom: 8),
      child: Slidable(
        endActionPane: ActionPane(
          extentRatio: 0.12,
          motion: const ScrollMotion(),
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  onDelete.call();
                  Slidable.of(context)?.close();
                },
                child: Container(
                  width: 50.r,
                  height: 72.r,
                  decoration: BoxDecoration(
                    color: Style.red,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(AppConstants.radius.r),
                      bottomLeft: Radius.circular(AppConstants.radius.r),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    Remix.delete_bin_line,
                    color: Style.white,
                    size: 21.r,
                  ),
                ),
              ),
            ),
          ],
        ),
        child: Padding(
          padding: REdgeInsets.symmetric(horizontal: 16),
          child: ButtonEffectAnimation(
            onTap: onTap,
            child: Container(
              padding: REdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Style.greyColor,
                borderRadius: BorderRadius.circular(AppConstants.radius / 1.4),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      disableTime.translation?.title ?? '',
                    ),
                  ),
                  Text(
                    "${TimeService.dateFormatDM(disableTime.date)} ${disableTime.from ?? ''}-${disableTime.to ?? ''}",
                    style: Style.interNormal(size: 14),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
