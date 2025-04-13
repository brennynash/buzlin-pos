part of 'list_view.dart';

class ListMainItem extends StatelessWidget {
  final List<OrderData> orderList;
  final bool hasMore;
  final bool isLoading;
  final VoidCallback onViewMore;
  final OrderTableState state;
  final OrderTableNotifier notifier;
  final MainNotifier mainNotifier;

  const ListMainItem({
    super.key,
    required this.orderList,
    required this.hasMore,
    required this.onViewMore,
    required this.isLoading,
    required this.state,
    required this.notifier,
    required this.mainNotifier,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Style.white,
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
          child: Row(
            children: [
              CustomCheckbox(
                isActive: state.isAllSelect,
                onTap: () => notifier.allSelectOrder(orderList),
              ),
              8.horizontalSpace,
              SizedBox(
                width: 56.w,
                child: Text(
                  AppHelpers.getTranslation(TrKeys.id),
                  style: Style.interNormal(size: 16),
                ),
              ),
              8.horizontalSpace,
              SizedBox(
                width: 140.w,
                child: Text(
                  AppHelpers.getTranslation(TrKeys.client),
                  style: Style.interNormal(size: 16),
                ),
              ),
              8.horizontalSpace,
              SizedBox(
                width: 120.w,
                child: Text(
                  AppHelpers.getTranslation(TrKeys.status),
                  style: Style.interNormal(size: 16),
                ),
              ),
              8.horizontalSpace,
              SizedBox(
                width: 120.w,
                child: Text(
                  AppHelpers.getTranslation(TrKeys.deliveryman),
                  style: Style.interNormal(size: 16),
                ),
              ),
              8.horizontalSpace,
              SizedBox(
                width: 96.w,
                child: Text(
                  AppHelpers.getTranslation(TrKeys.amount),
                  style: Style.interNormal(size: 16),
                ),
              ),
              8.horizontalSpace,
              SizedBox(
                width: 120.w,
                child: Text(
                  AppHelpers.getTranslation(TrKeys.orderTime),
                  style: Style.interNormal(size: 16),
                ),
              ),
              8.horizontalSpace,
              SizedBox(
                width: 120.w,
                child: Text(
                  AppHelpers.getTranslation(TrKeys.deliveryDate),
                  style: Style.interNormal(size: 16),
                ),
              ),
              8.horizontalSpace,
            ],
          ),
        ),
        const Divider(height: 2),
        Expanded(
          child: orderList.isNotEmpty || isLoading
              ? ListView(
                  children: [
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: orderList.length,
                        itemBuilder: (context, index) {
                          return ListItem(
                              orderData: orderList[index],
                              onSelect: () => notifier.addSelectOrder(
                                  id: orderList[index].id,
                                  orderLength: orderList.length),
                              isSelect: state.selectOrders
                                  .contains(orderList[index].id),
                              mainNotifier: mainNotifier);
                        }),
                    if (isLoading)
                      ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 6,
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
                        : const SizedBox())
                  ],
                )
              : Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 200),
                    child: Text(
                      AppHelpers.getTranslation(TrKeys.emptyOrders),
                    ),
                  ),
                ),
        )
      ],
    );
  }
}
