import 'package:admin_desktop/application/catalogue/catalogue_state.dart';
import 'package:admin_desktop/application/create/details/create_food_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import 'package:admin_desktop/application/create/details/create_food_details_notifier.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/components/components.dart';

class ProductLeft extends StatelessWidget {
  final CreateFoodDetailsState state;
  final CreateFoodDetailsNotifier notifier;
  final CatalogueState catalogueState;

  const ProductLeft(
      {super.key,
      required this.state,
      required this.notifier,
      required this.catalogueState});

  @override
  Widget build(BuildContext context) {
    return Column(
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
                //initialText: state.mapOfDesc[state.language?.locale ?? "en"]?.first,
                inputType: TextInputType.text,
                textCapitalization: TextCapitalization.sentences,
                textInputAction: TextInputAction.next,
                onChanged: notifier.setTitle,
                validator: AppValidators.emptyCheck,
                textController: state.titleController,
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
                    maxLine: 1,
                    inputType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    onChanged: notifier.setMinQty,
                    validator: AppValidators.emptyCheck,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                ),
                12.horizontalSpace,
                Expanded(
                  child: OutlinedBorderTextField(
                    maxLine: 1,
                    label: "${AppHelpers.getTranslation(TrKeys.maxQtyAdd)}*",
                    inputType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    onChanged: notifier.setMaxQty,
                    validator: AppValidators.emptyCheck,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                ),
                12.horizontalSpace,
                Expanded(
                  child: OutlinedBorderTextField(
                    maxLine: 1,
                    label: "${AppHelpers.getTranslation(TrKeys.interval)}*",
                    inputType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    onChanged: notifier.setInterval,
                    validator: AppValidators.emptyCheck,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
                    maxLine: 1,
                    label: "${AppHelpers.getTranslation(TrKeys.ageLimit)}*",
                    inputType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    onChanged: notifier.setAgeLimit,
                    validator: AppValidators.emptyCheck,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    initialText: state.ageLimit,
                  ),
                ),
                12.horizontalSpace,
                Expanded(
                  child: OutlinedBorderTextField(
                    maxLine: 1,
                    label: "${AppHelpers.getTranslation(TrKeys.tax)}*",
                    inputType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    onChanged: notifier.setTax,
                    validator: AppValidators.emptyCheck,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    initialText: state.tax,
                  ),
                ),
                24.horizontalSpace,
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
                16.horizontalSpace,
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
                16.horizontalSpace,
              ],
            ),
          ),
        ),
        16.verticalSpace,
      ],
    );
  }
}
