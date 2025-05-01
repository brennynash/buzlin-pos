part of 'category_list_view.dart';

class CategoryListItem extends StatelessWidget {
  final CategoryData categoryData;
  final ValueChanged<CategoryData?> onEdit;
  final ValueChanged<int?> onTap;
  final ValueChanged<int?> onTapSub;
  final double spacing;
  final List<int> selectParents;
  final List selectCategories;
  final List<int> selectSubs;
  final VoidCallback onSelect;
  final bool isSelected;
  final bool isLoading;

  const CategoryListItem({
    super.key,
    required this.categoryData,
    required this.onEdit,
    this.spacing = 1,
    required this.onTap,
    required this.selectParents,
    required this.selectSubs,
    required this.onTapSub,
    required this.onSelect,
    required this.isSelected,
    required this.isLoading,
    required this.selectCategories,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: spacing),
      child: Column(
        children: [
          categoryItem(
            type: 0,
            category: categoryData,
            isSelect: selectParents.contains(categoryData.id),
            isEmpty: categoryData.children?.isEmpty ?? true,
          ),
          if (selectParents.contains(categoryData.id))
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Column(
                children:
                    List.generate(categoryData.children?.length ?? 0, (index) {
                  final subCategory = categoryData.children?[index];
                  return Column(
                    children: [
                      categoryItem(
                        type: 1,
                        category: subCategory,
                        isSelect: selectSubs.contains(subCategory?.id),
                        isEnd: categoryData.children?.length == index + 1,
                        isFirst: index == 0,
                      ),
                      if (selectSubs.contains(subCategory?.id))
                        Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Column(
                            children: List.generate(
                                subCategory?.children?.length ?? 0, (index) {
                              final childCategory =
                                  subCategory?.children?[index];
                              return Column(
                                children: [
                                  categoryItem(
                                    type: 2,
                                    category: childCategory,
                                    isEnd: subCategory?.children?.length ==
                                        index + 1,
                                    isFirst: index == 0,
                                  ),
                                ],
                              );
                            }),
                          ),
                        )
                    ],
                  );
                }),
              ),
            )
        ],
      ),
    );
  }

  Widget categoryItem({
    required CategoryData? category,
    bool isSelect = false,
    bool isEnd = false,
    bool isFirst = false,
    bool isEmpty = false,
    required int type,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected ? Style.mainBack : Style.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(type == 0 ? 12 : 0),
          topRight: Radius.circular(type == 0 ? 12 : 0),
          bottomLeft: Radius.circular(type == 0 || isSelect || isEnd ? 12 : 0),
          bottomRight: Radius.circular(
              !isSelect && isEnd || type == 0 && !isSelect ? 12 : 0),
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: type == 0 ? 2 : 0),
      margin: EdgeInsets.only(left: type * 20),
      child: ButtonEffectAnimation(
        disabled: type != 2,
        onTap: () {
          if (type == 0) {
            onTap(category?.id);
          } else if (type == 1) {
            onTapSub(category?.id);
          }
        },
        child: Column(
          children: [
            if (isFirst) const Divider(height: 6),
            6.verticalSpace,
            //if(type == 1 || type == 2) 23.horizontalSpace,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                children: [
                  CustomCheckbox(isActive: isSelected, onTap: onSelect),
                  8.horizontalSpace,
                  SizedBox(
                    width: 60.w,
                    child: Text(
                      "${categoryData.id ?? 0}",
                      style: Style.interNormal(
                        size: 16,
                        color: Style.brandTitleDivider,
                      ),
                    ),
                  ),
                  8.horizontalSpace,
                  CommonImage(
                    url: category?.img,
                    height: 64,
                    width: 90,
                  ),
                  32.horizontalSpace,
                  SizedBox(
                    width: 160.w,
                    child: Text(
                      AppHelpers.getTranslation(
                          category?.translation?.title ?? "--"),
                      style: Style.interNormal(
                        size: 16,
                        color: Style.brandTitleDivider,
                      ),
                    ),
                  ),
                  8.horizontalSpace,
                  SizedBox(
                    width: 140.w,
                    child: Text(
                      AppHelpers.getTranslation(AppHelpers.getTranslation(
                          (category?.active ?? false)
                              ? TrKeys.active
                              : TrKeys.inactive)),
                      style: Style.interNormal(
                        size: 16,
                        color: Style.brandTitleDivider,
                      ),
                    ),
                  ),
                  8.horizontalSpace,
                  SizedBox(
                    width: 140.w,
                    child: Text(
                      AppHelpers.getTranslation(AppHelpers.getTranslation(
                          category?.translation?.locale ?? "")),
                      style: Style.interNormal(
                        size: 16,
                        color: Style.brandTitleDivider,
                      ),
                    ),
                  ),
                  const Spacer(),
                  StatusButton(
                    status: category?.status ?? '',
                    verticalPadding: 4,
                    horizontalPadding: 12,
                  ),
                  const Spacer(),
                  category?.shopId != null &&
                          category?.shopId == LocalStorage.getUser()?.shop?.id
                      ? ButtonEffectAnimation(
                          child: InkWell(
                            onTap: () => onEdit(category),
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              padding: REdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Style.primary,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Remix.edit_2_line,
                                color: Style.white,
                                size: 24,
                              ),
                            ),
                          ),
                        )
                      : 36.horizontalSpace,
                  12.horizontalSpace,
                  Row(
                    children: [
                      8.horizontalSpace,
                      if (type != 2)
                        Icon(
                          isSelect
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          size: 24,
                          color: isSelect ? Style.primary : Style.black,
                        ),
                    ],
                  ),
                ],
              ),
            ),
            if (type != 0 && !isEnd && !isSelect) const Divider(height: 6),
            if (isEnd) 4.verticalSpace,
          ],
        ),
      ),
    );
  }
}
