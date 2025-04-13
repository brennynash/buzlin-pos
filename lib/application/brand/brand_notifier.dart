// ignore_for_file: sdk_version_since
import 'dart:async';
import 'package:admin_desktop/domain/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/repository/repository.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'brand_state.dart';

class BrandNotifier extends StateNotifier<BrandState> {
  final BrandsRepository _brandsRepository;
  int _page = 0;

  BrandNotifier(this._brandsRepository) : super(const BrandState());

  Future<void> fetchBrands(BuildContext context) async {
    final response = await _brandsRepository.getBrands(isActive: true);
    response.when(
      success: (data) {
        state = state.copyWith(brands: data.data ?? []);
      },
      failure: (failure, status) {
        AppHelpers.showSnackBar(context, failure.toString());
        debugPrint('====> fetch brands fail $failure');
      },
    );
  }

  fetchAllBrands({
    BuildContext? context,
    bool? isRefresh,
  }) async {
    if (isRefresh ?? false) {
      _page = 0;
      state = state.copyWith(allBrands: []);
      state = state.copyWith(hasMore: true);
    }
    state = state.copyWith(isLoading: true);

    final res = await _brandsRepository.getBrands(
      page: ++_page,
      isActive: false,
    );
    res.when(success: (data) {
      List<Brand> list = List.from(state.allBrands);
      list.addAll(data.data ?? []);
      state = state.copyWith(isLoading: false, allBrands: list);
      if (isRefresh ?? false) {
        state = state.copyWith(hasMore: true);
        return;
      } else if ((data.data?.isEmpty ?? true) ||
          data.meta?.total == list.length) {
        state = state.copyWith(hasMore: false);
        return;
      }
      state = state.copyWith(hasMore: true);
      return;
    }, failure: (failure, status) {
      state = state.copyWith(isLoading: false);
      debugPrint(" ==> fetch all brands fail: $failure");
      if (context != null) {
        AppHelpers.showSnackBar(context, status.toString());
      }
    });
  }

  setAllBrands(Brand? brand) async {
    if (brand != null) {
      List<Brand> list = List.from(state.allBrands);
      list.removeWhere((element) => element.id == brand.id);
      list.insert(0,brand);
      state = state.copyWith(isLoading: false, allBrands: list);
    }
  }

  void allSelectOrder(List<Brand> brandList) {
    List list = [];
    if (!state.isAllSelect) {
      for (int i = 0; i < brandList.length; i++) {
        list.add(brandList[i].id);
      }
      state = state.copyWith(isAllSelect: true);
    } else {
      state = state.copyWith(isAllSelect: false);
    }
    state = state.copyWith(selectBrands: list);
  }

  void addSelectOrder({int? id, required int orderLength}) {
    List list = List.from(state.selectBrands);
    if (state.selectBrands.contains(id)) {
      list.remove(id);
    } else {
      list.add(id ?? 0);
    }
    state = state.copyWith(selectBrands: list);

    if (list.length == orderLength) {
      state = state.copyWith(isAllSelect: true);
    } else {
      state = state.copyWith(isAllSelect: false);
    }
  }
}
