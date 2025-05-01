import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remixicon_updated/remixicon_updated.dart';

import '../../../../../../../../../domain/models/models.dart';
import '../../../../../../../styles/style.dart';

class ProductListItem extends StatelessWidget {
  final ProductData product;
  final Function() onTap;
  final bool isSelected;

  const ProductListItem({
    super.key,
    required this.product,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Style.white,
          borderRadius: BorderRadius.circular(10.r),
        ),
        padding: REdgeInsets.all(18),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 18.r,
                height: 18.r,
                margin: EdgeInsets.only(right: 10.r),
                decoration: BoxDecoration(
                  color: isSelected ? Style.primary : Style.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: !isSelected ? Style.textHint : Style.primary),
                ),
                child: Icon(
                  Remix.check_line,
                  color: Style.white,
                  size: 16.r,
                ),
              ),
              16.horizontalSpace,
              Expanded(
                child: Text(
                  product.translation?.title ?? '',
                  style: Style.interRegular(
                    size: 15,
                    color: Style.black,
                    letterSpacing: -0.3,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
