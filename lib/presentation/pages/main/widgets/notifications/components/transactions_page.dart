import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import 'package:admin_desktop/application/providers.dart';
import 'package:admin_desktop/presentation/components/components.dart';

class TransactionsPage extends ConsumerWidget {
  final int index;

  const TransactionsPage(this.index, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactionState = ref.watch(notificationProvider).transaction;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        25.verticalSpace,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonImage(
              radius: 100,
              url: transactionState[index].user?.img ?? '',
              height: 56,
              width: 56,
            ),
            16.horizontalSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${transactionState[index].user?.firstname}',
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.w700,
                      fontSize: 16.sp,
                      color: Style.black),
                ),
                2.verticalSpace,
                SizedBox(
                  width: 300,
                  child: Text(
                    '${transactionState[index].user?.id}',
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
                  '${transactionState[index].status}',
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp,
                      color: transactionState[index].status == 'progress'
                          ? Style.rate
                          : Style.iconColor),
                ),
              ],
            ),
          ],
        ),
        22.verticalSpace,
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
    );
  }
}
