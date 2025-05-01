import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import 'package:lottie/lottie.dart';

import 'package:admin_desktop/infrastructure/services/utils.dart';

class NotFound extends StatelessWidget {
  const NotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Lottie.asset("assets/lottie/not-found.json", height: 200.h),
        Text(
          AppHelpers.getTranslation(TrKeys.notFound),
          style: GoogleFonts.inter(
              fontSize: 18.sp, color: Style.black, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
