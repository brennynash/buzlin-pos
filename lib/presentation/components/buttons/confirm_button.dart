import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import '../components.dart';

class ConfirmButton extends StatelessWidget {
  final String title;
  final Widget? prefixIcon;
  final double height;
  final bool isLoading;
  final bool isActive;
  final bool isTab;
  final bool isShadow;
  final Color bgColor;
  final Color borderColor;
  final Color textColor;
  final double? textSize;
  final double? paddingSize;
  final Function()? onTap;

  const ConfirmButton({
    super.key,
    required this.title,
    required this.onTap,
    this.height = 50,
    this.isLoading = false,
    this.isActive = true,
    this.bgColor = Style.primary,
    this.borderColor = Style.transparent,
    this.textColor = Style.white,
    this.prefixIcon,
    this.textSize,
    this.paddingSize,
    this.isTab = false,
    this.isShadow = false,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonEffectAnimation(
      child: Material(
        borderRadius: BorderRadius.circular(16),
        color: isActive ? bgColor : Style.dontHaveAccBtnBack,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: isTab
              ? onTap
              : isActive
                  ? onTap
                  : null,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: borderColor),
                color: isActive ? bgColor : Style.dontHaveAccBtnBack,
                boxShadow: isShadow
                    ? [
                        BoxShadow(
                          blurRadius: 2,
                          offset: const Offset(0, 1),
                          color: Style.black.withOpacity(0.07),
                        )
                      ]
                    : []),
            height: height,
            padding: REdgeInsets.symmetric(horizontal: paddingSize ?? 36),
            alignment: Alignment.center,
            child: isLoading
                ? SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: isActive ? Style.white : Style.black,
                    ),
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (prefixIcon != null) prefixIcon!,
                      if (prefixIcon != null) 6.horizontalSpace,
                      Flexible(
                        child: Text(
                          AppHelpers.getTranslation(title),
                          overflow: TextOverflow.ellipsis,
                          style: Style.interMedium(
                            size: textSize ?? 16,
                            color: isActive ? textColor : Style.black,
                          ),
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
