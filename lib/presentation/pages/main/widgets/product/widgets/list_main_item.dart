part of 'product_list_view.dart';

class ListMainItem extends StatelessWidget {
  final bool hasMore;
  final bool isLoading;
  final VoidCallback onViewMore;
  final ProductNotifier notifier;
  final ProductState state;

  const ListMainItem({
    super.key,
    required this.hasMore,
    required this.onViewMore,
    required this.isLoading,
    required this.notifier,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        children: [
          Container(
            color: Style.white,
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
            child: Row(
              children: [
                CustomCheckbox(
                  isActive: state.isAllSelect,
                  onTap: () => notifier.allSelectOrder(state.products),
                ),
                8.horizontalSpace,
                SizedBox(
                  width: constraints.maxWidth / 18,
                  child: Text(
                    AppHelpers.getTranslation(TrKeys.id),
                    style: Style.interNormal(size: 16),
                  ),
                ),
                12.horizontalSpace,
                SizedBox(
                  width: constraints.maxWidth / 12,
                  child: Text(
                    AppHelpers.getTranslation(TrKeys.image),
                    style: Style.interNormal(size: 16),
                  ),
                ),
                12.horizontalSpace,
                SizedBox(
                  width: constraints.maxWidth / 5,
                  child: Text(
                    AppHelpers.getTranslation(TrKeys.name),
                    style: Style.interNormal(size: 16),
                  ),
                ),
                12.horizontalSpace,
                SizedBox(
                  width: constraints.maxWidth / 8,
                  child: Text(
                    AppHelpers.getTranslation(TrKeys.status),
                    style: Style.interNormal(size: 16),
                  ),
                ),
                12.horizontalSpace,
                if (constraints.maxWidth > 800)
                  SizedBox(
                    width: constraints.maxWidth / 10,
                    child: Text(
                      AppHelpers.getTranslation(TrKeys.category),
                      style: Style.interNormal(size: 16),
                    ),
                  ),
                12.horizontalSpace,
                if (constraints.maxWidth > 920)
                  SizedBox(
                    width: constraints.maxWidth / 6,
                    child: Text(
                      AppHelpers.getTranslation(TrKeys.createdDate),
                      style: Style.interNormal(size: 16),
                    ),
                  ),
                const Spacer(),
                SizedBox(
                  width: constraints.maxWidth / 10,
                  child: Text(
                    AppHelpers.getTranslation(TrKeys.active),
                    style: Style.interNormal(size: 16),
                  ),
                ),
                const Spacer(),
                12.horizontalSpace,
              ],
            ),
          ),
          const Divider(height: 2),
          Expanded(
            child: state.products.isNotEmpty || isLoading
                ? ListView(
                    children: [
                      ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.products.length,
                          itemBuilder: (context, index) {
                            return ListItem(
                              productData: state.products[index],
                              onSelect: () => notifier.addSelectOrder(
                                id: state.products[index].id,
                                orderLength: state.products.length,
                              ),
                              isSelect: state.selectProducts
                                  .contains(state.products[index].id),
                              onActive: (check) {
                                notifier.changeActive(
                                  state.products[index].uuid ?? "",
                                );
                              },
                              isLoading: state.isLoading,
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
                              borderRadius: BorderRadius.circular(10),
                              onTap: () => onViewMore(),
                              child: Container(
                                height: 50,
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
                          : const SizedBox()),
                      24.verticalSpace,
                    ],
                  )
                : Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 16.r, bottom: 200.r),
                      child: Text(
                        AppHelpers.getTranslation(TrKeys.cannotBeEmpty),
                      ),
                    ),
                  ),
          )
        ],
      );
    });
  }
}
