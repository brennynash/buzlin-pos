import 'package:flutter/material.dart';
import 'package:remixicon_updated/remixicon_updated.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import '../components.dart';

class SelectFromButton extends StatelessWidget {
  final IconData? iconData;
  final String title;
  final bool isNonSelect;
  final bool? isLoading;

  const SelectFromButton({
    super.key,
    this.iconData,
    this.isNonSelect = false,
    required this.title,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Style.unselectedBottomBarBack,
          width: 1,
        ),
      ),
      alignment: Alignment.center,
      padding: REdgeInsets.symmetric(horizontal: 12),
      child: isLoading ?? false
          ? const Center(child: Loading())
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      iconData != null
                          ? Icon(
                              iconData,
                              size: 20,
                              color: Style.black,
                            )
                          : const SizedBox.shrink(),
                      8.horizontalSpace,
                      Expanded(
                        child: Text(
                          title,
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Style.black,
                            letterSpacing: -14 * 0.02,
                          ),
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                ),
                !isNonSelect
                    ? const Icon(
                        Remix.arrow_down_s_line,
                        size: 20,
                        color: Style.black,
                      )
                    : const SizedBox.shrink(),
              ],
            ),
    );
  }
}
