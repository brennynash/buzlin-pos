import 'dart:async';
import 'package:admin_desktop/presentation/routes/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/models.dart';
import '../../domain/repository/repository.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'main_state.dart';

class MainNotifier extends StateNotifier<MainState> {
  final ProductsRepository _productsRepository;
  final CategoriesRepository _categoriesRepository;
  final BrandsRepository _brandsRepository;
  final UsersFacade _usersRepository;
  final ShopsRepository _shopsRepository;

  Timer? _searchProductsTimer;
  Timer? _searchCategoriesTimer;
  Timer? _searchBrandsTimer;
  int _page = 0;

  MainNotifier(
    this._productsRepository,
    this._categoriesRepository,
    this._brandsRepository,
    this._usersRepository,
    this._shopsRepository,
  ) : super(const MainState());

  changeIndex(int index) {
    state = state.copyWith(selectIndex: index);
  }

  changeActive() => state = state.copyWith(active: !state.active);

  setOrder(OrderData? order) {
    state = state.copyWith(selectedOrder: order);
  }

  setPriceDate(PriceData? priceDate) {
    state = state.copyWith(priceDate: priceDate);
  }

  Future<void> fetchMyShop({VoidCallback? afterFetched}) async {
    final response = await _shopsRepository.getMyShop();
    response.when(
      success: (data) async {
        await LocalStorage.setShop(data.data);
        state = state.copyWith(shop: data.data);
        afterFetched?.call();
      },
      failure: (failure, status) {
        state = state.copyWith(shop: LocalStorage.getShop());
        afterFetched?.call();
        debugPrint('==> error with fetching my shop $failure');
        // AppHelpers.showSnackBar(
        //   context,
        //   failure,
        // );
      },
    );
  }

  Future<void> fetchUserDetail({required VoidCallback onSuccess}) async {
    state = state.copyWith(isProductsLoading: true, products: []);
    final response = await _usersRepository.getProfileDetails();
    response.when(
      success: (data) async {
        await LocalStorage.setUser(data.data);
        onSuccess();
      },
      failure: (failure, status) {
        debugPrint('==> get user detail failure: $failure');
        // AppHelpers.showSnackBar(
        //   context,
        //   failure,
        // );
      },
    );
  }

  Future<void> fetchProducts({
    VoidCallback? checkYourNetwork,
    bool? isRefresh,
  }) async {
    if (isRefresh ?? false) {
      _page = 0;
    } else if (!state.hasMore) {
      return;
    }
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      if (_page == 0) {
        state = state.copyWith(isProductsLoading: true, products: []);

        final response = await _productsRepository.getProducts(
            page: ++_page,
            shopId: LocalStorage.getUser()?.shop?.id,
            query: state.query.isEmpty ? null : state.query,
            categoryId:  state.selectedCategory?.id,
            brandId: state.selectedBrand?.id,
            status: ProductStatus.published);
        response.when(
          success: (data) {
            state = state.copyWith(
              products: data.data ?? [],
              isProductsLoading: false,
            );
            if ((data.data?.length ?? 0) < 12) {
              state = state.copyWith(hasMore: false);
            }
          },
          failure: (failure, status) {
            state = state.copyWith(isProductsLoading: false);
            debugPrint('==> get products failure: $failure');
            // AppHelpers.showSnackBar(
            //   context,
            //   failure,
            // );
          },
        );
      } else {
        state = state.copyWith(isMoreProductsLoading: true);
        final response = await _productsRepository.getProducts(
            page: ++_page,
            shopId: LocalStorage.getUser()?.shop?.id,
            query: state.query.isEmpty ? null : state.query,
            categoryId: state.selectedCategory?.id,
            brandId:state.selectedBrand?.id,
            status: ProductStatus.published);
        response.when(
          success: (data) async {
            final List<ProductData> newList = List.from(state.products);
            newList.addAll(data.data ?? []);
            state = state.copyWith(
              products: newList,
              isMoreProductsLoading: false,
            );
            if ((data.data?.length ?? 0) < 12) {
              state = state.copyWith(hasMore: false);
            }
          },
          failure: (failure, status) {
            state = state.copyWith(isMoreProductsLoading: false);
            debugPrint('==> get products more failure: $failure');
            // AppHelpers.showSnackBar(
            //   context,
            //   failure,
            // );
          },
        );
      }
    } else {
      checkYourNetwork?.call();
    }
  }

  void setProductsQuery(BuildContext context, String query) {
    if (state.query == query) {
      return;
    }
    state = state.copyWith(query: query.trim());
    if (state.query.isNotEmpty) {
      if (_searchProductsTimer?.isActive ?? false) {
        _searchProductsTimer?.cancel();
      }
      _searchProductsTimer = Timer(
        const Duration(milliseconds: 500),
        () {
          state = state.copyWith(hasMore: true, products: []);
          _page = 0;
          fetchProducts(
            checkYourNetwork: () {
              AppHelpers.showSnackBar(
                context,
                AppHelpers.getTranslation(TrKeys.checkYourNetworkConnection),
              );
            },
          );
        },
      );
    } else {
      if (_searchProductsTimer?.isActive ?? false) {
        _searchProductsTimer?.cancel();
      }
      _searchProductsTimer = Timer(
        const Duration(milliseconds: 500),
        () {
          state = state.copyWith(hasMore: true, products: []);
          _page = 0;
          fetchProducts(
            checkYourNetwork: () {
              AppHelpers.showSnackBar(
                context,
                AppHelpers.getTranslation(TrKeys.checkYourNetworkConnection),
              );
            },
          );
        },
      );
    }
  }

  Future<void> fetchCategories(
      {required BuildContext context, VoidCallback? checkYourNetwork}) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(
        isCategoriesLoading: true,
        dropDownCategories: [],
        categories: [],
      );
      final response = await _categoriesRepository.searchCategories(
          state.categoryQuery.isEmpty ? null : state.categoryQuery);
      response.when(
        success: (data) async {
          final List<CategoryData> categories = data.data ?? [];
          state = state.copyWith(
            isCategoriesLoading: false,
            categories: categories,
          );
        },
        failure: (failure, status) {
          state = state.copyWith(isCategoriesLoading: false);
          if (status == 401) {
            context.replaceRoute(const LoginRoute());
            LocalStorage.clearStore();
          }
        },
      );
    } else {
      checkYourNetwork?.call();
    }
  }

  void setCategoriesQuery(BuildContext context, String query) {
    debugPrint('===> set categories query: $query');
    if (state.categoryQuery == query) {
      return;
    }
    state = state.copyWith(categoryQuery: query.trim());
    if (_searchCategoriesTimer?.isActive ?? false) {
      _searchCategoriesTimer?.cancel();
    }
    _searchCategoriesTimer = Timer(
      const Duration(milliseconds: 500),
      () {
        state = state.copyWith(categories: [], dropDownCategories: []);
        fetchCategories(
          context: context,
          checkYourNetwork: () {
            AppHelpers.showSnackBar(
              context,
              AppHelpers.getTranslation(TrKeys.checkYourNetworkConnection),
            );
          },
        );
      },
    );
  }

  void setSelectedCategory(BuildContext context, int index) {
    if (index == -1) {
      state = state.copyWith(selectedCategory: null, hasMore: true);
    } else {
      final category = state.categories[index];
      if (category.id != state.selectedCategory?.id) {
        state = state.copyWith(selectedCategory: category, hasMore: true);
      } else {
        state = state.copyWith(selectedCategory: null, hasMore: true);
      }
    }

    _page = 0;
    fetchProducts(
      checkYourNetwork: () {
        AppHelpers.showSnackBar(
          context,
          AppHelpers.getTranslation(TrKeys.checkYourNetworkConnection),
        );
      },
    );
    setCategoriesQuery(context, '');
  }

  void removeSelectedCategory(BuildContext context) {
    state = state.copyWith(selectedCategory: null, hasMore: true);
    _page = 0;
    fetchProducts(
      checkYourNetwork: () {
        AppHelpers.showSnackBar(
          context,
          AppHelpers.getTranslation(TrKeys.checkYourNetworkConnection),
        );
      },
    );
  }

  Future<void> fetchBrands({VoidCallback? checkYourNetwork}) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(
        isBrandsLoading: true,
        dropDownBrands: [],
        brands: [],
      );
      final response = await _brandsRepository
          .searchBrands(state.brandQuery.isEmpty ? null : state.brandQuery);
      response.when(
        success: (data) async {
          final List<Brand> brands = data.data ?? [];
          List<DropDownItemData> dropdownBrands = [];
          for (int i = 0; i < brands.length; i++) {
            dropdownBrands.add(
              DropDownItemData(
                index: i,
                title: brands[i].title ?? 'No category title',
              ),
            );
          }
          state = state.copyWith(
            isBrandsLoading: false,
            brands: brands,
            dropDownBrands: dropdownBrands,
          );
        },
        failure: (failure, status) {
          state = state.copyWith(isBrandsLoading: false);
          debugPrint('==> get brands failure: $failure');
          // AppHelpers.showSnackBar(
          //   context,
          //   failure,
          // );
        },
      );
    } else {
      checkYourNetwork?.call();
    }
  }

  void setBrandsQuery(BuildContext context, String query) {
    if (state.brandQuery == query) {
      return;
    }
    state = state.copyWith(brandQuery: query.trim());
    if (_searchBrandsTimer?.isActive ?? false) {
      _searchBrandsTimer?.cancel();
    }
    _searchBrandsTimer = Timer(
      const Duration(milliseconds: 500),
      () {
        state = state.copyWith(brands: [], dropDownBrands: []);
        fetchBrands(
          checkYourNetwork: () {
            AppHelpers.showSnackBar(
              context,
              AppHelpers.getTranslation(TrKeys.checkYourNetworkConnection),
            );
          },
        );
      },
    );
  }

  void setSelectedBrand(BuildContext context, int index) {
    final brand = state.brands[index];
    state = state.copyWith(selectedBrand: brand, hasMore: true);
    _page = 0;
    fetchProducts(
      checkYourNetwork: () {
        AppHelpers.showSnackBar(
          context,
          AppHelpers.getTranslation(TrKeys.checkYourNetworkConnection),
        );
      },
    );
    setBrandsQuery(context, '');
  }

  void removeSelectedBrand(BuildContext context) {
    state = state.copyWith(selectedBrand: null, hasMore: true);
    _page = 0;
    fetchProducts(
      checkYourNetwork: () {
        AppHelpers.showSnackBar(
          context,
          AppHelpers.getTranslation(TrKeys.checkYourNetworkConnection),
        );
      },
    );
  }
}
