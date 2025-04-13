import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/styles/style.dart';

class OrderDetailItem extends StatelessWidget {
  final String title;
  final String value;

  const OrderDetailItem({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: Text(
              AppHelpers.getTranslation(title),
              style: Style.interRegular(
                size: 14,
                color: Style.black,
                letterSpacing: -0.3,
              ),
            ),
          ),
          Text(
            value,
            style: Style.interNormal(
              size: 14,
              color: Style.black,
              letterSpacing: -0.3,
            ),
          ),
        ],
      ),
    );
  }
}
