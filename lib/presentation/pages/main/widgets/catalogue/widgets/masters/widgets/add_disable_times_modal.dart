import 'package:admin_desktop/presentation/components/components.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/cupertino.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import 'package:remixicon_updated/remixicon_updated.dart';
import 'package:admin_desktop/application/masters/disable_times/disable_times_provider.dart';
import 'package:admin_desktop/application/masters/edit/edit_masters_provider.dart';
import 'package:admin_desktop/application/masters/working_days/working_days_provider.dart';
import 'package:admin_desktop/infrastructure/constants/constants.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';

class AddDisableTimesModal extends ConsumerStatefulWidget {
  const AddDisableTimesModal({super.key});

  @override
  ConsumerState<AddDisableTimesModal> createState() =>
      _AddDisableTimesModalState();
}

class _AddDisableTimesModalState extends ConsumerState<AddDisableTimesModal> {
  late TextEditingController title;
  late TextEditingController desc;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    title = TextEditingController();
    desc = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(masterDisableTimesProvider.notifier).clearAll();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(masterDisableTimesProvider);
    final notifier = ref.read(masterDisableTimesProvider.notifier);
    return Padding(
      padding: REdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Expanded(
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Text(
                          AppHelpers.getTranslation(TrKeys.addDisableTime),
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.w600,
                              fontSize: 22,
                              color: Style.black),
                        ),
                        const Spacer(),
                        IconButton(
                            onPressed: () {
                               context.maybePop();
                            },
                            icon: const Icon(Remix.close_fill))
                      ],
                    ),
                    12.verticalSpace,
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedBorderTextField(
                            textController: title,
                            label: TrKeys.title,
                            validator: AppValidators.emptyCheck,
                            textCapitalization: TextCapitalization.sentences,
                          ),
                        ),
                        12.horizontalSpace,
                        Expanded(
                          child: OutlinedBorderTextField(
                            textController: desc,
                            label: TrKeys.description,
                            textCapitalization: TextCapitalization.sentences,
                          ),
                        ),
                      ],
                    ),
                    12.verticalSpace,
                    Row(
                      children: [
                        Expanded(
                          child: CustomDateTimeField(
                            onDateChange: notifier.setDateTime,
                            label: TrKeys.date,
                            mode: CupertinoDatePickerMode.date,
                            minTime: DateTime.now(),
                            validation: AppValidators.emptyCheck,
                          ),
                        ),
                        12.horizontalSpace,
                        Expanded(
                          child: OutlineDropDown(
                            label: TrKeys.repeats,
                            value: state.disableTime?.repeats,
                            list: DropDownValues.repeatsList,
                            onChanged: notifier.setRepeats,
                          ),
                        ),
                      ],
                    ),
                    12.verticalSpace,
                    Row(
                      children: [
                        Expanded(
                          child: CustomDateTimeField(
                            label: TrKeys.from,
                            onTimeChange: notifier.setTimeFrom,
                            validation: AppValidators.emptyCheck,
                            minTime: DateTime.now(),
                          ),
                        ),
                        12.horizontalSpace,
                        Expanded(
                          child: CustomDateTimeField(
                            label: TrKeys.to,
                            onTimeChange: notifier.setTimeTo,
                            validation: AppValidators.emptyCheck,
                            minTime: state.disableTime?.from?.toTime() ??
                                DateTime.now().addMinute(5),
                          ),
                        ),
                      ],
                    ),
                    12.verticalSpace,
                    if (state.disableTime?.repeats == 'custom')
                      Padding(
                        padding: REdgeInsets.only(top: 12),
                        child: Row(
                          children: [
                            Expanded(
                              child: OutlinedBorderTextField(
                                label: TrKeys.value,
                                onChanged: notifier.setCustomRepeatValue,
                                validator: AppValidators.emptyCheck,
                              ),
                            ),
                            12.horizontalSpace,
                            Expanded(
                              child: OutlineDropDown(
                                label: TrKeys.type,
                                value: state.disableTime?.customRepeatType,
                                list: DropDownValues.customRepeatType,
                                onChanged: notifier.setCustomRepeatType,
                              ),
                            ),
                          ],
                        ),
                      ),
                    12.verticalSpace,
                    OutlineDropDown(
                      label: TrKeys.endType,
                      value: state.disableTime?.endType,
                      list: DropDownValues.endTypeList,
                      onChanged: notifier.setEndType,
                    ),
                    if (state.disableTime?.endType == 'after')
                      Padding(
                        padding: REdgeInsets.only(top: 12),
                        child: OutlinedBorderTextField(
                          label: TrKeys.value,
                          validator: AppValidators.emptyCheck,
                          onChanged: notifier.setEndValue,
                        ),
                      ),
                    if (state.disableTime?.endType == 'date')
                      Padding(
                        padding: REdgeInsets.only(top: 12),
                        child: CustomDateTimeField(
                          onDateChange: notifier.setEndDate,
                          label: TrKeys.endDate,
                          mode: CupertinoDatePickerMode.date,
                          minTime: state.disableTime?.date ?? DateTime.now(),
                          validation: AppValidators.emptyCheck,
                        ),
                      ),
                    24.verticalSpace,
                    CustomButton(
                      title: TrKeys.save,
                      isLoading: state.isUpdate,
                      onTap: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          notifier.addDisableTimes(
                            createdSuccess: () {
                              ref
                                  .read(masterWorkingDaysProvider.notifier)
                                  .getDisableTimes(context,
                                      isRefresh: true,
                                      idMaster: ref
                                          .read(editMastersProvider)
                                          .masterData
                                          ?.id);
                               context.maybePop();
                            },
                            title: title.text,
                            desc: desc.text,
                          );
                        }
                      },
                    ),
                    MediaQuery.viewInsetsOf(context).bottom.verticalSpace,
                    24.verticalSpace,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
