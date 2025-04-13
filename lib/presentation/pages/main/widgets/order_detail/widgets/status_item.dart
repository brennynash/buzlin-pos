import 'package:flutter/material.dart';
import 'package:remixicon_updated/remixicon_updated.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/presentation/styles/style.dart';

class StatusItemPage extends StatelessWidget {
  final String title;
  final String index;
  final bool isDivider;
  final bool isActive;
  final bool isOldStatus;

  const StatusItemPage(
      {super.key,
      required this.title,
      this.isDivider = true,
      this.isActive = false,
      this.isOldStatus = false,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: isActive ? Style.primary : Style.white,
            shape: BoxShape.circle,
            border: Border.all(
                color: isActive || isOldStatus
                    ? Style.primary
                    : Style.borderColor),
          ),
          padding: EdgeInsets.all(8.r),
          child: isOldStatus
              ? const Icon(
                  Remix.check_line,
                  color: Style.primary,
                )
              : Padding(
                  padding: EdgeInsets.all(8.r),
                  child: Text(
                    index,
                    style:
                        TextStyle(color: isActive ? Style.white : Style.black),
                  ),
                ),
        ),
        8.horizontalSpace,
        Text(
          title,
          style: GoogleFonts.inter(
              fontSize: 20.sp,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.normal),
        ),
        8.horizontalSpace,
        isDivider
            ? Expanded(
                child: Divider(
                  color: isOldStatus ? Style.primary : Style.borderColor,
                ),
              )
            : const SizedBox.shrink(),
        8.horizontalSpace,
      ],
    );
  }
}
