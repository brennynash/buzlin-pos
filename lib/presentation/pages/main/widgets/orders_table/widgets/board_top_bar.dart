import 'package:admin_desktop/presentation/assets.dart';
import 'package:flutter/material.dart';
import 'package:remixicon_updated/remixicon_updated.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import 'package:lottie/lottie.dart';

import 'package:admin_desktop/infrastructure/services/utils.dart';

class BoardTopBar extends StatelessWidget {
  final String title;
  final String count;
  final VoidCallback onTap;
  final bool isLoading;

  const BoardTopBar({
    super.key,
    required this.title,
    required this.count,
    required this.onTap,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      decoration: BoxDecoration(
        color: Style.white,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      margin: const EdgeInsets.only(right: 4, left: 4, bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            AppHelpers.getTranslation(title),
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Style.black,
            ),
          ),
          (count.length > 4 ? 8 : 12).horizontalSpace,
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 6,
              horizontal: count.length > 5
                  ? 8
                  : count.length > 3
                      ? 10
                      : 16,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: AppHelpers.getStatusColor(title)),
            child: Text(
              count,
              style: GoogleFonts.inter(
                fontSize: count.length > 5
                    ? 12
                    : count.length > 3
                        ? 13
                        : 15,
                fontWeight: FontWeight.w600,
                color: Style.white,
              ),
            ),
          ),
          const Spacer(),
          InkWell(
            onTap: onTap,
            child: isLoading
                ? Lottie.asset(
                    Assets.lottieRefresh,
                    width: 32,
                    height: 32,
                    fit: BoxFit.fill,
                  )
                : const Icon(
                    Remix.refresh_line,
                    size: 24,
                  ),
          ),
        ],
      ),
    );
  }
}
