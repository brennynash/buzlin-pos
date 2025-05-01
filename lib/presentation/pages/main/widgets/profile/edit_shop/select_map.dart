import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/presentation/styles/style.dart';

import 'package:admin_desktop/application/providers.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/components/components.dart';

class SelectMap extends ConsumerWidget {
  const SelectMap({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Container(
        height: MediaQuery.sizeOf(context).height / 4,
        width: (MediaQuery.sizeOf(context).width - 100) / 4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: Style.white,
        ),
        padding: REdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppHelpers.getTranslation(TrKeys.selectMap),
              style: GoogleFonts.inter(
                  fontWeight: FontWeight.w700, fontSize: 28.r),
            ),
            20.verticalSpace,
            ConfirmButton(
                title: AppHelpers.getTranslation(TrKeys.shopLocation),
                textColor: Style.black,
                onTap: () {
                   context.maybePop();
                  ref.read(profileProvider.notifier).changeIndex(2);
                }),
            16.verticalSpace,
            ConfirmButton(
                title: AppHelpers.getTranslation(TrKeys.deliveryZone),
                textColor: Style.black,
                onTap: () {
                   context.maybePop();
                  ref.read(profileProvider.notifier).changeIndex(3);
                }),
            16.verticalSpace,
          ],
        ),
      ),
    );
  }
}
