import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../styles/style.dart';

class PinContainer extends StatelessWidget {
  final bool isActive;

  const PinContainer({super.key, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24.r,
      width: 24.r,
      margin: EdgeInsets.only(right: 12.w),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isActive ? Style.primary : Style.transparent,
          border: Border.all(
              color: isActive ? Style.transparent : Style.outlineButtonBorder)),
    );
  }
}
