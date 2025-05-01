import 'package:flutter/material.dart';
import 'package:remixicon_updated/remixicon_updated.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/presentation/styles/style.dart';

class SizeItem extends StatelessWidget {
  final VoidCallback onTap;
  final bool isActive;
  final String title;

  const SizeItem({
    super.key,
    required this.onTap,
    required this.isActive,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 12.h),
      child: GestureDetector(
        onTap: () => onTap(),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: Style.white,
              borderRadius: BorderRadius.all(Radius.circular(10.r))),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    isActive
                        ? Remix.checkbox_circle_fill
                        : Remix.checkbox_blank_circle_line,
                    color: isActive ? Style.primary : Style.black,
                    size: 24.r,
                  ),
                  16.horizontalSpace,
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      color: Style.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
