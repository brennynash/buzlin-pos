import 'package:admin_desktop/presentation/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:admin_desktop/infrastructure/services/utils.dart';
import '../styles/style.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 40,
          child: Image.asset(
            Assets.pngAppIcon,
            height: 40.r,
            width: 40.r,
          ),
        ),
        12.horizontalSpace,
        Text(AppHelpers.getAppName() ?? "", style: Style.interSemi()),
      ],
    );
  }
}
