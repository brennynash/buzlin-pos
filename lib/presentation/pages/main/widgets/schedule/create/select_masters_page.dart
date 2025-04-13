import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:remixicon_updated/remixicon_updated.dart';
import 'package:admin_desktop/application/bookings/booking_provider.dart';
import 'package:admin_desktop/application/bookings/create/create_booking_provider.dart';
import 'package:admin_desktop/application/bookings/create/create_booking_state.dart';
import 'package:admin_desktop/domain/models/models.dart';
import 'package:admin_desktop/presentation/components/components.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import 'select_time_modal.dart';
import 'widgets/select_master_bottom_sheet.dart';

class SelectMastersPage extends ConsumerWidget {
  const SelectMastersPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(createBookingProvider);
    return Scaffold(
      body: KeyboardDismisser(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                AppHelpers.getTranslation(TrKeys.selectMaster),
                style: Style.interMedium(size: 18),
              ),
            ),
            24.verticalSpace,
            ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16.r),
                shrinkWrap: true,
                itemCount: state.selectServices.length,
                itemBuilder: (context, index) {
                  final UserData? master =
                      state.selectMasters[state.selectServices[index].id];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.selectServices[index].translation?.title ?? "",
                        style: Style.interNormal(size: 18),
                      ),
                      8.verticalSpace,
                      Row(
                        children: [
                          _addMaster(context, state, index, master),
                          const Spacer(),
                          if(master != null)
                          _addTime(context, state, index, master)
                        ],
                      ),
                      8.verticalSpace,
                      const Divider(),
                      8.verticalSpace,
                    ],
                  );
                })
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.r),
        child: Row(
          children: [
            PopButton(
              popSuccess: () {
                ref.read(bookingProvider.notifier).changeStateIndex(1);
              },
            ),
            10.horizontalSpace,
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 16.r),
                height: 64.r,
                child: CustomButton(
                    title: TrKeys.next,
                    onTap: () {
                      if (state.selectMasters.values
                          .any((e) => e.time == null)) {
                        AppHelpers.openDialog(
                            context: context,
                            title: AppHelpers.getTranslation(
                                TrKeys.youMustSelectTime));
                        return;
                      }
                      List list = state.selectMasters.keys.toList()..sort();
                      if (listEquals(
                          list,
                          state.selectServices.map((e) => e.id).toList()
                            ..sort())) {
                        ref.read(bookingProvider.notifier).changeStateIndex(4);
                        return;
                      }
                      AppHelpers.openDialog(
                          context: context,
                          title: AppHelpers.getTranslation(
                              TrKeys.youMustSelectMaster));
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }

  ButtonEffectAnimation _addMaster(BuildContext context,
      CreateBookingState state, int index, UserData? master) {
    return ButtonEffectAnimation(
      onTap: () {
        AppHelpers.showAlertDialog(
          context: context,
          child: SelectMasterBottomSheet(
            title: state.selectServices[index].translation?.title ?? "",
            serviceId: state.selectServices[index].id,
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: Style.icon),
        ),
        padding: EdgeInsets.symmetric(horizontal: 12.r, vertical: 8.r),
        child: master == null
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Remix.account_circle_line,
                    size: 24.r,
                  ),
                  8.horizontalSpace,
                  Text(
                    AppHelpers.getTranslation(TrKeys.addMaster),
                    style: Style.interNormal(size: 16),
                  ),
                ],
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CommonImage(
                    url: master.img ?? "",
                    height: 32,
                    width: 32,
                    radius: 4,
                  ),
                  8.horizontalSpace,
                  Text(
                    master.firstname ?? "",
                    style: Style.interNormal(size: 16),
                  )
                ],
              ),
      ),
    );
  }

  ButtonEffectAnimation _addTime(BuildContext context, CreateBookingState state,
      int index, UserData? master) {
    return ButtonEffectAnimation(
      onTap: () {
        // AppRouteService.goSelectTomeBottomSheet(
        //     context: context,
        //     selectMaster: master?.id,
        //     title: state.selectServices[index].translation?.title ?? "",
        //     shopId: shopId,
        //     colors: colors);
        AppHelpers.showAlertDialog(
          context: context,
          child: SizedBox(
            width: MediaQuery.sizeOf(context).width / 1.8,
            height: MediaQuery.sizeOf(context).height / 1.4,
            child: SelectTimeModal(
              serviceId: master?.serviceMaster?.id,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: Style.icon),
        ),
        padding: EdgeInsets.symmetric(horizontal: 12.r, vertical: 8.r),
        child: master?.time == null
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Remix.calendar_2_line,
                    size: 21.r,
                  ),
                  8.horizontalSpace,
                  Text(
                    AppHelpers.getTranslation(TrKeys.selectTime),
                    style: Style.interNormal(size: 16),
                  ),
                ],
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    TimeService.dateFormatMDYHm(master?.time),
                    style: Style.interNormal(size: 16),
                  )
                ],
              ),
      ),
    );
  }
}
