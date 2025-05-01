import 'package:admin_desktop/application/masters/edit/edit_masters_provider.dart';
import 'package:admin_desktop/presentation/pages/main/widgets/catalogue/widgets/masters/widgets/add_disable_times_modal.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import 'package:remixicon_updated/remixicon_updated.dart';
import 'package:admin_desktop/application/masters/working_days/working_days_provider.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/components/loading.dart';
import 'disable_time_item.dart';
import 'edit_disable_times_modal.dart';

class DisableTimesModal extends ConsumerStatefulWidget {
  const DisableTimesModal({super.key});

  @override
  ConsumerState<DisableTimesModal> createState() => _DisableTimesModalState();
}

class _DisableTimesModalState extends ConsumerState<DisableTimesModal> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(masterWorkingDaysProvider.notifier).getDisableTimes(context,
          isRefresh: true,
          idMaster: ref.watch(editMastersProvider).masterData?.id);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(masterWorkingDaysProvider);
    return Scaffold(
      body: Column(
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
          if (state.disableTimes.isNotEmpty)
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: REdgeInsets.symmetric(vertical: 12),
                itemCount: state.disableTimes.length,
                itemBuilder: (context, index) {
                  return DisableTimeItem(
                    disableTime: state.disableTimes[index],
                    onDelete: () {},
                    onTap: () {
                      AppHelpers.showAlertDialog(
                        context: context,
                        child: SizedBox(
                          height: MediaQuery.sizeOf(context).height / 1.5,
                          width: MediaQuery.sizeOf(context).width / 2,
                          child: EditDisableTimesModal(
                            disableTime: state.disableTimes[index],
                          ),
                        ),
                      );
                    },
                  );
                }),
          if (state.isDisableLoading)
            const SizedBox(height: 80, child: Loading()),
          24.verticalSpace,
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AppHelpers.showAlertDialog(
              context: context,
              child: SizedBox(
                height: MediaQuery.sizeOf(context).height / 1.5,
                width: MediaQuery.sizeOf(context).width / 2,
                child: const AddDisableTimesModal(),
              ));
          //notifier.addTextField();
        },
        backgroundColor: Style.primary,
        child: const Icon(Remix.add_fill),
      ),
    );
  }
}
