import 'package:admin_desktop/domain/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import 'package:admin_desktop/application/providers.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/components/components.dart';

class ProductRight extends StatelessWidget {
  final EditFoodDetailsState state;
  final EditFoodDetailsNotifier notifier;
  final EditFoodUnitsNotifier unitsNotifier;
  final EditFoodCategoriesNotifier categoryNotifier;
  final EditFoodCategoriesState categoryState;
  final EditFoodUnitsState unitsState;
  final EditFoodBrandNotifier brandNotifier;
  final EditFoodBrandState brandState;

  const ProductRight({
    super.key,
    required this.state,
    required this.notifier,
    required this.unitsNotifier,
    required this.categoryNotifier,
    required this.categoryState,
    required this.unitsState,
    required this.brandNotifier,
    required this.brandState,
  });

  @override
  Widget build(context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: Style.white, borderRadius: BorderRadius.circular(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (int i = 0;
                  i < categoryState.categoryControllers.length;
                  i++)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
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
                          borderRadius: BorderRadius.circular(8),
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
                          borderRadius: BorderRadius.circular(8),
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
                  return unitsState.units
                      .map(
                        (unit) => PopupMenuItem<UnitData>(
                          value: unit,
                          child: Text(
                            unit.translation?.title ??
                                AppHelpers.getTranslation(TrKeys.unKnow),
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
                onSelected: unitsNotifier.setFoodUnit,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                color: Style.white,
                elevation: 24,
                child: SelectFromButton(
                  title: unitsState.foodUnit?.translation?.title ??
                      unitsState.unitController?.text ??
                      AppHelpers.getTranslation(TrKeys.unKnow),
                ),
              ),
              8.verticalSpace,
            ],
          ),
        ),
        16.verticalSpace,
        Container(
          padding: REdgeInsets.all(16),
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
                imageUrls: state.listOfUrls,
                listOfImages: state.images,
                onDelete: notifier.deleteImage,
                onImageChange: notifier.setImageFile,
                onUpload: notifier.setUploadImage,
              )
            ],
          ),
        ),
      ],
    );
  }
}
