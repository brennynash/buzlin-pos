part of 'category_list_view.dart';

class ListMainItem extends ConsumerWidget {
  final bool hasMore;
  final bool isLoading;
  final VoidCallback onViewMore;

  const ListMainItem({
    super.key,
    required this.hasMore,
    required this.onViewMore,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context, ref) {
    final notifier = ref.read(serviceCategoriesProvider.notifier);
    final state = ref.watch(serviceCategoriesProvider);
    final categories = ref.watch(serviceCategoriesProvider).categories;
    return categories.isNotEmpty || isLoading
        ? ListView(
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return CategoryListItem(
                      categoryData: state.categories[index],
                      spacing: 10,
                      onEdit: (category) {
                        ref
                            .read(editServiceCategoryProvider.notifier)
                            .setCategoryDetails(category, (value) {
                          ref.read(servicesProvider.notifier).changeState(2);
                        });
                        // ref
                        //     .read(editCategoryProvider.notifier)
                        //     .setCategoryDetails(category, (category) {
                        //   ref
                        //       .read(editCategoryParentProvider.notifier)
                        //       .setInitial(
                        //           category: category,
                        //           categories: state.categories);
                        // });
                      },
                      onTap: notifier.onTapParent,
                      selectParents: state.selectParents,
                      selectSubs: state.selectSubs,
                      onTapSub: notifier.onTapSub,
                      onSelect: () {
                        notifier.addSelectOrder(
                          id: categories[index].id,
                          orderLength: categories.length,
                        );
                      },
                      isSelected:
                          state.selectCategories.contains(categories[index].id),
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
