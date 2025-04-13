import 'package:admin_desktop/domain/models/models.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_dropdown/models/value_item.dart';
import 'package:admin_desktop/application/providers.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/components/login_button.dart';

class DeliveryTimeWidget extends ConsumerWidget {
  final List<ValueItem> selectedCategory;
  final List<ValueItem> selectedTag;
  final List<ValueItem> selectedType;
  final GlobalKey<FormState> formKey;

  const DeliveryTimeWidget(
      {super.key,
      required this.selectedTag,
      required this.selectedCategory,
      required this.selectedType,
      required this.formKey});

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(shopProvider);
    final notifier = ref.read(shopProvider.notifier);
    final profileNotifier = ref.read(profileProvider.notifier);
    final demoWorkingDay = [
      'monday',
      'tuesday',
      'wednesday',
      'thursday',
      'friday',
      'saturday',
      'sunday'
    ];
    List<ShopWorkingDay> workingDays = state.editShopData?.shopWorkingDays ??
        [
          for (int i = 0; i < demoWorkingDay.length; i++)
            ShopWorkingDay(
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        18.verticalSpace,
        const Divider(),
        18.verticalSpace,
        Text(
          AppHelpers.getTranslation(TrKeys.workingHours),
          style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 22),
        ),
        18.verticalSpace,
        if (state.editShopData?.shopWorkingDays?.isNotEmpty ?? false)
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
                itemCount: state.editShopData?.shopWorkingDays?.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      12.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                              width:
                                  (MediaQuery.sizeOf(context).width - 100) / 8,
                              child: Text(
                                AppHelpers.getTranslation(
                                    workingDays[index].day ?? ""),
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w400, fontSize: 22),
                              )),
                          workingDays[index].disabled ?? false
                              ? Text(
                                  AppHelpers.getTranslation(TrKeys.shopClosed),
                                  style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18),
                                )
                              : SizedBox(
                                  width:
                                      (MediaQuery.sizeOf(context).width - 100) /
                                          3,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        height: 36.r,
                                        width: 156.w,
                                        child: CupertinoDatePicker(
                                          itemExtent: 156.w,
                                          key: UniqueKey(),
                                          mode: CupertinoDatePickerMode.time,
                                          initialDateTime: DateTime(
                                            2022,
                                            1,
                                            1,
                                            int.tryParse(workingDays[index]
                                                        .from
                                                        ?.substring(0, 2) ??
                                                    '') ??
                                                0,
                                            int.tryParse(workingDays[index]
                                                        .from
                                                        ?.substring(3, 5) ??
                                                    '') ??
                                                0,
                                          ),
                                          onDateTimeChanged:
                                              (DateTime newDateTime) {
                                            setTimeToDay(
                                              time: TimeOfDay.fromDateTime(
                                                  newDateTime),
                                              currentIndex: index,
                                            );
                                          },
                                          use24hFormat: AppHelpers.getHourFormat24(),
                                          minuteInterval: 1,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 36.r,
                                        width: 156.w,
                                        child: CupertinoDatePicker(
                                          itemExtent: 156.w,
                                          key: UniqueKey(),
                                          mode: CupertinoDatePickerMode.time,
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
                                                time: TimeOfDay.fromDateTime(
                                                    newDateTime),
                                                currentIndex: index,
                                                isFrom: false);
                                          },
                                          use24hFormat: AppHelpers.getHourFormat24(),
                                          minuteInterval: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                          CupertinoSwitch(
                              activeColor: Style.primary,
                              value: workingDays[index].disabled ?? false,
                              onChanged: (s) {
                                notifier.setCloseDay(index);
                              })
                        ],
                      ),
                      12.verticalSpace,
                      if (index < (workingDays.length) - 1) const Divider(),
                    ],
                  );
                }),
          ),
        40.verticalSpace,
        SizedBox(
          width: 250.w,
          child: LoginButton(
              isLoading: state.isSave,
              title: AppHelpers.getTranslation(TrKeys.save),
              onPressed: () async {
                final stateLocation = ref.watch(selectAddressProvider);
                if (formKey.currentState?.validate() ?? false) {
                  if (stateLocation.textController?.text != null &&
                      (stateLocation.textController?.text.isEmpty ?? true) &&
                      state.editShopData?.translation?.address == null) {
                    AppHelpers.showSnackBar(context, TrKeys.address);
                    return;
                  }
                  await notifier.updateWorkingDays(
                      days: workingDays,
                      shopUuid: state.editShopData?.uuid ?? "");
                  await notifier.updateShopData(
                      displayName:
                          stateLocation.textController?.text.isNotEmpty ?? false
                              ? stateLocation.textController?.text
                              : state.editShopData?.translation?.address
                                  .toString(),
                      location: stateLocation.location,
                      category: selectedCategory,
                      tag: selectedTag,
                      type: selectedType,
                      onSuccess: (shop) {
                        profileNotifier.changeIndex(0);
                        LocalStorage.setShop(shop);
                      });
                }
              }),
        )
      ],
    );
  }
}
