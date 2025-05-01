import 'package:admin_desktop/application/edit_category/edit_category_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/application/edit_category/parent/edit_category_parent_notifier.dart';
import 'package:admin_desktop/application/edit_category/parent/edit_category_parent_state.dart';
import 'package:admin_desktop/domain/models/models.dart';
import '../../../../../../../application/edit_category/edit_category_state.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/components/components.dart';
import 'package:admin_desktop/presentation/styles/style.dart';

class EditCategoryLeft extends StatelessWidget {
  final EditCategoryNotifier notifier;
  final EditCategoryState state;
  final EditCategoryParentState categoryState;
  final EditCategoryParentNotifier categoryNotifier;

  const EditCategoryLeft(
      {super.key,
      required this.notifier,
      required this.state,
      required this.categoryState,
      required this.categoryNotifier});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: REdgeInsets.all(18),
          decoration: BoxDecoration(
              color: Style.white, borderRadius: BorderRadius.circular(12)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              6.verticalSpace,
              OutlinedBorderTextField(
                label: "${AppHelpers.getTranslation(TrKeys.name)}*",
                inputType: TextInputType.text,
                textCapitalization: TextCapitalization.sentences,
                textInputAction: TextInputAction.next,
                onChanged: notifier.setTitle,
                validator: AppValidators.emptyCheck,
                textController: state.titleController,
              ),
              8.verticalSpace,
              OutlinedBorderTextField(
                textController: state.descriptionController,
                label: AppHelpers.getTranslation(TrKeys.description),
                inputType: TextInputType.text,
                textCapitalization: TextCapitalization.sentences,
                textInputAction: TextInputAction.next,
                onChanged: notifier.setDescription,
              ),
              24.verticalSpace,
              _oldCategory(categoryState, context, categoryNotifier)
            ],
          ),
        ),
      ],
    );
  }

  Widget _oldCategory(EditCategoryParentState categoryState,
      BuildContext context, EditCategoryParentNotifier categoryNotifier) {
    // print("OLD CATEGORY: ${categoryState.oldCategory}");
    return Column(
      children: [
        for (int i = 0; i < categoryState.categoryControllers.length; i++)
          Padding(
            padding: REdgeInsets.only(top: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${AppHelpers.getTranslation(i == 0 ? TrKeys.parentCategory : TrKeys.subCategory)}*",
                  style: Style.interNormal(size: 14.sp),
                ),
                4.verticalSpace,
                PopupMenuButton<CategoryData>(
                  initialValue: categoryState.oldCategory,
                  enabled: i == 0
                      ? categoryState.categories.isNotEmpty
                      : categoryState
                              .selectCategories[i - 1].children?.isNotEmpty ??
                          false,
                  itemBuilder: (context) {
                    return (i == 0
                            ? categoryState.categories
                            : categoryState.selectCategories[i - 1].children ??
                                [])
                        .map(
                          (category) => PopupMenuItem<CategoryData>(
                            value: category,
                            child: Text(
                              category.translation?.title ??
                                  AppHelpers.getTranslation(TrKeys.unKnow),
                              style: Style.interNormal(size: 14.sp),
                            ),
                          ),
                        )
                        .toList();
                  },
                  onSelected: categoryNotifier.setActiveIndex,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  color: Style.white,
                  elevation: 24,
                  child: SelectFromButton(
                    title: categoryState.categoryControllers[i].text,
                  ),
                ),
              ],
            ),
          ),
        if (categoryState.selectCategory == null)
          Padding(
            padding: REdgeInsets.only(top: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${AppHelpers.getTranslation(TrKeys.category)}*",
                  style: Style.interNormal(size: 14.sp),
                ),
                4.verticalSpace,
                PopupMenuButton<CategoryData>(
                  initialValue: categoryState.oldCategory,
                  itemBuilder: (context) {
                    return (categoryState.selectCategories.isEmpty
                            ? categoryState.categories
                            : categoryState.selectCategories.last.children ??
                                [])
                        .map(
                          (category) => PopupMenuItem<CategoryData>(
                            value: category,
                            child: Text(
                              category.translation?.title ??
                                  AppHelpers.getTranslation(TrKeys.unKnow),
                              style: Style.interNormal(size: 14.sp),
                            ),
                          ),
                        )
                        .toList();
                  },
                  onSelected: categoryNotifier.setActiveIndex,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  color: Style.white,
                  elevation: 24,
                  child: SelectFromButton(
                    title: categoryState.oldCategory == null
                        ? categoryState.selectCategory?.translation?.title ?? ""
                        : categoryState.oldCategory?.translation?.title ?? '',
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
