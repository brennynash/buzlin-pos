import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';

class InfoWidget extends StatelessWidget {
  const InfoWidget({
    super.key,
    required this.title,
    required this.info,
  });

  final String title;
  final String info;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Expanded(
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                  text: AppHelpers.getTranslation(title),
                  style: GoogleFonts.inter(
                    color: Style.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    letterSpacing: -0.4,
                  ),
                ),
                TextSpan(
                  text: ':',
                  style: GoogleFonts.inter(
                    color: Style.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    letterSpacing: -0.4,
                  ),
                ),
              ]),
            ),
          ),
          Text(
            info,
            style: GoogleFonts.inter(
              color: Style.black,
              fontSize: 16,
              fontWeight: FontWeight.w400,
              letterSpacing: -0.4,
            ),
          ),
        ],
      ),
    );
  }
}
