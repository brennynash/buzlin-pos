import 'package:admin_desktop/application/right_side/right_side_notifier.dart';
import 'package:admin_desktop/application/right_side/right_side_state.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:remixicon_updated/remixicon_updated.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import 'package:admin_desktop/application/providers.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/components/components.dart';
import 'price_info.dart';

class OrderCalculate extends ConsumerWidget {
  const OrderCalculate({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final notifier = ref.read(mainProvider.notifier);
    final rightNotifier = ref.read(rightSideProvider.notifier);
    final state = ref.read(mainProvider);
    final stateRight = ref.watch(rightSideProvider);
    return Scaffold(
      backgroundColor: Style.mainBack,
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _informationWidget(notifier, rightNotifier, state, stateRight),
            16.horizontalSpace,
            calculator(stateRight, rightNotifier)
          ],
        ),
      ),
    );
  }

  Widget calculator(
      RightSideState stateRight, RightSideNotifier rightSideNotifier) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Style.white,
          borderRadius: BorderRadius.circular(8.r),
        ),
        padding: EdgeInsets.symmetric(vertical: 20.r, horizontal: 16.r),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppHelpers.getTranslation(TrKeys.payableAmount),
                          style: GoogleFonts.inter(
                              fontSize: 18.sp, fontWeight: FontWeight.w600),
                        ),
                        6.verticalSpace,
                        Text(
                          AppHelpers.numberFormat(
                            number: stateRight.selectedUser?.wallet?.price ?? 0,
                          ),
                          style: Style.interMedium(size: 24.sp),
                        ),
                      ],
                    )
                  ],
                ),
                16.horizontalSpace,
                if (stateRight.selectedUser != null)
                  Expanded(
                    child: Row(
                      children: [
                        CommonImage(
                          url: stateRight.selectedUser?.img ?? "",
                          width: 50,
                          height: 50,
                          radius: 25,
                        ),
                        16.horizontalSpace,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AutoSizeText(
                                "${stateRight.selectedUser?.firstname ?? ""} ${stateRight.selectedUser?.lastname ?? ""}",
                                style: Style.interMedium(size: 18.sp),
                                maxLines: 2,
                              ),
                              Text(
                                "#${AppHelpers.getTranslation(TrKeys.id)}${stateRight.selectedUser?.id ?? ""}",
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.sp,
                                    color: Style.iconColor),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            16.verticalSpace,
            const Divider(),
            const Spacer(),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20.r),
              decoration: BoxDecoration(
                  border: Border.all(color: Style.differBorderColor),
                  borderRadius: BorderRadius.circular(8.r)),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  stateRight.calculate,
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600, fontSize: 24.sp),
                  maxLines: 1,
                ),
              ),
            ),
            const Spacer(),
            GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 12,
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 28.r,
                  mainAxisSpacing: 24.r,
                  mainAxisExtent: 74.r,
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      rightSideNotifier.setCalculate(index == 9
                          ? "00"
                          : index == 10
                              ? "0"
                              : index == 11
                                  ? "-1"
                                  : (index + 1).toString());
                    },
                    child: ButtonEffectAnimation(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Style.addButtonColor,
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Center(
                          child: index == 11
                              ? const Icon(Remix.delete_back_2_line)
                              : Text(
                                  index == 9
                                      ? "00"
                                      : index == 10
                                          ? "0"
                                          : (index + 1).toString(),
                                  style: GoogleFonts.inter(
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                        ),
                      ),
                    ),
                  );
                }),
            16.verticalSpace,
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: () {
                      rightSideNotifier.setCalculate(".");
                    },
                    child: ButtonEffectAnimation(
                      child: Container(
                        height: 74.r,
                        decoration: BoxDecoration(
                          color: Style.addButtonColor,
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Center(
                          child: Text(
                            ".",
                            style: GoogleFonts.inter(
                                fontSize: 24.sp, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                28.horizontalSpace,
                Expanded(
                  flex: 2,
                  child: ButtonEffectAnimation(
                    child: Container(
                      height: 74.r,
                      decoration: BoxDecoration(
                        color: Style.addButtonColor,
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Center(
                        child: Text(
                          AppHelpers.getTranslation(TrKeys.ok),
                          style: GoogleFonts.inter(
                              fontSize: 24.sp, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _informationWidget(
      MainNotifier notifier,
      RightSideNotifier rightSideNotifier,
      MainState state,
      RightSideState stateRight) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                CustomBackButton(onTap: () => notifier.setPriceDate(null)),
                const Spacer(),
                InkWell(
                  onTap: () {
                    rightSideNotifier.fetchCarts();
                  },
                  child: ButtonEffectAnimation(
                    child: Container(
                        decoration: BoxDecoration(
                            color: Style.white,
                            borderRadius: BorderRadius.circular(10.r)),
                        padding: EdgeInsets.all(8.r),
                        child: const Icon(Remix.restart_line)),
                  ),
                )
              ],
            ),
            16.verticalSpace,
            Container(
              padding: EdgeInsets.symmetric(vertical: 20.r, horizontal: 16.r),
              decoration: BoxDecoration(
                  color: Style.white,
                  borderRadius: BorderRadius.circular(10.r)),
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  Text(
                    AppHelpers.getTranslation(TrKeys.order),
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600, fontSize: 22.sp),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${stateRight.bags[stateRight.selectedBagIndex].selectedUser?.firstname ?? ""} ${stateRight.bags[stateRight.selectedBagIndex].selectedUser?.lastname ?? ""}",
                        style: GoogleFonts.inter(
                            fontSize: 16.sp, color: Style.iconColor),
                      ),
                      Text(
                        AppHelpers.getTranslation(stateRight.orderType),
                        style: GoogleFonts.inter(
                            fontSize: 16.sp, color: Style.iconColor),
                      ),
                    ],
                  ),
                  8.verticalSpace,
                  const Divider(),
                  8.verticalSpace,
                  Text(
                    AppHelpers.getTranslation(TrKeys.totalItem),
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600, fontSize: 18.sp),
                  ),
                  ListView.builder(
                      padding: EdgeInsets.only(top: 16.r),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount:
                          stateRight.paginateResponse?.stocks?.length ?? 0,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 16.r),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  stateRight.paginateResponse?.stocks?[index]
                                          .stock?.product?.translation?.title ??
                                      "",
                                  style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16.sp,
                                      color: Style.black),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Text(
                                AppHelpers.numberFormat(
                                    number: stateRight.paginateResponse
                                        ?.stocks?[index].price),
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.sp,
                                    color: Style.black),
                              )
                            ],
                          ),
                        );
                      }),
                  const Divider(),
                  PriceInfo(
                    bag: stateRight.bags[stateRight.selectedBagIndex],
                    state: stateRight,
                    notifier: rightSideNotifier,
                    mainNotifier: notifier,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
