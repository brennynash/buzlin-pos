import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'animation_button_effect.dart';

class ViewMoreButton extends ConsumerWidget {
  final Function()? onTap;

  const ViewMoreButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      borderRadius: BorderRadius.circular(10.r),
      onTap: onTap,
      child: ButtonEffectAnimation(
        child: Container(
          height: 50.r,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(
              color: Style.black.withOpacity(0.17),
              width: 1.r,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            AppHelpers.getTranslation(TrKeys.viewMore),
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              color: Style.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
