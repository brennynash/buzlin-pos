import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/domain/models/models.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/styles/style.dart';

class FoodCategoryItem extends StatelessWidget {
  final CategoryData category;
  final ValueChanged<CategoryData> onSelect;
  final ValueChanged<CategoryData> onChange;
  final String? title;

  const FoodCategoryItem({
    super.key,
    required this.category,
    required this.onSelect,
    this.title,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.only(top: 8),
      child: GestureDetector(
        onTap: () {
          if (category.children?.isEmpty ?? true) {
            onSelect(category);
          }
          onChange(category);
           context.maybePop();
        },
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Style.white,
            borderRadius: BorderRadius.circular(10.r),
          ),
          padding: REdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      category.translation?.title ??
                          AppHelpers.getTranslation(TrKeys.noName),
                      style: Style.interRegular(
                        size: 15,
                        color: Style.black,
                        letterSpacing: -0.3,
                      ),
                    ),
                  ),
                  16.horizontalSpace,
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
