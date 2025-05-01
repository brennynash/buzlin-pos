import 'package:admin_desktop/domain/models/models.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../../../../domain/repository/repository.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'service_categories_state.dart';

class ServiceCategoriesNotifier extends StateNotifier<ServiceCategoriesState> {
  final CategoriesRepository _catalogRepository;
  int _page = 0;

  // bool _hasMore = true;

  ServiceCategoriesNotifier(this._catalogRepository)
      : super(const ServiceCategoriesState());

  Future<void> initialFetchCategories() async {
    _page = 0;
    // _hasMore = true;
    state = state.copyWith(categories: [], isLoading: true);
    final response =
        await _catalogRepository.getCategories(page: ++_page, type: 'service');
    response.when(
      success: (data) {
        final List<CategoryData> categories = data.data ?? [];
        // _hasMore = categories.length == data.meta?.total;
        state = state.copyWith(categories: categories, isLoading: false);
      },
      failure: (failure, status) {
        debugPrint('====> initial fetch categories fail $failure');
        _page--;
        state = state.copyWith(isLoading: false);
      },
    );
  }

  updateCategories(CategoryData? category) {
    if (category == null) {
      return;
    }
    final List<CategoryData> categories = List.from(state.categories);
    categories.removeWhere((element) => element.id == category.id);
    categories.add(category);
    state = state.copyWith(categories: categories, isLoading: false);
  }

  addCategories(CategoryData? category) {
    if (category == null) {
      return;
    }
    final List<CategoryData> categories = List.from(state.categories);
    categories.add(category);
    state = state.copyWith(categories: categories, isLoading: false);
  }

  fetchCategories({
    required BuildContext context,
    bool? isRefresh,
    RefreshController? controller,
  }) async {
    if (isRefresh ?? false) {
      controller?.resetNoData();
      _page = 0;
      state = state.copyWith(categories: [], isLoading: true);
    }
    final res = await _catalogRepository.getCategories(
        page: ++_page,
        status: CategoryStatus.published,
        active: true,
        type: TrKeys.service);
    res.when(success: (data) {
      List<CategoryData> list = List.from(state.categories);
      list.addAll(data.data ?? []);
      state = state.copyWith(isLoading: false, categories: list);
      if (isRefresh ?? false) {
        controller?.refreshCompleted();
        return;
      } else if (data.data?.isEmpty ?? true) {
        controller?.loadNoData();
        return;
      }
      controller?.loadComplete();
      return;
    }, failure: (failure, status) {
      state = state.copyWith(isLoading: false);
      AppHelpers.errorSnackBar(context, text: failure);
    });
  }

  // void allSelectOrder(List<CategoryData> orderList) {
  //   List list = [];
  //   if (!state.isAllSelect) {
  //     for (int i = 0; i < orderList.length; i++) {
  //       list.add(orderList[i].id);
  //     }
  //     state = state.copyWith(isAllSelect: true);
  //   } else {
  //     state = state.copyWith(isAllSelect: false);
  //   }
  //   state = state.copyWith(selectCategories: list);
  // }

  void addSelectOrder({int? id, required int orderLength}) {
    List<int> list = List.from(state.selectCategories);
    if (state.selectCategories.contains(id)) {
      list.remove(id);
    } else {
      list.add(id ?? 0);
    }
    state = state.copyWith(selectCategories: list);

    if (list.length == orderLength) {
      state = state.copyWith(isAllSelect: true);
    } else {
      state = state.copyWith(isAllSelect: false);
    }
  }

  onTapParent(int? id) {
    if (id == null) {
      return;
    }
    List<int> list = List.from(state.selectParents);
    if (list.contains(id)) {
      list.remove(id);
    } else {
      list.add(id);
    }
    state = state.copyWith(selectParents: list, selectSubs: []);
  }

  onTapSub(int? id) {
    if (id == null) {
      return;
    }
    List<int> list = List.from(state.selectSubs);
    if (list.contains(id)) {
      list.remove(id);
    } else {
      list.add(id);
    }
    state = state.copyWith(selectSubs: list);
  }
}
