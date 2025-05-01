import 'package:admin_desktop/domain/models/models.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_state.freezed.dart';

@freezed
class ProductState with _$ProductState {
  const factory ProductState({
    @Default(false) bool isLoading,
    @Default(true) bool hasMore,
    @Default(false) bool showFilter,
    @Default(false) bool isAllSelect,
    @Default(0) int selectTabIndex,
    @Default([]) List selectProducts,
    @Default(null) DateTime? selectDateTime,
    @Default(null) TimeOfDay? selectTimeOfDay,
    @Default([]) List<ProductData> products,
    @Default(null) Brand? selectBrand,
    @Default(null) CategoryData? selectCategory,
    @Default(4) int stateIndex,
    @Default('') String query,
    @Default(0) int totalCount,
  }) = _ProductState;

  const ProductState._();
}
