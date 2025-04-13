import 'package:admin_desktop/application/product/product_notifier.dart';
import 'package:admin_desktop/application/product/product_state.dart';
import 'package:admin_desktop/presentation/assets.dart';
import 'package:admin_desktop/domain/models/models.dart';
import 'package:admin_desktop/presentation/components/buttons/custom_refresher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:remixicon_updated/remixicon_updated.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import 'package:lottie/lottie.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/components/components.dart';
import 'package:admin_desktop/application/brand/brand_provider.dart';
import 'package:admin_desktop/application/food_category/food_categories_provider.dart';
import 'package:admin_desktop/application/product/product_provider.dart';
import 'product_popup_item.dart';

part 'list_item.dart';

part 'list_main_item.dart';

part 'list_top_bar.dart';

class ProductListView extends ConsumerStatefulWidget {
  const ProductListView({super.key});

  @override
  ConsumerState<ProductListView> createState() => _ProductListViewState();
}

class _ProductListViewState extends ConsumerState<ProductListView> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(productProvider);
    final notifier = ref.read(productProvider.notifier);
    return CustomScaffold(
      body: (c) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _appBar(),
            16.verticalSpace,
            Row(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ListTopBar(
                          title: TrKeys.all,
                          count: state.totalCount,
                          onRefresh: () =>
                              notifier.fetchProducts(isRefresh: true),
                          isLoading: state.isLoading,
                          isActive: state.selectTabIndex == 0,
                          onTap: () => notifier.changeTabIndex(0, null),
                        ),
                        8.horizontalSpace,
                        ListTopBar(
                          title: TrKeys.published,
                          count: state.totalCount,
                          onRefresh: () {
                            notifier.fetchProducts(
                                isRefresh: true,
                                status: ProductStatus.published);
                          },
                          isLoading: state.isLoading,
                          isActive: state.selectTabIndex == 1,
                          onTap: () => notifier.changeTabIndex(
                              1, ProductStatus.published),
                        ),
                        8.horizontalSpace,
                        ListTopBar(
                          title: TrKeys.pending,
                          count: state.totalCount,
                          onRefresh: () {
                            notifier.fetchProducts(
                                isRefresh: true, status: ProductStatus.pending);
                          },
                          isLoading: state.isLoading,
                          isActive: state.selectTabIndex == 2,
                          onTap: () =>
                              notifier.changeTabIndex(2, ProductStatus.pending),
                        ),
                        8.horizontalSpace,
                        ListTopBar(
                          title: TrKeys.unpublished,
                          count: state.totalCount,
                          onRefresh: () {
                            notifier.fetchProducts(
                                isRefresh: true,
                                status: ProductStatus.unpublished);
                          },
                          isLoading: state.isLoading,
                          isActive: state.selectTabIndex == 3,
                          onTap: () => notifier.changeTabIndex(
                              3, ProductStatus.unpublished),
                        ),
                      ],
                    ),
                  ),
                ),
                LoginButton(
                  icon: const Icon(
                    Icons.add,
                    size: 24,
                    color: Style.white,
                  ),
                  title: TrKeys.addProduct,
                  onPressed: () => notifier.changeState(1),
                ),
              ],
            ),
            Expanded(
              child: state.selectTabIndex == 0
                  ? ListMainItem(
                      hasMore: state.hasMore,
                      onViewMore: () => notifier.fetchProducts(),
                      isLoading: state.isLoading,
                      notifier: notifier,
                      state: state,
                    )
                  : state.selectTabIndex == 1
                      ? ListMainItem(
                          hasMore: state.hasMore,
                          onViewMore: () {
                            notifier.fetchProducts(
                              status: ProductStatus.published,
                            );
                          },
                          isLoading: state.isLoading,
                          notifier: notifier,
                          state: state,
                        )
                      : state.selectTabIndex == 2
                          ? ListMainItem(
                              hasMore: state.hasMore,
                              onViewMore: () {
                                notifier.fetchProducts(
                                  status: ProductStatus.pending,
                                );
                              },
                              isLoading: state.isLoading,
                              notifier: notifier,
                              state: state,
                            )
                          : ListMainItem(
                              hasMore: state.hasMore,
                              onViewMore: () {
                                notifier.fetchProducts(
                                  status: ProductStatus.unpublished,
                                );
                              },
                              isLoading: state.isLoading,
                              notifier: notifier,
                              state: state,
                            ),
            ),
          ],
        ),
      ),
    );
  }

  _appBar() {
    final categoriesState = ref.watch(foodCategoriesProvider);
    final notifier = ref.read(productProvider.notifier);
    final brandState = ref.watch(brandProvider);
    final state = ref.watch(productProvider);
    return Container(
      padding: REdgeInsets.symmetric(vertical: 10, horizontal: 16),
      decoration: const BoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  AppHelpers.getTranslation(TrKeys.products),
                  style: Style.interMedium(size: 20),
                ),
              ),
              CustomRefresher(
                onTap: () {
                  notifier
                    ..clearAll()
                    ..fetchProducts(isRefresh: true);
                },
                isLoading: state.isLoading,
              ),
              16.horizontalSpace,
              SizedBox(
                width: 200.r,
                child: PopupMenuButton<CategoryData>(
                  itemBuilder: (context) {
                    return categoriesState.categories
                        .map(
                          (category) => PopupMenuItem<CategoryData>(
                            value: category,
                            child: Text(
                              category.translation?.title ?? '',
                              style: Style.interNormal(size: 14),
                            ),
                          ),
                        )
                        .toList();
                  },
                  onSelected: notifier.setCategory,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  color: Style.white,
                  elevation: 24,
                  child: SelectFromButton(
                    title: state.selectCategory?.translation?.title ??
                        AppHelpers.getTranslation(TrKeys.category),
                  ),
                ),
              ),
              8.horizontalSpace,
              SizedBox(
                width: 200.r,
                child: PopupMenuButton<Brand>(
                  padding: EdgeInsets.zero,
                  itemBuilder: (context) {
                    return brandState.brands
                        .map(
                          (brand) => PopupMenuItem<Brand>(
                            value: brand,
                            child: Text(
                              brand.title ?? '',
                              style: Style.interNormal(size: 14),
                            ),
                          ),
                        )
                        .toList();
                  },
                  onSelected: notifier.setBrand,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  color: Style.white,
                  elevation: 24,
                  child: SelectFromButton(
                    title: state.selectBrand?.title ??
                        AppHelpers.getTranslation(TrKeys.brand),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
