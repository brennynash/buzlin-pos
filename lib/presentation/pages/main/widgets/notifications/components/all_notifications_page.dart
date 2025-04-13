import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import 'package:remixicon_updated/remixicon_updated.dart';
import 'package:admin_desktop/application/providers.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/components/components.dart';

class AllNotificationsPage extends ConsumerWidget {
  final int index;

  const AllNotificationsPage(this.index, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(notificationProvider);
    final notifier = ref.read(notificationProvider.notifier);
    return Slidable(
      endActionPane: ActionPane(
        extentRatio: 0.12,
        motion: const ScrollMotion(),
        children: [
          Expanded(
            child: Consumer(
              builder: (context, ref, child) {
                return GestureDetector(
                  onTap: () {
                    final notifier = ref.read(notificationProvider.notifier);
                    notifier.deleteNotification(
                        id: state.notifications[index].id);
                    Slidable.of(context)?.close();
                  },
                  child: Container(
                    width: 50.r,
                    height: 72.r,
                    decoration: BoxDecoration(
                      color: Style.red,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16.r),
                        bottomLeft: Radius.circular(16.r),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      Remix.delete_bin_line,
                      color: Style.white,
                      size: 24.r,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      child: Column(
        children: [
          8.verticalSpace,
          GestureDetector(
            onTap: () {
              if (LocalStorage.getUser()?.role == TrKeys.seller) {
                if (state.notifications[index].orderData != null) {
                  context.maybePop();
                  if (state.notifications[index].readAt == null) {
                    notifier.readOne(
                        index: index,
                        context,
                        id: state.notifications[index].id);
                  }
                  ref
                      .read(mainProvider.notifier)
                      .setOrder(state.notifications[index].orderData);
                  ref.read(mainProvider.notifier).changeIndex(1);
                } else {
                  AppHelpers.showAlertDialog(
                    context: context,
                    child: Container(
                      width: 400.r,
                      height: 120.r,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: Style.white),
                      padding: EdgeInsets.all(16.r),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (state.notifications[index].orderData != null)
                            CommonImage(
                              radius: 100,
                              url: state.notifications[index].client?.img,
                              height: 56,
                              width: 56,
                            ),
                          6.horizontalSpace,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (state.notifications[index].orderData != null)
                                Row(
                                  children: [
                                    Text(
                                      '${state.notifications[index].client?.firstname ?? ''} ${state.notifications[index].client?.lastname?.substring(0, 1) ?? ''}.',
                                      style: GoogleFonts.inter(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16.sp,
                                          color: Style.black),
                                    ),
                                    15.horizontalSpace,
                                    Container(
                                      height: 8.r,
                                      width: 8.r,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: state.notifications[index]
                                                      .readAt ==
                                                  null
                                              ? Style.primary
                                              : Style.transparent),
                                    )
                                  ],
                                ),
                              2.verticalSpace,
                              SizedBox(
                                width: 300.r,
                                child: Text(
                                  state.notifications[index].body ?? '',
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14.sp,
                                      color: Style.black),
                                  maxLines: 4,
                                ),
                              ),
                              8.verticalSpace,
                              Text(
                                TimeService.dateFormatForNotification(state.notifications[index].createdAt),
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12.sp,
                                    color: Style.iconColor),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                  if (state.notifications[index].readAt == null) {
                    notifier.readOne(
                        index: index,
                        context,
                        id: state.notifications[index].id);
                  }
                }
              }
            },
            child: Container(
              color: Style.transparent,
              child: Row(
                children: [
                  if (state.notifications[index].orderData != null)
                    CommonImage(
                      radius: 100,
                      url: state.notifications[index].client?.img,
                      height: 56,
                      width: 56,
                    ),
                  6.horizontalSpace,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (state.notifications[index].orderData != null)
                        Row(
                          children: [
                            Text(
                              '${state.notifications[index].client?.firstname ?? ''} ${state.notifications[index].client?.lastname?.substring(0, 1) ?? ''}.',
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16.sp,
                                  color: Style.black),
                            ),
                            15.horizontalSpace,
                            Container(
                              height: 8.r,
                              width: 8.r,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color:
                                      state.notifications[index].readAt == null
                                          ? Style.primary
                                          : Style.transparent),
                            )
                          ],
                        ),
                      2.verticalSpace,
                      SizedBox(
                        width: 340.w,
                        child: Text(
                          '${state.notifications[index].body}',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.w400,
                              fontSize: 14.sp,
                              color: Style.black),
                        ),
                      ),
                      8.verticalSpace,
                      Text(
                        TimeService.dateFormatForNotification(state.notifications[index].createdAt),
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w400,
                            fontSize: 12.sp,
                            color: Style.iconColor),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          8.verticalSpace,
          Row(
            children: [
              Expanded(
                child: Divider(
                  color: Style.black.withOpacity(0.3),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
