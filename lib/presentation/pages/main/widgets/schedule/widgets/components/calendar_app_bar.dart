import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CalendarAppBar extends StatelessWidget {
  final VoidCallback? onFilterTap;
  final VoidCallback? onTipTap;
  final AsyncCallback? onTitleTapped;
  final DateTime startDate;
  final bool? isFilter;
  final CalendarType calendarType;
  final DateTime? endDate;

  final Color iconColor;

  const CalendarAppBar({
    super.key,
    required this.startDate,
    this.onFilterTap,
    this.onTitleTapped,
    this.onTipTap,
    this.endDate,
    this.iconColor = Style.black,
    required this.calendarType,
    this.isFilter,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Style.white),
      clipBehavior: Clip.antiAlias,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // IconButton(
          //   onPressed: onTipTap,
          //   splashColor: Style.transparent,
          //   focusColor: Style.transparent,
          //   hoverColor: Style.transparent,
          //   highlightColor: Style.transparent,
          //   icon: Icon(
          //     Icons.more_vert,
          //     size: 21.r,
          //     color: iconColor,
          //   ),
          // ),
          InkWell(
            onTap: onTitleTapped,
            child: Text(
              calendarType == CalendarType.day
                  ? TimeService.dateFormatEDMY(startDate)
                  : TimeService.dateFormatMulti([startDate, endDate]),
              textAlign: TextAlign.center,
            ),
          ),
          // IconButton(
          //   onPressed: onFilterTap,
          //   splashColor: Style.transparent,
          //   focusColor: Style.transparent,
          //   hoverColor: Style.transparent,
          //   highlightColor: Style.transparent,
          //   icon: Icon(Remix.sound_module_line,
          //       size: 21.r, color: iconColor),
          // ),
          // 8.horizontalSpace,
        ],
      ),
    );
  }
}
