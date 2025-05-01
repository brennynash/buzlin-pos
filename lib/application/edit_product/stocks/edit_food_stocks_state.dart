import 'package:admin_desktop/domain/models/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';


part 'edit_food_stocks_state.freezed.dart';

@freezed
class EditFoodStocksState with _$EditFoodStocksState {
  const factory EditFoodStocksState({
    @Default(false) bool isLoading,
    @Default(false) bool isSaving,
    @Default(false) bool isFetchingGroups,
    @Default(null) ProductData? product,
    @Default([]) List<int> deleteStocks,
    @Default([]) List<Group> groups,
    @Default([]) List<Stocks> stocks,
    @Default([]) List<Extras> activeGroupExtras,
    @Default([]) List<TextEditingController> quantityControllers,
    @Default([]) List<TextEditingController> priceControllers,
    @Default([]) List<TextEditingController> skuControllers,
    @Default({}) Map<String, List<Extras?>> selectGroups,
  }) = _EditFoodStocksState;

  const EditFoodStocksState._();
}
