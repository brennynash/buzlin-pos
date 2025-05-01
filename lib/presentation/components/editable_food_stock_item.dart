import 'package:admin_desktop/domain/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:remixicon_updated/remixicon_updated.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import '../styles/style.dart';
import 'buttons/animation_button_effect.dart';
import 'color_item.dart';
import 'text_fields/outline_bordered_text_field.dart';

class EditableFoodStockItem extends StatelessWidget {
  final Stocks stock;
  final Function(String) onPriceChange;
  final Function(String) onQuantityChange;
  final Function(String) onSkuChange;
  final Function() onDeleteStock;
  final TextEditingController? quantityController;
  final TextEditingController? priceController;
  final TextEditingController? skuController;
  final bool isDeletable;
  final bool? isReadOnly;

  const EditableFoodStockItem({
    super.key,
    this.isReadOnly = false,
    required this.stock,
    required this.onPriceChange,
    required this.onQuantityChange,
    required this.onDeleteStock,
    required this.isDeletable,
    required this.onSkuChange,
    this.quantityController,
    this.priceController,
    this.skuController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Style.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      padding: REdgeInsets.symmetric(horizontal: 16, vertical: 16),
      margin: REdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: OutlinedBorderTextField(
                  label: '${AppHelpers.getTranslation(TrKeys.price)}*',
                  inputType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  initialText:
                      stock.price == null ? '' : stock.price.toString(),
                  onChanged: onPriceChange,
                  validator: AppValidators.emptyCheck,
                  inputFormatters: [InputFormatter.currency],
                  readOnly: isReadOnly ?? false,
                ),
              ),
              12.horizontalSpace,
              Expanded(
                child: OutlinedBorderTextField(
                  label: '${AppHelpers.getTranslation(TrKeys.quantity)}*',
                  inputType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  initialText:
                      stock.quantity == null ? '' : stock.quantity.toString(),
                  onChanged: onQuantityChange,
                  validator: AppValidators.emptyCheck,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  readOnly: isReadOnly ?? false,
                ),
              ),
              12.horizontalSpace,
              Expanded(
                child: OutlinedBorderTextField(
                  label: AppHelpers.getTranslation(TrKeys.sku),
                  textInputAction: TextInputAction.next,
                  initialText: stock.sku == null ? '' : stock.sku.toString(),
                  onChanged: onSkuChange,
                  readOnly: isReadOnly ?? false,
                ),
              ),
              if (isDeletable)
                ButtonEffectAnimation(
                  onTap: onDeleteStock,
                  child: Container(
                    width: 44.r,
                    height: 44.r,
                    margin: REdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.r),
                      color: Style.greyColor,
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      Remix.delete_bin_line,
                      size: 20.r,
                    ),
                  ),
                ),
            ],
          ),
          4.verticalSpace,
          if (stock.extras != null && (stock.extras?.isNotEmpty ?? false))
            SizedBox(
              height: 140.r,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: stock.extras?.length,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  final extras = stock.extras?[index] ?? Extras();
                  return Padding(
                    padding: REdgeInsets.only(top: 16, right: 16),
                    child: Stack(
                      children: [
                        SizedBox(
                          width: 200.w,
                          child: OutlinedBorderTextField(
                            suffixIcon:
                                extras.group?.type == ExtrasType.color.name
                                    ? ColorItem(extras: extras)
                                    : const SizedBox.shrink(),
                            label: '${extras.group?.translation?.title}',
                            initialText: AppHelpers.getNameColor(extras.value),
                            readOnly: true,
                            validator: AppValidators.emptyCheck,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          8.verticalSpace,
        ],
      ),
    );
  }
}
