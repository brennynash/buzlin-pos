part of 'category_list_view.dart';

class ListMainItem extends StatelessWidget {
  final bool hasMore;
  final bool isLoading;
  final VoidCallback onViewMore;
  final EditCategoryNotifier editCategoryNotifier;
  final EditCategoryParentNotifier editCategoryParentNotifier;
  final FoodCategoriesNotifier notifier;
  final ProductNotifier productNotifier;
  final FoodCategoriesState state;

  const ListMainItem({
    super.key,
    required this.hasMore,
    required this.onViewMore,
    required this.isLoading,
    required this.notifier,
    required this.state,
    required this.editCategoryNotifier,
    required this.editCategoryParentNotifier,
    required this.productNotifier,
  });

  @override
  Widget build(BuildContext context) {
    return state.categories.isNotEmpty || isLoading
        ? ListView(
            children: [
              const Divider(height: 2),
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.categories.length,
                  itemBuilder: (context, index) {
                    return CategoryListItem(
                      categoryData: state.categories[index],
                      spacing: 10,
                      onEdit: (category) {
                        editCategoryNotifier.setCategoryDetails(category,
                            (category) {
                          editCategoryParentNotifier.setInitial(
                              category: category, categories: state.categories);
                          productNotifier.changeState(7);
                        });
                      },
                      onTap: notifier.onTapParent,
                      selectParents: state.selectParents,
                      selectSubs: state.selectSubs,
                      onTapSub: notifier.onTapSub,
                      onSelect: () {
                        notifier.addSelectOrder(
                          id: state.categories[index].id,
                          orderLength: state.categories.length,
                        );
                      },
                      isSelected: state.selectCategories
                          .contains(state.categories[index].id),
                      isLoading: state.isLoading,
                      selectCategories: state.selectCategories,
                    );
                  }),
              if (isLoading)
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 72,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(1),
                              color: Style.shimmerBase,
                            ),
                          ),
                          const Divider(height: 2, color: Style.white),
                        ],
                      );
                    }),
              24.verticalSpace,
              (hasMore
                  ? InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () => onViewMore(),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Style.black.withOpacity(0.17),
                            width: 1,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          AppHelpers.getTranslation(TrKeys.viewMore),
                          style: Style.interNormal(size: 16),
                        ),
                      ),
                    )
                  : const SizedBox()),
              24.verticalSpace,
            ],
          )
        : Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 200),
              child: Text(
                AppHelpers.getTranslation(TrKeys.cannotBeEmpty),
              ),
            ),
          );
  }
}
