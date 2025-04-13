import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import '../../../../../components/buttons/animation_button_effect.dart';
import '../../../../../styles/style.dart';

class ViewMode extends StatelessWidget {
  final String title;
  final bool isActive;
  final bool isLeft;
  final IconData icon;
  final VoidCallback onTap;

  const ViewMode({
    super.key,
    required this.title,
    required this.isActive,
    this.isLeft = true,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    bool isLtr = LocalStorage.getLangLtr();
    bool isLeft = isLtr;

    return ButtonEffectAnimation(
      child: ClipRRect(
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(isLeft ? 12.r : 0),
          right: Radius.circular(isLeft ? 0 : 12.r),
        ),
        child: InkWell(
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(isLeft ? 12.r : 0),
            right: Radius.circular(isLeft ? 0 : 12.r),
          ),
          onTap: onTap,
          child: Container(
            width: 100.w,
            padding: EdgeInsets.symmetric(vertical: 10.r),
            decoration: BoxDecoration(
              color: isActive ? Style.primary : Style.transparent,
              border: Border.all(
                color: isActive ? Style.primary : Style.borderColor,
              ),
              borderRadius: BorderRadius.horizontal(
                left: Radius.circular(isLeft ? 12.r : 0),
                right: Radius.circular(isLeft ? 0 : 12.r),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: isActive ? Style.white : Style.reviewText,
                  size: 20.r,
                ),
                14.horizontalSpace,
                Text(
                  title,
                  style: Style.interMedium(
                    color: isActive ? Style.white : Style.reviewText,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
