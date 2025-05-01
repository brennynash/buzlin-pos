import 'package:admin_desktop/application/masters/edit/edit_masters_provider.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/application/masters/working_days/working_days_provider.dart';
import '../../../../../../../components/components.dart';
import '../../../../income/widgets/custom_date_picker.dart';

class ClosedDateModal extends ConsumerStatefulWidget {
  const ClosedDateModal({super.key});

  @override
  ConsumerState<ClosedDateModal> createState() => _ClosedDateModalState();
}

class _ClosedDateModalState extends ConsumerState<ClosedDateModal> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(masterWorkingDaysProvider.notifier).getClosedDays(DateTime.now(),
          idMaster: ref.watch(editMastersProvider).masterData?.id);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(masterWorkingDaysProvider);
    final notifier = ref.read(masterWorkingDaysProvider.notifier);
    return Stack(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: REdgeInsets.symmetric(horizontal: 16),
              child: Text(AppHelpers.getTranslation(TrKeys.closedDays)),
            ),
            CustomDatePicker(
              isMulti: true,
              range: state.closedDays.map((e) => e.date).toList(),
              onDisplayedMonthChanged: notifier.getClosedDays,
              onValueChanged: notifier.setClosedDays,
            ),
            Padding(
              padding: REdgeInsets.symmetric(horizontal: 16),
              child: CustomButton(
                title: TrKeys.save,
                isLoading: state.isUpdating,
                onTap: () {
                  notifier.updateClosedDays(
                      idMaster: ref.watch(editMastersProvider).masterData?.id,
                      updateSuccess: () {
                         context.maybePop();
                      });
                },
              ),
            ),
            24.verticalSpace,
          ],
        ),
        if (state.isCloseDayLoading)
          SizedBox(height: 340.r, child: const Loading())
      ],
    );
  }
}
