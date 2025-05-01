import 'package:admin_desktop/application/create/stocks/create_food_stocks_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/application/providers.dart';
import 'package:admin_desktop/domain/models/models.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/components/components.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import '../whole_sale_price/create_whole_sale_stocks_body.dart';
import '../widgets/view_mode.dart';
import 'add_gallery_page.dart';
import 'add_stock_page.dart';
import 'widgets/product_left.dart';
import 'widgets/product_right.dart';

class AddProductPage extends ConsumerStatefulWidget {
  const AddProductPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddProductPageState();
}

class _AddProductPageState extends ConsumerState<AddProductPage>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(createFoodStocksProvider.notifier).setInitialStocks();
      ref.read(createFoodDetailsProvider.notifier).clearAll();
      ref.read(createFoodUnitsProvider.notifier).fetchUnits(context);
      ref
          .read(addFoodCategoriesProvider.notifier)
          .setCategories(ref.watch(foodCategoriesProvider).categories);
      ref
          .read(createFoodBrandProvider.notifier)
          .setBrands(ref.watch(brandProvider).brands);
      ref.read(languagesProvider.notifier).getLanguages(context);
    });
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(createFoodDetailsProvider.notifier);
    final state = ref.watch(createFoodDetailsProvider);
    final langState = ref.watch(languagesProvider);
    final stockState = ref.watch(createFoodStocksProvider);
    return CustomScaffold(
      body: (colors) => Padding(
        padding: REdgeInsets.symmetric(horizontal: 12),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                12.verticalSpace,
                SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  child: Row(
                    children: [
                      CustomBackButton(onTap: () {
                        ref.read(productProvider.notifier).changeState(4);
                        notifier.changeState(0);
                      }),
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
                            title: AppHelpers.getTranslation(TrKeys.product),
                            isActive: state.stateIndex == 0,
                            isLeft: true,
                            onTap: () {
                              // notifier.changeState(0);
                            },
                          ),
                          ViewMode(
                            title: AppHelpers.getTranslation(TrKeys.stock),
                            isActive: state.stateIndex == 1,
                            onTap: () {
                              // notifier.changeState(1);
                            },
                          ),
                          ViewMode(
                            title: AppHelpers.getTranslation(TrKeys.wholeSale),
                            isActive: state.stateIndex == 3,
                            onTap: () {
                              // notifier.changeState(3);
                            },
                          ),
                          ViewMode(
                            title: AppHelpers.getTranslation(TrKeys.gallery),
                            isActive: state.stateIndex == 2,
                            isRight: true,
                            onTap: () {
                              // notifier.changeState(2);
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                24.verticalSpace,
                getSelectedWidget(state.stateIndex, state, notifier, stockState)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getSelectedWidget(int index, CreateFoodDetailsState state,
      CreateFoodDetailsNotifier notifier, CreateFoodStocksState stockState) {
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
                    state: state,
                    notifier: notifier,
                    catalogueState: ref.watch(catalogueProvider),
                  ),
                ),
                4.horizontalSpace,
                Expanded(
                  child: ProductRight(
                    state: state,
                    notifier: notifier,
                    unitNotifier: ref.read(createFoodUnitsProvider.notifier),
                    unitState: ref.watch(createFoodUnitsProvider),
                    brandState: ref.watch(createFoodBrandProvider),
                    brandNotifier: ref.read(createFoodBrandProvider.notifier),
                    categoryState: ref.watch(addFoodCategoriesProvider),
                    categoryNotifier:
                        ref.read(addFoodCategoriesProvider.notifier),
                    catalogueState: ref.watch(catalogueProvider),
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
                      isLoading: state.isCreating || stockState.isLoading,
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          notifier
                            ..setDesc()
                            ..createProduct(context,
                                categoryId: ref
                                    .watch(addFoodCategoriesProvider)
                                    .selectCategory
                                    ?.id,
                                unitId: ref
                                    .watch(createFoodUnitsProvider)
                                    .selectedUnit
                                    ?.id,
                                brandId: ref
                                    .watch(createFoodBrandProvider)
                                    .selectedBrand
                                    ?.id, created: (uuid) {
                              if (ref
                                      .watch(createFoodDetailsProvider)
                                      .createdProduct
                                      ?.digital ??
                                  false) {
                                ref
                                    .read(productProvider.notifier)
                                    .changeState(4);
                              } else {
                                ref
                                    .read(createFoodStocksProvider.notifier)
                                    .setUuid(uuid);
                                notifier.changeState(1);
                              }
                            }, onError: () {});
                        }
                      }),
                ),
              ],
            ),
            24.verticalSpace,
          ],
        );
      case 1:
        return AddStockPage(
          onNext: () {
            notifier.changeState(3);
          },
          detailState: state,
          stockState: stockState,
          stockEvent: ref.read(createFoodStocksProvider.notifier),
          productState: ref.watch(productProvider),
          productNotifier: ref.read(productProvider.notifier),
          convertState: ref.watch(convertProvider),
          convertNotifier: ref.read(convertProvider.notifier),
          productGalleryNotifier:
              ref.read(createProductGalleryProvider.notifier),
        );
      case 2:
        return CreateProductGalleryBody(
          state: ref.watch(createProductGalleryProvider),
          notifier: ref.read(createProductGalleryProvider.notifier),
          stockState: stockState,
        );
      default:
        return CreateWholeSaleStocksBody(
            onNext: () {
              notifier.changeState(2);
            },
            notifier: ref.read(wholeSaleProvider.notifier),
            state: ref.watch(wholeSaleProvider),
            stockState: stockState,
            productNotifier: ref.read(productProvider.notifier),
            detailState: state);
    }
  }
}
