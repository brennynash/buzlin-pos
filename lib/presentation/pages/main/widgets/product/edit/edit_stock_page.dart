import 'package:admin_desktop/application/edit_product/details/edit_food_details_state.dart';
import 'package:admin_desktop/application/edit_product/stocks/edit_food_stocks_state.dart';
import 'package:admin_desktop/application/product/convert/convert_notifier.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/application/edit_product/details/edit_food_details_notifier.dart';
import 'package:admin_desktop/application/edit_product/stocks/edit_food_stocks_notifier.dart';
import 'package:admin_desktop/application/product/convert/convert_state.dart';
import 'package:admin_desktop/presentation/components/components.dart';
import '../../../../../styles/style.dart';
import 'widgets/edit_group_extras_modal.dart';

class EditStockPage extends StatelessWidget {
  const EditStockPage(
      {super.key,
      required this.onNext,
      required this.editFoodDetail,
      required this.editFoodDetailNotifier,
      required this.stockState,
      required this.convertEvent,
      required this.convertState,
      required this.stockEvent});

  final EditFoodDetailsState editFoodDetail;
  final EditFoodDetailsNotifier editFoodDetailNotifier;
  final EditFoodStocksState stockState;
  final EditFoodStocksNotifier stockEvent;
  final ConvertNotifier convertEvent;
  final ConvertState convertState;
  final Function() onNext;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (editFoodDetail.product?.digital ?? false)
          const HorizontalFilePicker(),
        Container(
          padding: REdgeInsets.symmetric(horizontal: 16, vertical: 16),
          margin: REdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Style.white, borderRadius: BorderRadius.circular(8.r)),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppHelpers.getTranslation(TrKeys.extras),
                style: Style.interNormal(),
              ),
              12.verticalSpace,
              stockState.isFetchingGroups
                  ? const Loading()
                  : Wrap(runSpacing: 12.r, spacing: 12.r, children: [
                      ...stockState.groups.mapIndexed((e, i) => ExtrasItem(
                          extras: e,
                          onTap: () {
                            AppHelpers.showAlertDialog(
                              context: context,
                              radius: 12,
                              child: SizedBox(
                                height: MediaQuery.sizeOf(context).height / 1.5,
                                width: MediaQuery.sizeOf(context).width / 4,
                                child: EditGroupExtrasModal(
                                  groupIndex: i,
                                ),
                              ),
                            );
                          }))
                    ]),
            ],
          ),
        ),
        if (stockState.stocks.length > 2)
          Container(
            padding: REdgeInsets.symmetric(vertical: 12, horizontal: 12),
            margin: REdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Style.white,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: OutlinedBorderTextField(
                    label: '${AppHelpers.getTranslation(TrKeys.price)}*',
                    inputType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    onChanged: (e) => stockEvent.setAllPrice(value: e),
                    validator: AppValidators.emptyCheck,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                ),
                12.horizontalSpace,
                Expanded(
                  child: OutlinedBorderTextField(
                    label: '${AppHelpers.getTranslation(TrKeys.quantity)}*',
                    inputType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    onChanged: (e) => stockEvent.setAllQuantity(value: e),
                    validator: AppValidators.emptyCheck,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                ),
                12.horizontalSpace,
                Expanded(
                  child: OutlinedBorderTextField(
                    label: AppHelpers.getTranslation(TrKeys.sku),
                    textInputAction: TextInputAction.next,
                    onChanged: (e) => stockEvent.setAllSku(value: e),
                  ),
                ),
              ],
            ),
          ),
        Padding(
          padding: EdgeInsets.only(bottom: 6.r),
          child: ListView.builder(
            itemCount: stockState.stocks.length,
            shrinkWrap: true,
            padding: REdgeInsets.symmetric(vertical: 4, horizontal: 4),
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return EditableFoodStockItem(
                key: UniqueKey(),
                isDeletable: index != 0,
                stock: stockState.stocks[index],
                quantityController: stockState.quantityControllers[index],
                priceController: stockState.priceControllers[index],
                skuController: stockState.skuControllers[index],
                onDeleteStock: () => stockEvent.deleteStock(index),
                onPriceChange: (value) =>
                    stockEvent.setPrice(value: value, index: index),
                onQuantityChange: (value) =>
                    stockEvent.setQuantity(value: value, index: index),
                onSkuChange: (value) {
                  stockEvent.setSku(value: value, index: index);
                },
              );
            },
          ),
        ),
        16.verticalSpace,
        Row(
          children: [
            SizedBox(
              width: 150.r,
              child: LoginButton(
                  title: AppHelpers.getTranslation(TrKeys.save),
                  isLoading: stockState.isLoading,
                  onPressed: () {
                    if (stockState.product?.digital ?? false) {
                      if (convertState.file == null) {
                        AppHelpers.showSnackBar(context,
                            AppHelpers.getTranslation(TrKeys.pleaseUpload));
                        return;
                      } else {
                        convertEvent.uploadFile(context,
                            productId: stockState.product?.id);
                      }
                    }
                    stockEvent.updateStocks(
                      context,
                      uuid: editFoodDetail.product?.uuid,
                      updated: (product) {
                        AppHelpers.showSnackBar(
                          context,
                          AppHelpers.getTranslation(TrKeys.successfullyEdited),
                        );
                        editFoodDetailNotifier.changeState(3);
                      },
                      failed: () => AppHelpers.showSnackBar(
                        context,
                        AppHelpers.getTranslation(TrKeys.errorProductCreate),
                      ),
                    );
                  }),
            ),
          ],
        ),
        16.verticalSpace,
      ],
    );
  }
}
