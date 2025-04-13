import 'dart:async';
import 'package:admin_desktop/domain/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/repository/repository.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'product_state.dart';

class ProductNotifier extends StateNotifier<ProductState> {
  final ProductsRepository productRepository;
  int _page = 0;
  Timer? _refreshTime;

  ProductNotifier(this.productRepository) : super(const ProductState());

  changeFilter() {
    state = state.copyWith(showFilter: !state.showFilter);
  }
  void changeState(int index) {
    state = state.copyWith(stateIndex: index);
  }
  void changeTabIndex(int index, ProductStatus? status) {
    state = state.copyWith(selectTabIndex: index, selectProducts: []);


    fetchProducts(isRefresh: true, status: status);
  }



  Future<void> changeActive(String uuid) async {
    state = state.copyWith(isLoading: true);
    final response = await productRepository.changeActive(uuid);
    response.when(success: (success) {
      List<ProductData> list = List.from(state.products);
      int index = list.indexWhere((element) => element.uuid == uuid);

      list[index] =
          list[index].copyWith(active: !(list[index].active ?? false));
      state = state.copyWith(products: list,isLoading: false);
    }, failure: (failure, status) {
      state = state.copyWith(isLoading: false);
      // AppHelpers.showSnackBar(
      //   context,
      //   failure,
      // );
    });
  }

  void allSelectOrder(List<ProductData> orderList) {
    List list = [];
    if (!state.isAllSelect) {
      for (int i = 0; i < orderList.length; i++) {
        list.add(orderList[i].id);
      }
      state = state.copyWith(isAllSelect: true);
    } else {
      state = state.copyWith(isAllSelect: false);
    }
    state = state.copyWith(selectProducts: list);
  }

  void addSelectOrder({int? id, required int orderLength}) {
    List list = List.from(state.selectProducts);
    if (state.selectProducts.contains(id)) {
      list.remove(id);
    } else {
      list.add(id ?? 0);
    }
    state = state.copyWith(selectProducts: list);

    if (list.length == orderLength) {
      state = state.copyWith(isAllSelect: true);
    } else {
      state = state.copyWith(isAllSelect: false);
    }
  }

  Future<void> fetchProducts({
    bool isRefresh = false,
    VoidCallback? checkYourNetwork,
    Function(int)? updateTotal,
    DateTime? start,
    DateTime? end,
    ProductStatus? status,
  }) async {
    if (isRefresh) {
      _page = 0;
      state = state.copyWith(hasMore: true, products: []);
      _refreshTime?.cancel();
    }
    if (!state.hasMore) {
      return;
    }
    state = state.copyWith(isLoading: true, totalCount: 0);
    final response = await productRepository.getProducts(
      shopId: LocalStorage.getUser()?.shop?.id,
      status: status,
      page: ++_page,
      query: state.query.isEmpty ? null : state.query,
      categoryId: state.selectCategory?.id == null ? null : state.selectCategory!.id,
      brandId: state.selectBrand?.id == null ? null : state.selectBrand!.id,
      // needAddons: true
    );
    response.when(
      success: (data) {
        List<ProductData> products = isRefresh || (state.query.isNotEmpty)
            ? []
            : List.from(state.products);
        final List<ProductData> newOrders = data.data ?? [];
        for (ProductData element in newOrders) {
          if (!products.map((item) => item.id).contains(element.id)) {
            products.add(element);
          }
        }
        state =
            state.copyWith(hasMore: newOrders.length >= (end == null ? 12 : 15));
        if (_page == 1 && !isRefresh) {
          state = state.copyWith(
            isLoading: false,
            products: products,
            totalCount: data.meta?.total ?? 0,
          );
          updateTotal?.call(data.meta?.total ?? 0);
        } else {
          state = state.copyWith(
            isLoading: false,
            products: products,
            totalCount: data.meta?.total ?? 0,
          );
          updateTotal?.call(data.meta?.total ?? 0);
        }
      },
      failure: (failure, status) {
        _page--;
        if (_page == 0) {
          state = state.copyWith(isLoading: false);
        }
      },
    );
  }

  deleteProduct(BuildContext context, int? id) async {
    state = state.copyWith(isLoading: true);
    final response = await productRepository.deleteProduct(id);
    response.when(
      success: (success) {
        List<ProductData> list = List.from(state.products);
        list.removeWhere((element) => element.id == id);
        state = state.copyWith(products: list);
        AppHelpers.showSnackBar(
            context, AppHelpers.getTranslation(TrKeys.deleted),
            isIcon: true);
      },
      failure: (failure, status) {
        AppHelpers.showSnackBar(
            context, AppHelpers.getTranslation(TrKeys.deleted));
      },
    );
    state = state.copyWith(isLoading: false);
  }

  void setCategory(CategoryData value) {
    state = state.copyWith(selectCategory: value);
    fetchProducts(isRefresh: true);
  }

  void setBrand(Brand value) {
    state = state.copyWith(selectBrand: value);
    fetchProducts(isRefresh: true);
  }

  void setQuery(String query) {
    state = state.copyWith(query: query);
    fetchProducts(isRefresh: true);
  }

  void clearAll() {
    changeTabIndex(0, null);
    state = state.copyWith(selectBrand: null, selectCategory: null);
  }
}
