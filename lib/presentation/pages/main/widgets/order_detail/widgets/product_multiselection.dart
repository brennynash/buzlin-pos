import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin_desktop/application/providers.dart';
import 'package:admin_desktop/domain/models/models.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/components/components.dart';
import '../../../../../styles/style.dart';
import 'product_selection_item.dart';

class MultiSelectionWidget extends ConsumerStatefulWidget {
  final int productId;
  final String uuid;

  const MultiSelectionWidget({
    super.key,
    required this.productId,
    required this.uuid,
  });

  @override
  ConsumerState<MultiSelectionWidget> createState() =>
      _MultiSelectionWidgetState();
}

class _MultiSelectionWidgetState extends ConsumerState<MultiSelectionWidget> {
  late RefreshController _refreshController;

  @override
  void initState() {
    super.initState();
    _refreshController = RefreshController();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => ref
          .read(orderDetailsProvider.notifier)
          .getProductDetailsByIdEdited(widget.uuid, (value) {}),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _refreshController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final stockState = ref.watch(stockProvider);
    // final stockEvent = ref.read(stockProvider.notifier);
    final notifier = ref.read(orderDetailsProvider.notifier);
    final state = ref.watch(orderDetailsProvider);
    return Column(
      children: [
        Expanded(
          child: state.isLoading
              ? const Loading()
              : SmartRefresher(
                  controller: _refreshController,
                  enablePullUp: true,
                  // onRefresh: () => stockEvent.refreshStocks(
                  //   refreshController: _refreshController,
                  // ),
                  // onLoading: () => stockEvent.fetchMoreStocks(
                  //   refreshController: _refreshController,
                  // ),
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: state.productData?.stocks?.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return FoodProductItem(
                        product: state.productData,
                        stockData:
                            state.productData?.stocks?[index] ?? Stocks(),
                        isSelected: state.changedStock?.id ==
                            state.productData?.stocks?[index].id,
                        onTap: () {
                          notifier.setStock(
                              state.productData?.stocks?[index] ?? Stocks());
                          context.maybePop();
                        },
                      );
                    },
                  ),
                ),
        ),
        Row(
          children: [
            ConfirmButton(
              borderColor: Style.primary,
              title: AppHelpers.getTranslation(TrKeys.save),
              onTap: () => context.maybePop(),
            ),
          ],
        ),
      ],
    );
  }
}
