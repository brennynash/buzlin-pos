import 'package:admin_desktop/presentation/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/presentation/styles/style.dart';

class PinButton extends StatelessWidget {
  final String? title;
  final IconData? iconData;
  final VoidCallback onTap;

  const PinButton({super.key, this.title, this.iconData, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ButtonEffectAnimation(
      child: InkWell(
        borderRadius: BorderRadius.circular(5.r),
        onTap: onTap,
        child: Container(
          height: 68.r,
          width: 68.r,
          decoration: BoxDecoration(
              border: Border.all(width: 2, color: Style.outlineButtonBorder),
              borderRadius: BorderRadius.circular(15.r)),
          child: Center(
            child: title != null
                ? Text(
                    title!,
                    style: GoogleFonts.inter(
                      color: Style.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 26.sp,
                    ),
                  )
                : iconData != null
                    ? Icon(
                        iconData!,
                        size: 26.r,
                      )
                    : const Placeholder(),
          ),
        ),
      ),
    );
  }
}
