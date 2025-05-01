import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import '../../../../../assets.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import '../../../../../styles/style.dart';

class NoItem extends StatelessWidget {
  final String title;

  const NoItem({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
              width: MediaQuery.sizeOf(context).width / 3.5,
              child: Lottie.asset(Assets.lottieNotFound)),
          8.verticalSpace,
          Padding(
            padding: REdgeInsets.symmetric(horizontal: 24),
            child: Text(
              AppHelpers.getTranslation(title),
              style: Style.interNormal(size: 16),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
