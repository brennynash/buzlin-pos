import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../../../../domain/models/models.dart';
import 'food_category_item.dart';

class FoodCategoriesModal extends StatelessWidget {
  final List<CategoryData> categories;
  final ValueChanged<CategoryData> onSelect;
  final ValueChanged<CategoryData> onChange;

  const FoodCategoriesModal(
      {super.key,
      required this.categories,
      required this.onSelect,
      required this.onChange});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: REdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                // TitleAndIcon(
                //   title: AppHelpers.getTranslation(TrKeys.categories),
                //   titleSize: 16,
                // ),
                Consumer(
                  builder: (context, ref, child) {
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        return FoodCategoryItem(
                          category: categories[index],
                          onSelect: onSelect,
                          onChange: onChange,
                        );
                      },
                    );
                  },
                ),
                20.verticalSpace,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
