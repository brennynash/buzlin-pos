import 'package:admin_desktop/domain/models/models.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';


part 'create_food_stocks_state.freezed.dart';

@freezed
class CreateFoodStocksState with _$CreateFoodStocksState {
  const factory CreateFoodStocksState({
    @Default(false) bool isLoading,
    @Default(false) bool isSaving,
    @Default(false) bool isFetchingGroups,
    String? uuid,
    @Default([]) List<Group> groups,
    @Default([]) List<Stocks> stocks,
    @Default([]) List<Stocks> updatedStocks,
    @Default([]) List<Extras> activeGroupExtras,
    @Default({}) Map<String, List<Extras?>> selectGroups,
    @Default([]) List<TextEditingController> quantityControllers,
    @Default([]) List<TextEditingController> priceControllers,
    @Default([]) List<TextEditingController> skuControllers,
  }) = _CreateFoodStocksState;

  const CreateFoodStocksState._();
}
