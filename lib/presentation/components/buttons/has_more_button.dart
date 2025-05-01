import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/styles/style.dart';

class HasMoreButton extends StatelessWidget {
  final bool hasMore;
  final VoidCallback onViewMore;

  const HasMoreButton({
    super.key,
    required this.hasMore,
    required this.onViewMore,
  });

  @override
  Widget build(BuildContext context) {
    return (hasMore
        ? InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: onViewMore,
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Style.black.withOpacity(0.17),
                  width: 1.r,
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                AppHelpers.getTranslation(TrKeys.viewMore),
                style: Style.interNormal(size: 16),
              ),
            ),
          )
        : const SizedBox());
  }
}
