import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import '../components.dart';

class CircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color backgroundColor;
  final Color iconColor;
  final Color borderColor;
  final double size;
  final double iconSize;
  final bool isBorder;

  const CircleButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.backgroundColor = Style.greyColor,
    this.size = 44,
    this.iconSize = 24,
    this.iconColor = Style.black,
    this.borderColor = Style.transparent,
    this.isBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonEffectAnimation(
      onTap: onTap,
      child: Container(
        height: size.r,
        width: size.r,
        padding: REdgeInsets.all(4),
        decoration: BoxDecoration(
            color: backgroundColor,
            shape: BoxShape.circle,
            border: isBorder
                ? Border.all(color: borderColor)
                : const Border.fromBorderSide(BorderSide.none)),
        child: Center(
            child: Icon(
          icon,
          color: iconColor,
          size: iconSize.r,
        )),
      ),
    );
  }
}
