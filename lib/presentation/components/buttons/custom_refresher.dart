import 'package:admin_desktop/presentation/components/buttons/animation_button_effect.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import 'package:admin_desktop/presentation/assets.dart';
import 'package:remixicon_updated/remixicon_updated.dart';

class CustomRefresher extends StatelessWidget {
  final VoidCallback onTap;
  final bool isLoading;

  const CustomRefresher(
      {super.key, required this.onTap, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return ButtonEffectAnimation(
      child: InkWell(
        borderRadius: BorderRadius.circular(10.r),
        onTap: onTap,
        child: Container(
          height: 44.r,
          width: 44.r,
          decoration: BoxDecoration(
              color: Style.white,
              borderRadius: BorderRadiusDirectional.circular(10.r)),
          child: Center(
            child: isLoading
                ? Lottie.asset(
                    Assets.lottieRefresh,
                    width: 36.r,
                    height: 36.r,
                    fit: BoxFit.fill,
                  )
                : const Icon(Remix.refresh_line),
          ),
        ),
      ),
    );
  }
}
