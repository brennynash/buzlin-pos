import 'package:admin_desktop/domain/models/models.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/components/buttons/custom_button.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/application/providers.dart';
import 'package:admin_desktop/presentation/components/login_button.dart';
import 'closed_date_modal.dart';
import 'disable_times_modal.dart';

class MastersWorkingTime extends ConsumerWidget {
  const MastersWorkingTime({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final editMasterState = ref.watch(editMastersProvider);
    final notifier = ref.read(masterWorkingDaysProvider.notifier);
    final demoWorkingDay = [
      'monday',
      'tuesday',
      'wednesday',
      'thursday',
      'friday',
      'saturday',
      'sunday'
    ];
    List<WorkingDay> workingDays = editMasterState.master?.workingDays ??
        [
          for (int i = 0; i < demoWorkingDay.length; i++)
            WorkingDay(
              day: demoWorkingDay[i],
              from: "00:00",
              to: "00:00",
              disabled: true,
            )
        ];

    void setTimeToDay({
      required TimeOfDay time,
      bool isFrom = true,
      required int currentIndex,
    }) {
      if (isFrom) {
        workingDays[currentIndex] = workingDays[currentIndex].copyWith(
          from:
              '${time.hour.toString().padLeft(2, '0')}-${time.minute.toString().padLeft(2, '0')}',
        );
      } else {
        workingDays[currentIndex] = workingDays[currentIndex].copyWith(
          to: '${time.hour.toString().padLeft(2, '0')}-${time.minute.toString().padLeft(2, '0')}',
        );
      }
    }

    return Row(
      children: [
        Expanded(
          flex: 2,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                18.verticalSpace,
                const Divider(),
                18.verticalSpace,
                Text(
                  AppHelpers.getTranslation(TrKeys.workingHours),
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600, fontSize: 22),
                ),
                18.verticalSpace,
                if (editMasterState.master?.workingDays?.isNotEmpty ?? false)
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Style.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        width: 1.r,
                        style: BorderStyle.solid,
                        color: Style.borderColor,
                      ),
                    ),
                    child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: editMasterState.master?.workingDays?.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              12.verticalSpace,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: AutoSizeText(
                                      AppHelpers.getTranslation(
                                          workingDays[index].day ?? ""),
                                      style: Style.interNormal(size: 18),
                                      maxLines: 1,
                                      minFontSize: 16,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  workingDays[index].disabled ?? false
                                      ? Text(
                                          AppHelpers.getTranslation(
                                              TrKeys.shopClosed),
                                          style: Style.interNormal(size: 18),
                                        )
                                      : Row(
                                          children: [
                                            SizedBox(
                                              height: 36.r,
                                              width: 150.w,
                                              child: CupertinoDatePicker(
                                                itemExtent: 156.w,
                                                key: UniqueKey(),
                                                mode: CupertinoDatePickerMode.time,
                                                initialDateTime: DateTime(
                                                  2022,
                                                  1,
                                                  1,
                                                  int.tryParse(
                                                          workingDays[index]
                                                                  .from
                                                                  ?.substring(
                                                                      0, 2) ??
                                                              '') ??
                                                      0,
                                                  int.tryParse(
                                                          workingDays[index]
                                                                  .from
                                                                  ?.substring(
                                                                      3, 5) ??
                                                              '') ??
                                                      0,
                                                ),
                                                onDateTimeChanged:
                                                    (DateTime newDateTime) {
                                                  setTimeToDay(
                                                    time:
                                                        TimeOfDay.fromDateTime(
                                                            newDateTime),
                                                    currentIndex: index,
                                                  );
                                                },
                                                use24hFormat: AppHelpers.getHourFormat24(),
                                                minuteInterval: 5,
                                              ),
                                            ),
                                            12.horizontalSpace,
                                            SizedBox(
                                              height: 36.r,
                                              width: 150.w,
                                              child: CupertinoDatePicker(
                                                itemExtent: 156.w,
                                                key: UniqueKey(),
                                                mode: CupertinoDatePickerMode
                                                    .time,
                                                initialDateTime: DateTime(
                                                  2022,
                                                  1,
                                                  1,
                                                  int.parse(workingDays[index]
                                                          .to
                                                          ?.substring(0, 2) ??
                                                      ''),
                                                  int.parse(workingDays[index]
                                                          .to
                                                          ?.substring(3, 5) ??
                                                      ''),
                                                ),
                                                onDateTimeChanged:
                                                    (DateTime newDateTime) {
                                                  setTimeToDay(
                                                      time: TimeOfDay
                                                          .fromDateTime(
                                                              newDateTime),
                                                      currentIndex: index,
                                                      isFrom: false);
                                                },
                                                use24hFormat: AppHelpers.getHourFormat24(),
                                                minuteInterval: 5,
                                              ),
                                            ),
                                          ],
                                        ),
                                  12.horizontalSpace,
                                  CupertinoSwitch(
                                      activeColor: Style.primary,
                                      value:
                                          workingDays[index].disabled ?? false,
                                      onChanged: (s) {
                                        ref
                                            .read(editMastersProvider.notifier)
                                            .setCloseDay(index);
                                      })
                                ],
                              ),
                              12.verticalSpace,
                              if (index < (workingDays.length) - 1)
                                const Divider(),
                            ],
                          );
                        }),
                  ),
                32.verticalSpace,
                SizedBox(
                  width: 250.w,
                  child: LoginButton(
                      isLoading: editMasterState.isLoading,
                      title: AppHelpers.getTranslation(TrKeys.save),
                      onPressed: () async {
                        notifier.updateWorkingDays(
                          days: editMasterState.master?.workingDays ?? [],
                          id: editMasterState.master?.id,
                          // updateSuccess: () {
                          //   masterNotifier.updateWorkingDays(_savingWorkingDays);
                          //   widget.onNext?.call();
                          // },
                        );
                      }),
                ),
                32.verticalSpace,
              ],
            ),
          ),
        ),
        12.horizontalSpace,
        Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButton(
                  bgColor: Style.white,
                  title: AppHelpers.getTranslation(TrKeys.closedDays),
                  textColor: Style.primary,
                  onTap: () {
                    AppHelpers.showAlertDialog(
                        context: context,
                        child: SizedBox(
                            height: MediaQuery.sizeOf(context).height / 1.5,
                            width: MediaQuery.sizeOf(context).width / 2,
                            child: const ClosedDateModal()));
                  },
                ),
                CustomButton(
                  bgColor: Style.white,
                  title: AppHelpers.getTranslation(TrKeys.disableTimes),
                  textColor: Style.primary,
                  onTap: () {
                    AppHelpers.showAlertDialog(
                        context: context,
                        backgroundColor: Style.bg,
                        child: SizedBox(
                            height: MediaQuery.sizeOf(context).height / 1.5,
                            width: MediaQuery.sizeOf(context).width / 2,
                            child: const DisableTimesModal()));
                  },
                ),
              ],
            ))
      ],
    );
  }
}
