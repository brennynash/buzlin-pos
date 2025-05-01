import 'package:admin_desktop/application/create/details/create_food_details_state.dart';
import 'package:admin_desktop/application/create/stocks/create_food_stocks_state.dart';
import 'package:admin_desktop/application/product/product_notifier.dart';
import 'package:admin_desktop/application/whole_sale/whole_sale_notifier.dart';
import 'package:admin_desktop/application/whole_sale/whole_sale_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/components/components.dart';
import 'widgets/editable_whole_sale_item.dart';

class CreateWholeSaleStocksBody extends StatefulWidget {
  final WholeSaleNotifier notifier;
  final ProductNotifier productNotifier;
  final WholeSaleState state;
  final CreateFoodStocksState stockState;
  final CreateFoodDetailsState detailState;
  final VoidCallback onNext;

  const CreateWholeSaleStocksBody(
      {super.key,
      required this.notifier,
      required this.state,
      required this.stockState,
      required this.onNext,
      required this.productNotifier,
      required this.detailState});

  @override
  State<CreateWholeSaleStocksBody> createState() =>
      _CreateWholeSaleStocksBodyState();
}

class _CreateWholeSaleStocksBodyState extends State<CreateWholeSaleStocksBody> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => widget.notifier.setInitialStocks(
        product: widget.detailState.createdProduct,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //final productNotifier = ref.read(productsProvider.notifier);
    final next = widget.stockState.groups.any((element) =>
        element.type == TrKeys.color ? element.isChecked ?? false : false);
    return (widget.state.product?.digital ?? false)
        ? const SizedBox.shrink()
        : KeyboardDisable(
            child: SizedBox(
              height: MediaQuery.sizeOf(context).height - 200,
              width: MediaQuery.sizeOf(context).width - 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  10.verticalSpace,
                  Expanded(
                    child: ListView.builder(
                      itemCount: widget.state.stocks.length,
                      shrinkWrap: true,
                      padding:
                          REdgeInsets.symmetric(vertical: 10, horizontal: 16),
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Form(
                          key: widget.state.formKeys[index],
                          child: EditableWholeSaleItem(
                            key: UniqueKey(),
                            stock: widget.state.stocks[index],
                            onDeleteStock: (i) => widget.notifier
                                .deleteStock(index: i, stockIndex: index),
                            onPriceChange: (value, i) => widget.notifier
                                .setPrice(
                                    value: value, index: i, stockIndex: index),
                            onMinQuantityChange: (value, i) => widget.notifier
                                .setMinQuantity(
                                    value: value, index: i, stockIndex: index),
                            onMaxQuantityChange: (value, i) =>
                                widget.notifier.setMaxQuantity(
                              value: value,
                              index: i,
                              stockIndex: index,
                            ),
                            onMinQuantityCheck: (value, i) =>
                                widget.notifier.minQtyCheck(
                              value: value,
                              index: i,
                              stockIndex: index,
                            ),
                            onMaxQuantityCheck: (value, i) =>
                                widget.notifier.maxQtyCheck(
                              value: value,
                              index: i,
                              stockIndex: index,
                            ),
                            onAdd: () {
                              if (widget.state.formKeys[index].currentState
                                      ?.validate() ??
                                  false) {
                                widget.notifier.addEmptyStock(index);
                              }
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: REdgeInsets.symmetric(horizontal: 20),
                    child: CustomButton(
                      title: AppHelpers.getTranslation(
                          next ? TrKeys.next : TrKeys.save),
                      isLoading: widget.state.isSaving,
                      onTap: () {
                        if (widget.state.formKeys.every((element) =>
                            element.currentState?.validate() ?? false)) {
                          final product = widget.detailState.createdProduct;
                          widget.notifier.updateStocks(
                            context,
                            uuid: product?.uuid,
                            updated: (newProduct) {
                              //productNotifier.updateSingleProduct(newProduct);
                              AppHelpers.successSnackBar(
                                context,
                                text: AppHelpers.getTranslation(
                                    TrKeys.successfullyUpdated),
                              );
                              if (next) {
                                widget.onNext.call();
                              } else {
                                widget.productNotifier.changeState(0);
                              }
                            },
                          );
                        }
                      },
                    ),
                  ),
                  24.verticalSpace,
                ],
              ),
            ),
          );
  }
}
