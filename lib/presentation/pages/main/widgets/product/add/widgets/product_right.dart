import 'package:admin_desktop/domain/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/presentation/styles/style.dart';

import 'package:admin_desktop/application/providers.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/components/components.dart';

class ProductRight extends StatelessWidget {
  final CreateFoodDetailsState state;
  final CreateFoodDetailsNotifier notifier;
  final CreateFoodUnitsNotifier unitNotifier;
  final CreateFoodUnitsState unitState;
  final CreateFoodBrandState brandState;
  final CreateFoodBrandNotifier brandNotifier;
  final AddFoodCategoriesState categoryState;
  final AddFoodCategoriesNotifier categoryNotifier;
  final CatalogueState catalogueState;

  const ProductRight(
      {super.key,
      required this.state,
      required this.notifier,
      required this.unitNotifier,
      required this.unitState,
      required this.brandState,
      required this.brandNotifier,
      required this.categoryState,
      required this.categoryNotifier,
      required this.catalogueState});

  @override
  Widget build(context) {
    return Column(
      children: [
        Container(
          padding: REdgeInsets.all(16),
          decoration: const BoxDecoration(
              color: Style.white,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (int i = 0; i < categoryState.categoryControllers.length; i++)
                Padding(
                  padding: REdgeInsets.only(top: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${AppHelpers.getTranslation(i == 0 ? TrKeys.parentCategory : i == 1 ? TrKeys.subCategory : TrKeys.productCategory)}*",
                        style: Style.interNormal(size: 14),
                      ),
                      4.verticalSpace,
                      PopupMenuButton<CategoryData>(
                        enabled: i == 0
                            ? categoryState.categories.isNotEmpty
                            : categoryState.selectCategories[i - 1].children
                                    ?.isNotEmpty ??
                                false,
                        itemBuilder: (context) {
                          return (i == 0
                                  ? categoryState.categories
                                  : categoryState
                                          .selectCategories[i - 1].children ??
                                      [])
                              .map(
                                (category) => PopupMenuItem<CategoryData>(
                                  value: category,
                                  child: Text(
                                    category.translation?.title ??
                                        AppHelpers.getTranslation(
                                            TrKeys.unKnow),
                                    style: Style.interNormal(size: 14),
                                  ),
                                ),
                              )
                              .toList();
                        },
                        onSelected: categoryNotifier.setActiveIndex,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        color: Style.white,
                        elevation: 24,
                        child: SelectFromButton(
                          title: categoryState.categoryControllers[i].text,
                        ),
                      ),
                    ],
                  ),
                ),
              if (categoryState.selectCategory == null)
                Padding(
                  padding: REdgeInsets.only(top: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${AppHelpers.getTranslation(TrKeys.category)}*",
                        style: Style.interNormal(size: 14),
                      ),
                      4.verticalSpace,
                      PopupMenuButton<CategoryData>(
                        itemBuilder: (context) {
                          return (categoryState.selectCategories.isEmpty
                                  ? categoryState.categories
                                  : categoryState
                                          .selectCategories.last.children ??
                                      [])
                              .map(
                                (category) => PopupMenuItem<CategoryData>(
                                  value: category,
                                  child: Text(
                                    category.translation?.title ??
                                        AppHelpers.getTranslation(
                                            TrKeys.unKnow),
                                    style: Style.interNormal(size: 14),
                                  ),
                                ),
                              )
                              .toList();
                        },
                        onSelected: categoryNotifier.setActiveIndex,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        color: Style.white,
                        elevation: 24,
                        child: SelectFromButton(
                          title: categoryState.oldCategory != null
                              ? categoryState.categoryController?.text ?? ""
                              : "",
                        ),
                      ),
                    ],
                  ),
                ),
              8.verticalSpace,
              Text(
                AppHelpers.getTranslation(TrKeys.brand),
                style: Style.interNormal(size: 14),
              ),
              4.verticalSpace,
              PopupMenuButton<Brand>(
                itemBuilder: (context) {
                  return brandState.brands
                      .map(
                        (brand) => PopupMenuItem<Brand>(
                          value: brand,
                          child: Text(
                            brand.title ??
                                AppHelpers.getTranslation(TrKeys.unKnow),
                            style: Style.interNormal(size: 14),
                          ),
                        ),
                      )
                      .toList();
                },
                onSelected: brandNotifier.setActiveBrand,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                color: Style.white,
                elevation: 24,
                child: SelectFromButton(
                  title: brandState.selectedBrand?.title ?? "",
                ),
              ),
              8.verticalSpace,
              Text(
                "${AppHelpers.getTranslation(TrKeys.unit)}*",
                style: Style.interNormal(size: 14),
              ),
              4.verticalSpace,
              PopupMenuButton<UnitData>(
                itemBuilder: (context) {
                  return unitState.units
                      .map(
                        (unit) => PopupMenuItem<UnitData>(
                          value: unit,
                          child: Text(
                            unit.translation?.title ?? '',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Style.black,
                              letterSpacing: -14 * 0.02,
                            ),
                          ),
                        ),
                      )
                      .toList();
                },
                onSelected: unitNotifier.setActiveIndex,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                color: Style.white,
                elevation: 24,
                child: SelectFromButton(
                  title: unitState.selectedUnit?.translation?.title ?? "",
                ),
              ),
              8.verticalSpace,
            ],
          ),
        ),
        16.verticalSpace,
        Container(
          padding: const EdgeInsets.all(16),
          width: (MediaQuery.sizeOf(context).width - 140.w) / 3 * 1,
          decoration: BoxDecoration(
              color: Style.white, borderRadius: BorderRadius.circular(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppHelpers.getTranslation(TrKeys.media),
                style: Style.interRegular(size: 16),
              ),
              12.verticalSpace,
              MultiImagePicker(
                //isCreating: true,
                listOfImages: state.images,
                imageUrls: state.listOfUrls,
                onImageChange: notifier.setImageFile,
                onDelete: notifier.deleteImage,
                onUpload: notifier.setUploadImage,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
