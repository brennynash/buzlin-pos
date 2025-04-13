import 'package:admin_desktop/app_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import '../../../../../../../domain/models/data/activity_data.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/styles/style.dart';

class ActivityItem extends StatelessWidget {
  final ActivityData? activity;

  const ActivityItem({super.key, required this.activity});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      margin: REdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
          color: Style.white,
          borderRadius: BorderRadius.circular(AppConstants.radius / 1.2)),
      child: Row(
        children: [
          Container(
            width: 4,
            margin: REdgeInsets.symmetric(vertical: 12),
            decoration: ShapeDecoration(
              color: AppHelpers.getStatusColor(activity?.type),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10.r),
                  bottomRight: Radius.circular(10.r),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: REdgeInsets.symmetric(vertical: 12, horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    activity?.note ?? '',
                    style: Style.interNormal(size: 15),
                  ),
                  Text(
                    TimeService.dateFormatMDYHm(activity?.updatedAt),
                    style: Style.interNormal(size: 14, color: Style.textHint),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
