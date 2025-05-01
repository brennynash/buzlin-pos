import 'package:admin_desktop/infrastructure/constants/constants.dart';
import 'package:admin_desktop/presentation/components/components.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/cupertino.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import 'package:remixicon_updated/remixicon_updated.dart';

import 'package:admin_desktop/application/providers.dart';
import 'package:admin_desktop/domain/models/models.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';

class EditDisableTimesModal extends ConsumerStatefulWidget {
  final DisableTimes? disableTime;
  final ScrollController? scrollController;

  const EditDisableTimesModal({
    super.key,
    required this.disableTime,
    this.scrollController,
  });

  @override
  ConsumerState<EditDisableTimesModal> createState() =>
      _EditDisableTimesModalState();
}

class _EditDisableTimesModalState extends ConsumerState<EditDisableTimesModal> {
  late TextEditingController title;
  late TextEditingController desc;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    title = TextEditingController(
        text: widget.disableTime?.translation?.title ?? '');
    desc = TextEditingController(
        text: widget.disableTime?.translation?.description ?? '');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(masterDisableTimesProvider.notifier)
          .fetchDisableTimeDetails(context, disableTime: widget.disableTime);
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
                controller: widget.scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Text(
                          AppHelpers.getTranslation(TrKeys.editDisableTime),
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
                            initialDate: state.disableTime?.date,
                            mode: CupertinoDatePickerMode.date,
                            minTime: state.disableTime?.date ?? DateTime.now(),
                          ),
                        ),
                        12.horizontalSpace,
                        Expanded(
                          child: OutlineDropDown(
                            label: TrKeys.repeats,
                            value: state.disableTime?.repeats ??
                                DropDownValues.repeatsList.first,
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
                            initialTime: widget.disableTime?.from,
                            onTimeChange: notifier.setTimeFrom,
                          ),
                        ),
                        12.horizontalSpace,
                        Expanded(
                          child: CustomDateTimeField(
                            label: TrKeys.to,
                            initialTime: widget.disableTime?.to,
                            onTimeChange: notifier.setTimeTo,
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
                                initialText: (widget.disableTime
                                            ?.customRepeatValue?.isNotEmpty ??
                                        false)
                                    ? widget.disableTime?.customRepeatValue
                                            ?.first ??
                                        ''
                                    : '',
                                onChanged: notifier.setCustomRepeatValue,
                                validator: AppValidators.emptyCheck,
                              ),
                            ),
                            12.horizontalSpace,
                            Expanded(
                              child: OutlineDropDown(
                                label: TrKeys.type,
                                value: state.disableTime?.customRepeatType ??
                                    DropDownValues.customRepeatType.first,
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
                      value: state.disableTime?.endType ??
                          DropDownValues.endTypeList.first,
                      list: DropDownValues.endTypeList,
                      onChanged: notifier.setEndType,
                    ),
                    if (state.disableTime?.endType == 'after')
                      Padding(
                        padding: REdgeInsets.only(top: 12),
                        child: OutlinedBorderTextField(
                          label: TrKeys.value,
                          initialText: state.disableTime?.endValue,
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
                          initialDate: DateTime.tryParse(
                            state.disableTime?.endValue ?? '',
                          ),
                          mode: CupertinoDatePickerMode.date,
                          minTime: state.disableTime?.endValue == null
                              ? DateTime.now()
                              : state.disableTime?.date ?? DateTime.now(),
                          validation: AppValidators.emptyCheck,
                        ),
                      ),
                    16.verticalSpace,
                    if (state.isLoading)
                      const SizedBox(height: 80, child: Loading()),
                    16.verticalSpace,
                    CustomButton(
                      title: TrKeys.save,
                      isLoading: state.isUpdate,
                      onTap: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          notifier.updateDisableTimeDetails(
                            updateSuccess: () {
                              ref
                                  .read(masterWorkingDaysProvider.notifier)
                                  .getDisableTimes(context,
                                      isRefresh: true,
                                      idMaster: ref
                                          .watch(editMastersProvider)
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
                    // MediaQuery.viewInsetsOf(context).bottom.verticalSpace,
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
