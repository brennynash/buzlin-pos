import 'package:flutter/material.dart';
import 'package:remixicon_updated/remixicon_updated.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';

class IncreaseDecreaseButton extends StatelessWidget {
  final int count;
  final Function() onAdd;
  final Function() onSubtract;

  const IncreaseDecreaseButton({
    super.key,
    required this.count,
    required this.onAdd,
    required this.onSubtract,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.r,
      decoration: BoxDecoration(
        border: Border.all(width: 1.r, color: Style.black),
        borderRadius: BorderRadius.circular(8.r),
        color: Style.white,
      ),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: onSubtract,
            splashRadius: 20.r,
            icon: Icon(
              Remix.subtract_line,
              size: 22.r,
              color: Style.black,
            ),
          ),
          Text(
            '$count ${AppHelpers.getTranslation(TrKeys.itemsInCart).toLowerCase()}',
            style: GoogleFonts.k2d(
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
              color: Style.black,
              letterSpacing: -14 * 0.01,
            ),
          ),
          IconButton(
            onPressed: onAdd,
            splashRadius: 20.r,
            icon: Icon(
              Remix.add_line,
              size: 22.r,
              color: Style.black,
            ),
          ),
        ],
      ),
    );
  }
}
