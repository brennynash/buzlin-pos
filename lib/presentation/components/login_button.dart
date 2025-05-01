import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'buttons/animation_button_effect.dart';

class LoginButton extends StatelessWidget {
  final String title;
  final bool isLoading;
  final bool isActive;
  final Color bgColor;
  final Color titleColor;
  final double borderRadius;
  final Icon? icon;
  final Function()? onPressed;

  const LoginButton(
      {super.key,
      required this.title,
      required this.onPressed,
      this.isLoading = false,
      this.isActive = true,
      this.bgColor = Style.primary,
      this.titleColor = Style.white,
      this.borderRadius = 8,
      this.icon});

  @override
  Widget build(BuildContext context) {
    return ButtonEffectAnimation(
      child: Material(
        borderRadius: BorderRadius.circular(borderRadius),
        color: isActive ? bgColor : Style.selectedItemsText,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Container(
            height: 56.r,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius),
                border: Border.all(
                    color: bgColor == Style.transparent
                        ? Style.selectedItemsText
                        : Style.transparent)),
            alignment: Alignment.center,
            child: isLoading
                ? const SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Style.white,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (icon != null) icon!,
                      if (icon != null) 8.horizontalSpace,
                      Text(
                        AppHelpers.getTranslation(title),
                        style: GoogleFonts.inter(
                            fontSize: 16,
                            color: isActive ? titleColor : Style.black,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.4),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
