import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import '../styles/style.dart';
import 'components.dart';

class TimePickerModal extends StatefulWidget {
  final Function(DateTime) onSaved;
  final String? openTime;
  final String? closeTime;

  const TimePickerModal({
    super.key,
    required this.onSaved,
    this.openTime,
    this.closeTime,
  });

  @override
  State<TimePickerModal> createState() => _TimePickerModalState();
}

class _TimePickerModalState extends State<TimePickerModal> {
  DateTime time = DateTime.now();

  @override
  void initState() {
    super.initState();
    time = widget.openTime == null
        ? DateTime.now()
        : AppHelpers.getMinTime(widget.openTime!);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Style.white,
      borderRadius: BorderRadius.circular(10.r),
      child: Padding(
        padding: REdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            24.verticalSpace,
            SizedBox(
              height: 300.r,
              child: CupertinoTheme(
                data: const CupertinoThemeData(
                  brightness: Brightness.light,
                ),
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.time,
                  minimumDate: widget.openTime == null
                      ? DateTime.now()
                      : AppHelpers.getMinTime(widget.openTime!),
                  maximumDate: widget.closeTime == null
                      ? null
                      : AppHelpers.getMaxTime(widget.closeTime!),
                  use24hFormat: AppHelpers.getHourFormat24(),
                  initialDateTime: widget.openTime == null
                      ? DateTime.now()
                      : AppHelpers.getMinTime(widget.openTime!),
                  onDateTimeChanged: (DateTime value) {
                    time = value;
                  },
                ),
              ),
            ),
            16.verticalSpace,
            ConfirmButton(
              title: AppHelpers.getTranslation(TrKeys.save),
              onTap: () {
                widget.onSaved(time);
                context.maybePop();
              },
            ),
            24.verticalSpace,
          ],
        ),
      ),
    );
  }
}
