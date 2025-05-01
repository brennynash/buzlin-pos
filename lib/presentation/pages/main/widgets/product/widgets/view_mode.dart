import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import '../../../../../components/buttons/animation_button_effect.dart';
import '../../../../../styles/style.dart';

class ViewMode extends StatelessWidget {
  final String title;
  final bool isActive;
  final bool isLeft;
  final bool isRight;
  final IconData? icon;
  final VoidCallback onTap;

  const ViewMode({
    super.key,
    required this.title,
    required this.isActive,
    this.isLeft = false,
    required this.onTap,
    this.isRight = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    bool isLtr = LocalStorage.getLangLtr();
    bool leftIsLeft = isLtr ? isLeft : isRight;
    bool rightIsLeft = isLtr ? isRight : isLeft;

    return ButtonEffectAnimation(
      child: ClipRRect(
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(leftIsLeft ? 12 : 0),
          right: Radius.circular(rightIsLeft ? 12 : 0),
        ),
        child: InkWell(
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(leftIsLeft ? 12 : 0),
            right: Radius.circular(rightIsLeft ? 12 : 0),
          ),
          onTap: onTap,
          child: Container(
            width: 120.w,
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: isActive ? Style.primary : Style.white,
              border: Border.all(
                color: isActive ? Style.primary : Style.borderColor,
              ),
              borderRadius: BorderRadius.horizontal(
                left: Radius.circular(leftIsLeft ? 12 : 0),
                right: Radius.circular(rightIsLeft ? 12 : 0),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (icon != null)
                  Icon(
                    icon,
                    color: isActive ? Style.white : Style.reviewText,
                    size: 20,
                  ),
                if (icon != null) 14.horizontalSpace,
                Text(
                  title,
                  style: Style.interMedium(
                    color: isActive ? Style.white : Style.reviewText,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
