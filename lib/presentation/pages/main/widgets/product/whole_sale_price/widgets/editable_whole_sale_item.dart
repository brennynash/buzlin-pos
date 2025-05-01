import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remixicon_updated/remixicon_updated.dart';
import 'package:admin_desktop/domain/models/models.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/components/components.dart';
import 'package:admin_desktop/presentation/styles/style.dart';

class EditableWholeSaleItem extends StatelessWidget {
  final Stocks stock;
  final Function(String, int) onPriceChange;
  final Function(String, int) onMinQuantityChange;
  final String? Function(String?, int) onMinQuantityCheck;
  final String? Function(String?, int) onMaxQuantityCheck;
  final Function(String, int) onMaxQuantityChange;
  final Function(int) onDeleteStock;
  final Function()? onAdd;

  const EditableWholeSaleItem({
    super.key,
    required this.stock,
    required this.onPriceChange,
    required this.onMinQuantityChange,
    required this.onDeleteStock,
    required this.onMaxQuantityChange,
    required this.onMinQuantityCheck,
    required this.onMaxQuantityCheck,
    this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Style.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      margin: REdgeInsets.only(bottom: 8),
      child: ExpansionTile(
        backgroundColor: Style.white,
        initiallyExpanded: true,
        maintainState: true,
        childrenPadding: REdgeInsets.symmetric(horizontal: 16, vertical: 12),
        tilePadding: REdgeInsets.symmetric(horizontal: 16, vertical: 12),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EditableFoodStockItem(
              stock: stock,
              onPriceChange: (s) {},
              onQuantityChange: (s) {},
              onDeleteStock: () {},
              isDeletable: false,
              onSkuChange: (s) {},
              isReadOnly: true,
            ),
          ],
        ),
        children: [
          ...(stock.wholeSalePrices ?? []).asMap().entries.map((entry) {
            return _priceItem(entry.value, entry.key);
          }),
          10.verticalSpace,
          if (onAdd != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomButton(
                  width: 200,
                    // height: 36,
                    // radius: 16,
                    bgColor: Style.transparent,
                    borderColor: Style.black,
                    textColor: Style.black,
                    title: TrKeys.add,
                    onTap: () {
                      onAdd?.call();
                    }),
              ],
            ),
          10.verticalSpace
        ],
      ),
    );
  }

  _priceItem(WholeSalePrice? wholeSalePrice, int i) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: OutlinedBorderTextField(
                label: '${AppHelpers.getTranslation(TrKeys.minQuantity)}*',
                inputType: TextInputType.number,
                textInputAction: TextInputAction.next,
                initialText: "${wholeSalePrice?.minQuantity ?? ''}",
                onChanged: (s) => onMinQuantityChange(s, i),
                validator: (s) => onMinQuantityCheck(s, i),
                inputFormatters: [InputFormatter.digitsOnly],
              ),
            ),
            10.horizontalSpace,
            Expanded(
              child: OutlinedBorderTextField(
                label: '${AppHelpers.getTranslation(TrKeys.maxQuantity)}*',
                inputType: TextInputType.number,
                textInputAction: TextInputAction.next,
                initialText: "${wholeSalePrice?.maxQuantity ?? ''}",
                onChanged: (s) => onMaxQuantityChange(s, i),
                validator: (s) => onMaxQuantityCheck(s, i),
                inputFormatters: [InputFormatter.digitsOnly],
              ),
            ),
            Padding(
              padding: REdgeInsets.only(top: 30, left: 10),
              child: ButtonEffectAnimation(
                child: GestureDetector(
                  onTap: () => onDeleteStock(i),
                  child: Container(
                    width: 42.r,
                    height: 42.r,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.r),
                      color: Style.greyColor,
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      Remix.delete_bin_line,
                      size: 24.r,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        4.verticalSpace,
        OutlinedBorderTextField(
          label: '${AppHelpers.getTranslation(TrKeys.price)}*',
          inputType: TextInputType.number,
          textInputAction: TextInputAction.next,
          initialText: "${wholeSalePrice?.price ?? ''}",
          onChanged: (s) => onPriceChange(s, i),
          validator: AppValidators.emptyCheck,
          inputFormatters: [InputFormatter.currency],
        ),
        8.verticalSpace,
      ],
    );
  }
}
