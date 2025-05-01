import 'package:flutter/material.dart';
import 'package:remixicon_updated/remixicon_updated.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../styles/style.dart';

class CustomCheckbox extends StatelessWidget {
  final bool isActive;
  final VoidCallback onTap;

  const CustomCheckbox(
      {super.key, required this.isActive, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        width: 26.r,
        height: 26.r,
        decoration: BoxDecoration(
          color: isActive ? Style.primary : Style.transparent,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            width: 2,
            color: isActive ? Style.transparent : Style.unselectedBottomItem,
          ),
        ),
        duration: const Duration(milliseconds: 500),
        child: isActive
            ? Icon(
                Remix.check_fill,
                color: Style.white,
                size: 18.r,
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}
