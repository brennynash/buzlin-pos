import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin_desktop/application/providers.dart';
import 'add/add_product_page.dart';
import 'brand/add/add_brand_page.dart';
import 'brand/widgets/brand_list_view.dart';
import 'category/add/create_category_page.dart';
import 'category/edit/edit_category_page.dart';
import 'category/widgets/category_list_view.dart';
import 'edit/edit_product_page.dart';
import 'widgets/product_list_view.dart';

class ProductPage extends ConsumerStatefulWidget {
  const ProductPage({this.isCatalog = false, super.key});

  final bool isCatalog;

  @override
  ConsumerState<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends ConsumerState<ProductPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(productProvider.notifier).fetchProducts(isRefresh: true);
      ref.read(foodCategoriesProvider.notifier).initialFetchCategories();
      ref.read(brandProvider.notifier)
        ..fetchBrands(context)
        ..fetchAllBrands(context: context, isRefresh: true);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(productProvider);
    return state.stateIndex == 1
        ? const AddProductPage()
        : state.stateIndex == 2
            ? const EditProductPage()
            : state.stateIndex == 5
                ? const AddBrandPage()
                : state.stateIndex == 6
                    ? const CreateCategoryPage()
                    : state.stateIndex == 7
                        ? const EditCategoryPage()
                        : state.stateIndex == 4
                            ? const ProductListView()
                            : state.stateIndex == 3
                                ? const BrandListView()
                                : const CategoryListView();
  }
}
