import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/presentation/styles/style.dart';

class IconTextButton extends StatelessWidget {
  final Color backgroundColor;
  final IconData iconData;
  final Color iconColor;
  final String title;
  final double height;
  final Color textColor;
  final BorderRadius? radius;
  final Function()? onPressed;

  const IconTextButton({
    super.key,
    this.backgroundColor = Style.primary,
    required this.iconData,
    this.iconColor = Style.white,
    required this.title,
    this.textColor = Style.white,
    required this.onPressed,
    this.height = 40,
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: radius ?? BorderRadius.circular(24),
      color: backgroundColor,
      child: InkWell(
        borderRadius: radius ?? BorderRadius.circular(24),
        onTap: onPressed,
        child: Container(
          height: height,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Icon(
                iconData,
                size: 24,
                color: iconColor,
              ),
              12.horizontalSpace,
              Text(
                title,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: textColor,
                  letterSpacing: -14 * 0.02,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
