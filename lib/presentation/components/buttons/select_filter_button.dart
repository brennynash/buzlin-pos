import 'package:flutter/material.dart';
import 'package:remixicon_updated/remixicon_updated.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/presentation/styles/style.dart';

class SelectFilterButton extends StatelessWidget {
  final String title;

  const SelectFilterButton({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              color: Style.black,
              fontWeight: FontWeight.w500,
              letterSpacing: -14 * 0.02,
            ),
          ),
          Icon(
            Remix.arrow_down_s_line,
            size: 20.r,
            color: Style.black,
          ),
        ],
      ),
    );
  }
}
