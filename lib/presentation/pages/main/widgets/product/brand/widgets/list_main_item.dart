part of 'brand_list_view.dart';

class ListMainItem extends StatelessWidget {
  final bool hasMore;
  final bool isLoading;
  final VoidCallback onViewMore;
  final BrandNotifier notifier;
  final BrandState state;
  final ProductNotifier productNotifier;
  final AddBrandNotifier addBrandNotifier;

  const ListMainItem({
    super.key,
    required this.hasMore,
    required this.onViewMore,
    required this.isLoading,
    required this.notifier,
    required this.state,
    required this.productNotifier,
    required this.addBrandNotifier,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Style.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(6)),
            ),
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
            child: Row(
              children: [
                CustomCheckbox(
                  isActive: state.isAllSelect,
                  onTap: () => notifier.allSelectOrder(state.brands),
                ),
                8.horizontalSpace,
                SizedBox(
                  width: constraints.maxWidth / 19,
                  child: Text(
                    AppHelpers.getTranslation(TrKeys.id),
                    style: Style.interNormal(size: 16),
                  ),
                ),
                8.horizontalSpace,
                SizedBox(
                  width: constraints.maxWidth / 12,
                  child: Text(
                    AppHelpers.getTranslation(TrKeys.image),
                    style: Style.interNormal(size: 16),
                  ),
                ),
                8.horizontalSpace,
                SizedBox(
                  width: constraints.maxWidth / 4,
                  child: Text(
                    AppHelpers.getTranslation(TrKeys.title),
                    style: Style.interNormal(size: 16),
                  ),
                ),
                8.horizontalSpace,
                SizedBox(
                  width: constraints.maxWidth / 4,
                  child: Text(
                    AppHelpers.getTranslation(TrKeys.createdDate),
                    style: Style.interNormal(size: 16),
                  ),
                ),
                8.horizontalSpace,
                if (constraints.maxWidth > 880)
                  SizedBox(
                  width: constraints.maxWidth / 9,
                  child: Text(
                    AppHelpers.getTranslation(TrKeys.active),
                    style: Style.interNormal(size: 16),
                  ),
                ),
                const Spacer(),
                ConfirmButton(
                  title: AppHelpers.getTranslation(TrKeys.add),
                  onTap: () {
                    addBrandNotifier.clear();
                    productNotifier.changeState(5);
                  },
                ),
              ],
            ),
          ),
          const Divider(height: 2),
          Expanded(
            child: state.brands.isNotEmpty || isLoading
                ? ListView(
                    children: [
                      ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.brands.length,
                          itemBuilder: (context, index) {
                            return BrandListItem(
                              brandData: state.brands[index],
                              onSelect: () => notifier.addSelectOrder(
                                id: state.brands[index].id,
                                orderLength: state.brands.length,
                              ),
                              isSelect: state.selectBrands
                                  .contains(state.brands[index].id),
                              isLoading: state.isLoading,
                              onEdit: () {
                                addBrandNotifier.setBrand(state.brands[index]);
                                productNotifier.changeState(5);
                              },
                              constraints: constraints,
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
                              borderRadius: BorderRadius.circular(10.r),
                              onTap: () => onViewMore(),
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  border: Border.all(
                                    color: Style.black.withOpacity(0.17),
                                    width: 1,
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  AppHelpers.getTranslation(TrKeys.viewMore),
                                  style: Style.interNormal(size: 16.sp),
                                ),
                              ),
                            )
                          : const SizedBox()),
                      24.verticalSpace,
                    ],
                  )
                : Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 16, bottom: 200.r),
                      child: Text(
                        AppHelpers.getTranslation(TrKeys.emptyBrands),
                      ),
                    ),
                  ),
          )
        ],
      );
    });
  }
}
