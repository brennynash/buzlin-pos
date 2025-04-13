import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import '../../../../../infrastructure/services/app_helpers.dart';

class DeliveryInfoWidget extends StatelessWidget {
  final String title;
  final String textDelivery;
  final Color textColor;

  const DeliveryInfoWidget({
    super.key,
    required this.title,
    this.textColor = Style.black,
    required this.textDelivery,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          AppHelpers.getTranslation(title),
          style: GoogleFonts.inter(
            color: Style.black,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            letterSpacing: -0.4,
          ),
        ),
        Text(
          textDelivery,
          style: GoogleFonts.inter(
            color: textColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            letterSpacing: -0.4,
          ),
        ),
      ],
    );
  }
}
