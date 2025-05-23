import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import '../../../../../../../styles/style.dart';

class ClientInfoItem extends StatelessWidget {
  final String title;
  final String label;

  const ClientInfoItem({super.key, required this.title, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            AppHelpers.getTranslation(label),
            style: Style.interNormal(
              size: 14,
              color: Style.textColor,
            ),
          ),
          2.verticalSpace,
          Text(
            title,
            style: Style.interNormal(size: 14),
          ),
        ],
      ),
    );
  }
}
