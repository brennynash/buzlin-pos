import 'package:flutter/material.dart';
import 'package:remixicon_updated/remixicon_updated.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import 'package:intl/intl.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/components/components.dart';

class StartEndDate extends StatelessWidget {
  final DateTime? start;
  final DateTime? end;
  final Widget? filterScreen;

  const StartEndDate({super.key, this.start, this.end, this.filterScreen});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        AppHelpers.showAlertDialog(
            context: context,
            child: SizedBox(
                width: MediaQuery.sizeOf(context).width / 3,
                child: filterScreen));
      },
      child: ButtonEffectAnimation(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          decoration: BoxDecoration(
            color: Style.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Style.unselectedBottomBarBack,
              width: 1.r,
            ),
          ),
          child: Row(
            children: [
              const Icon(Remix.calendar_check_line),
              16.horizontalSpace,
              Text(
                start == null
                    ? AppHelpers.getTranslation(TrKeys.startEnd)
                    : "${DateFormat("MMM d,yyyy").format(start ?? DateTime.now())} - ${DateFormat("MMM d,yyyy").format(end ?? DateTime.now())}",
                style: GoogleFonts.inter(fontSize: 14),
              )
            ],
          ),
        ),
      ),
    );
  }
}
