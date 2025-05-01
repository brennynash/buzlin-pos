import 'package:admin_desktop/infrastructure/services/app_helpers.dart';
import 'package:flutter/material.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import '../components.dart';

class CustomButton extends StatelessWidget {
  final Color? borderColor;
  final Color? textColor;
  final Color bgColor;
  final String? title;
  final Function()? onTap;
  final bool? isLoading;
  final double? width;

  const CustomButton({
    super.key,
    this.borderColor,
    this.title,
    this.textColor = Style.white,
    this.bgColor = Style.primary,
    this.onTap,
    this.isLoading,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonEffectAnimation(
      onTap: onTap,
      child: Container(
        padding:  EdgeInsets.symmetric(vertical: 12,horizontal: 8),
        width: width,
        height: 48,
        decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: borderColor ?? Style.transparent)),
        child: Center(
          child: isLoading ?? false
              ? const Loading()
              : Text(
                  AppHelpers.getTranslation(title ?? ''),
                  style: GoogleFonts.inter(
                      fontSize: 16,
                      color: textColor,
                      fontWeight: FontWeight.w500),
                  overflow: TextOverflow.ellipsis,
                ),
        ),
      ),
    );
  }
}
