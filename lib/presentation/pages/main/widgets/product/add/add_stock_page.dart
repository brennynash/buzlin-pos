import 'package:admin_desktop/application/create/details/create_food_details_state.dart';
import 'package:admin_desktop/application/create/gallery/create_product_gallery_notifier.dart';
import 'package:admin_desktop/application/create/stocks/create_food_stocks_notifier.dart';
import 'package:admin_desktop/application/create/stocks/create_food_stocks_state.dart';
import 'package:admin_desktop/application/product/product_state.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import 'package:admin_desktop/application/product/convert/convert_notifier.dart';
import 'package:admin_desktop/application/product/convert/convert_state.dart';
import 'package:admin_desktop/application/product/product_notifier.dart';
import 'package:admin_desktop/presentation/components/components.dart';
import 'package:admin_desktop/presentation/theme/theme/theme_wrapper.dart';
import 'widgets/create_food_edit_extras_modal.dart';

class AddStockPage extends StatelessWidget {
  const AddStockPage(
      {super.key,
      required this.onNext,
      required this.detailState,
      required this.stockState,
      required this.stockEvent,
      required this.productState,
      required this.productNotifier,
      required this.convertState,
      required this.convertNotifier,
      required this.productGalleryNotifier});

  final CreateFoodDetailsState detailState;
  final CreateFoodStocksState stockState;
  final CreateFoodStocksNotifier stockEvent;
  final ProductState productState;
  final ProductNotifier productNotifier;
  final ConvertState convertState;
  final ConvertNotifier convertNotifier;
  final CreateProductGalleryNotifier productGalleryNotifier;
  final Function() onNext;

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (colors, controller) {
      return Column(
        children: [
          if (detailState.digital) const HorizontalFilePicker(),
          Container(
            padding: REdgeInsets.symmetric(horizontal: 16, vertical: 16),
            margin: REdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
                color: Style.white, borderRadius: BorderRadius.circular(8.r)),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppHelpers.getTranslation(TrKeys.extras),
                  style: GoogleFonts.inter(fontSize: 16.sp, color: Style.black),
                ),
                12.verticalSpace,
                stockState.isFetchingGroups
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Style.primary,
                        ),
                      )
                    : Wrap(runSpacing: 12.r, spacing: 12.r, children: [
                        ...stockState.groups.mapIndexed((e, i) => ExtrasItem(
                            extras: e,
                            onTap: () {
                              AppHelpers.showAlertDialog(
                                  context: context,
                                  radius: 12,
                                  child: SizedBox(
                                    height:
                                        MediaQuery.sizeOf(context).height / 1.5,
                                    width: MediaQuery.sizeOf(context).width / 4,
                                    child: CreateFoodEditExtrasModal(
                                      groupIndex: i,
                                      group: e,
                                    ),
                                  ));
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
              padding: REdgeInsets.symmetric(vertical: 4, horizontal: 8),
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return EditableFoodStockItem(
                  key: UniqueKey(),
                  isDeletable: index != 0,
                  stock: stockState.stocks[index],
                  quantityController: stockState.quantityControllers[index],
                  skuController: stockState.skuControllers[index],
                  priceController: stockState.priceControllers[index],
                  onDeleteStock: () => stockEvent.deleteStock(index),
                  onPriceChange: (value) =>
                      stockEvent.setPrice(value: value, index: index),
                  onQuantityChange: (value) =>
                      stockEvent.setQuantity(value: value, index: index),
                  onSkuChange: (value) =>
                      stockEvent.setSku(value: value, index: index),
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
                      if (detailState.digital) {
                        if (convertState.file == null) {
                          AppHelpers.showSnackBar(context,
                              AppHelpers.getTranslation(TrKeys.pleaseUpload));
                          return;
                        } else {
                          convertNotifier.uploadFile(context,
                              productId: detailState.createdProduct?.id);
                        }
                      }
                      stockEvent.updateStocks(
                        context,
                        updated: (product) {
                          AppHelpers.showSnackBar(
                            context,
                            AppHelpers.getTranslation(
                                TrKeys.successfullyCreated),
                          );

                          productGalleryNotifier.initial(product?.stocks ?? []);
                          if (product?.digital ?? false) {
                            productNotifier.changeState(0);
                          } else {
                            onNext.call();
                          }
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
        ],
      );
    });
  }
}
