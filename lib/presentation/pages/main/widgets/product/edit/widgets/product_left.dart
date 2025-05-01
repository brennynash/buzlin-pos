import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import 'package:admin_desktop/application/edit_product/details/edit_food_details_notifier.dart';
import 'package:admin_desktop/application/edit_product/details/edit_food_details_state.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/components/components.dart';

class ProductLeft extends StatelessWidget {
  final EditFoodDetailsNotifier notifier;
  final EditFoodDetailsState state;

  const ProductLeft({
    super.key,
    required this.notifier,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: REdgeInsets.all(18),
            decoration: BoxDecoration(
                color: Style.white, borderRadius: BorderRadius.circular(12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                6.verticalSpace,
                OutlinedBorderTextField(
                  label: "${AppHelpers.getTranslation(TrKeys.productTitle)}*",
                  inputType: TextInputType.text,
                  textCapitalization: TextCapitalization.sentences,
                  textInputAction: TextInputAction.next,
                  onChanged: notifier.setTitle,
                  validator: AppValidators.emptyCheck,
                  textController: state.titleController,
                  // initialText: state.title,
                ),
                8.verticalSpace,
                OutlinedBorderTextField(
                  label: "${AppHelpers.getTranslation(TrKeys.description)}*",
                  minLine: 1,
                  maxLine: 12,
                  inputType: TextInputType.text,
                  textCapitalization: TextCapitalization.sentences,
                  textInputAction: TextInputAction.next,
                  onChanged: notifier.setDescription,
                  validator: AppValidators.emptyCheck,
                  // initialText: state.description,
                  textController: state.descriptionController,
                ),
                8.verticalSpace,
              ],
            ),
          ),
          16.verticalSpace,
          Container(
            padding: REdgeInsets.all(16),
            decoration: BoxDecoration(
                color: Style.white, borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: EdgeInsets.only(bottom: 6.r),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: OutlinedBorderTextField(
                      label: "${AppHelpers.getTranslation(TrKeys.minQtyAdd)}*",
                      inputType: TextInputType.number,
                      minLine: 1,
                      textInputAction: TextInputAction.next,
                      onChanged: notifier.setMinQty,
                      validator: AppValidators.emptyCheck,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      initialText: state.minQty == 'null' || state.minQty == ''
                          ? "0"
                          : state.minQty,
                    ),
                  ),
                  12.horizontalSpace,
                  Expanded(
                    child: OutlinedBorderTextField(
                      minLine: 1,
                      label: "${AppHelpers.getTranslation(TrKeys.maxQtyAdd)}*",
                      inputType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      onChanged: notifier.setMaxQty,
                      validator: AppValidators.emptyCheck,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      initialText: state.maxQty,
                    ),
                  ),
                  12.horizontalSpace,
                  Expanded(
                    child: OutlinedBorderTextField(
                      minLine: 1,
                      label: "${AppHelpers.getTranslation(TrKeys.interval)}*",
                      inputType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      onChanged: notifier.setInterval,
                      validator: AppValidators.emptyCheck,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      initialText: state.interval,
                    ),
                  ),
                  12.horizontalSpace,
                ],
              ),
            ),
          ),
          16.verticalSpace,
          Container(
            padding: REdgeInsets.all(16),
            decoration: BoxDecoration(
                color: Style.white, borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: EdgeInsets.only(bottom: 6.r),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: OutlinedBorderTextField(
                      minLine: 1,
                      label: "${AppHelpers.getTranslation(TrKeys.ageLimit)}*",
                      inputType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      onChanged: notifier.setAgeLimit,
                      validator: AppValidators.emptyCheck,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      initialText: state.ageLimit.toString(),
                    ),
                  ),
                  12.horizontalSpace,
                  Expanded(
                    child: OutlinedBorderTextField(
                      minLine: 1,
                      label: "${AppHelpers.getTranslation(TrKeys.tax)}*",
                      inputType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      onChanged: notifier.setTax,
                      validator: AppValidators.emptyCheck,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      initialText: state.tax,
                    ),
                  ),
                  12.horizontalSpace,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        AppHelpers.getTranslation(TrKeys.active),
                        style: GoogleFonts.inter(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                      6.verticalSpace,
                      CustomToggle(
                        controller: ValueNotifier(state.active),
                        onChange: notifier.setActive,
                      ),
                    ],
                  ),
                  12.horizontalSpace,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        AppHelpers.getTranslation(TrKeys.digital),
                        style: GoogleFonts.inter(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                      6.verticalSpace,
                      CustomToggle(
                        controller: ValueNotifier(state.digital),
                        onChange: notifier.setDigital,
                      ),
                    ],
                  ),
                  12.horizontalSpace,
                ],
              ),
            ),
          ),
          16.verticalSpace,
        ],
      ),
    );
  }
}
