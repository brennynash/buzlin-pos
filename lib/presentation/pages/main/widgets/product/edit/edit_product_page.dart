import 'package:admin_desktop/application/edit_product/stocks/edit_food_stocks_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/application/providers.dart';
import 'package:admin_desktop/domain/models/models.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/components/components.dart';
import '../../../../../styles/style.dart';
import '../whole_sale_price/whole_sale_stocks_body.dart';
import '../widgets/view_mode.dart';
import 'edit_gallery_page.dart';
import 'edit_stock_page.dart';
import 'widgets/product_left.dart';
import 'widgets/product_right.dart';

class EditProductPage extends ConsumerStatefulWidget {
  const EditProductPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditProductPageState();
}

class _EditProductPageState extends ConsumerState<EditProductPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(editFoodUnitsProvider.notifier).fetchUnits();
      ref.read(editFoodDetailsProvider.notifier)
        ..getProductDetailsByIdEdited((product) {
          ref.read(editFoodBrandProvider.notifier)
            ..setBrands(ref.watch(brandProvider).brands)
            ..setActiveBrand(product?.brand);

          ref.read(editFoodUnitsProvider.notifier).setFoodUnit(product?.unit);
          ref.read(editFoodCategoriesProvider.notifier).setInitial(
                category: product?.category,
                categories: ref.watch(foodCategoriesProvider).categories,
              );
          ref.read(editFoodStocksProvider.notifier).setInitialStocks(product);
          ref.read(editFoodStocksProvider.notifier).fetchGroups();
          ref.read(languagesProvider.notifier).getLanguages(context);
        })
        ..setLanguage(LocalStorage.getLanguage());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(editFoodDetailsProvider.notifier);
    final state = ref.watch(editFoodDetailsProvider);
    final categoryState = ref.watch(editFoodCategoriesProvider);
    final stockState = ref.watch(editFoodStocksProvider);
    final langState = ref.read(languagesProvider);
    return CustomScaffold(
      body: (colors) => Padding(
        padding: REdgeInsets.symmetric(horizontal: 12),
        child: state.isLoading
            ? const Loading()
            : Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      12.verticalSpace,
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width,
                        child: Row(
                          children: [
                            CustomBackButton(
                              onTap: () => ref
                                  .read(productProvider.notifier)
                                  .changeState(4),
                            ),
                            const Spacer(),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.r),
                                color: Style.white,
                              ),
                              width: 200,
                              child: PopupMenuButton<LanguageData>(
                                onOpened: () {
                                  notifier.setDesc();
                                },
                                splashRadius: 12.r,
                                itemBuilder: (context) {
                                  return langState.languages.map((langItem) {
                                    return PopupMenuItem<LanguageData>(
                                      value: langItem,
                                      child: Text(
                                        langItem.title ?? "",
                                        style: Style.interMedium(),
                                      ),
                                    );
                                  }).toList();
                                },
                                onSelected: (selectedLanguage) {
                                  notifier.setLanguage(selectedLanguage);
                                  notifier.setTitleAndDescState(
                                      selectedLanguage.locale ?? "en");
                                },
                                child: SelectFromButton(
                                  title: AppHelpers.getTranslation(
                                      state.language?.title ?? ""),
                                ),
                              ),
                            ),
                            20.horizontalSpace,
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                ViewMode(
                                  title:
                                      AppHelpers.getTranslation(TrKeys.product),
                                  isActive: state.stateIndex == 0,
                                  isLeft: true,
                                  onTap: () => notifier.changeState(0),
                                ),
                                ViewMode(
                                  title:
                                      AppHelpers.getTranslation(TrKeys.stock),
                                  isActive: state.stateIndex == 1,
                                  onTap: () => notifier.changeState(1),
                                ),
                                ViewMode(
                                  title: AppHelpers.getTranslation(
                                      TrKeys.wholeSale),
                                  isActive: state.stateIndex == 3,
                                  onTap: () => notifier.changeState(3),
                                ),
                                ViewMode(
                                  title:
                                      AppHelpers.getTranslation(TrKeys.gallery),
                                  isActive: state.stateIndex == 2,
                                  isRight: true,
                                  onTap: () => notifier.changeState(2),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      24.verticalSpace,
                      Center(
                        child: getSelectedWidget(state.stateIndex, state,
                            notifier, stockState, categoryState),
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget getSelectedWidget(
      int index,
      EditFoodDetailsState state,
      EditFoodDetailsNotifier notifier,
      EditFoodStocksState stockState,
      EditFoodCategoriesState categoryState) {
    switch (index) {
      case 0:
        return Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 2,
                  child: ProductLeft(
                    notifier: notifier,
                    state: state,
                  ),
                ),
                4.horizontalSpace,
                Expanded(
                  child: ProductRight(
                    state: state,
                    notifier: notifier,
                    unitsNotifier: ref.read(editFoodUnitsProvider.notifier),
                    categoryNotifier:
                        ref.read(editFoodCategoriesProvider.notifier),
                    categoryState: categoryState,
                    unitsState: ref.watch(editFoodUnitsProvider),
                    brandNotifier: ref.read(editFoodBrandProvider.notifier),
                    brandState: ref.watch(editFoodBrandProvider),
                  ),
                ),
              ],
            ),
            16.verticalSpace,
            Row(
              children: [
                SizedBox(
                  width: 150.r,
                  child: LoginButton(
                      title: AppHelpers.getTranslation(TrKeys.save),
                      isLoading: state.isLoading || stockState.isLoading,
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          notifier
                            ..setDesc()
                            ..updateProduct(context,
                                category: categoryState.selectCategory ??
                                    categoryState.oldCategory,
                                unit: ref.watch(editFoodUnitsProvider).foodUnit,
                                brand: ref
                                    .watch(editFoodBrandProvider)
                                    .selectedBrand,
                                updated: (productData) {
                              notifier.changeState(1);
                                },
                                failed: () {});
                        }
                      }),
                ),
              ],
            ),
            24.verticalSpace,
          ],
        );
      case 1:
        return EditStockPage(
          onNext: () {
            notifier.changeState(3);
          },
          editFoodDetail: state,
          editFoodDetailNotifier: notifier,
          stockState: ref.watch(editFoodStocksProvider),
          convertEvent: ref.read(convertProvider.notifier),
          convertState: ref.watch(convertProvider),
          stockEvent: ref.read(editFoodStocksProvider.notifier),
        );
      case 2:
        return const EditProductGalleryPage();
      default:
        return EditWholeSaleStocksBody(
            onNext: () {
              notifier.changeState(2);
            },
            state: ref.watch(wholeSaleProvider),
            notifier: ref.read(wholeSaleProvider.notifier),
            stockState: stockState,
            detailsState: state,
            detailsNotifier: notifier);
    }
  }
}
