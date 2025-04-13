import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/styles/style.dart';

class PriceItem extends StatelessWidget {
  final num? price;
  final String title;
  final bool discount;

  const PriceItem({
    super.key,
    this.price,
    required this.title,
    this.discount = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        16.verticalSpace,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.r),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppHelpers.getTranslation(title),
                style: Style.interRegular(size: 14),
              ),
              Text(
                discount
                    ? "-${AppHelpers.numberFormat(number: price)} "
                    : AppHelpers.numberFormat(number: price),
                style: Style.interRegular(
                    color: discount ? Style.red : Style.black, size: 14),
              ),
            ],
          ),
        ),
        16.verticalSpace,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.r),
          child: const Divider(
            color: Style.textHint,
          ),
        ),
      ],
    );
  }
}
