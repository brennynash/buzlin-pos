import 'package:admin_desktop/domain/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin_desktop/domain/repository/repository.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'create_food_stocks_state.dart';

class CreateFoodStocksNotifier extends StateNotifier<CreateFoodStocksState> {
  final ProductsRepository _productsRepository;

  CreateFoodStocksNotifier(this._productsRepository)
      : super(const CreateFoodStocksState());
  List<Stocks> _localStocks = [];

  void toggleCheckedGroup(int groupIndex) {
    List<Group> groups = List.from(state.groups);
    final bool check =
    state.selectGroups.containsKey(groups[groupIndex].translation?.title);
    groups[groupIndex] = groups[groupIndex].copyWith(isChecked: check);
    state = state.copyWith(groups: groups);
  }
  void setUuid(String? value){
    state = state.copyWith(uuid: value);
  }

  Future<void> setActiveExtrasIndex({
    required int itemIndex,
    required int groupIndex,
  }) async {
    List<TextEditingController> tempQuantity =
    List.from(state.skuControllers);
    List<TextEditingController> tempSku =
    List.from(state.skuControllers);
    List<TextEditingController> tempPrice =
    List.from(state.skuControllers);
    String key = state.groups[groupIndex].translation?.title ?? '';
    Extras extras = state.groups[groupIndex].fetchedExtras![itemIndex];
    Map<String, List<Extras>> selectGroups = Map.from(state.selectGroups);
    if (selectGroups.containsKey(key)) {
      List<Extras> list = selectGroups[key] ?? [];
      if (list.any((element) => element.id == extras.id)) {
        list.removeWhere((element) => element.id == extras.id);
        list.isEmpty ? selectGroups.remove(key) : selectGroups[key] = list;
      } else {
        tempQuantity.add(TextEditingController());
        tempPrice.add(TextEditingController());
        tempSku.add(TextEditingController());
        list.add(state.groups[groupIndex].fetchedExtras![itemIndex]);
        selectGroups[key] = list;
        state = state.copyWith(quantityControllers: tempQuantity, priceControllers: tempPrice, skuControllers: tempSku);

      }
    } else {
      selectGroups[key] = [state.groups[groupIndex].fetchedExtras![itemIndex]];
    }
    state = state.copyWith(selectGroups: selectGroups);
    await combination();
    toggleCheckedGroup(groupIndex);
    List<TextEditingController> quantity = [];
    List<TextEditingController> price = [];
    List<TextEditingController> sku = [];
    for (int index = 0; index < _localStocks.length; index++) {
      quantity.add(
          TextEditingController(text: "${_localStocks[index].quantity ?? ""}"));
      sku.add(TextEditingController(text: _localStocks[index].sku ?? ''));
      price.add(
          TextEditingController(text: "${_localStocks[index].price ?? ""}"));
    }

    state = state.copyWith(
      stocks: _localStocks,
      quantityControllers: quantity,
      priceControllers: price,
      skuControllers: sku,
    );
  }
  combination() {
    List<TextEditingController> tempQuantity = List.from(state.quantityControllers);
    tempQuantity.add(TextEditingController());
    List<TextEditingController> tempPrice = List.from(state.priceControllers);
    tempPrice.add(TextEditingController());
    List<TextEditingController> tempSku = List.from(state.skuControllers);
    tempSku.add(TextEditingController());
    List<Stocks> stocks = [];
    if (state.selectGroups.values.isNotEmpty) {
      List<List<Extras>> list =
      AppHelpers.cartesian(List.from(state.selectGroups.values));
      stocks =
          List.generate(list.length, (index) => Stocks(extras: list[index]));
    } else {
      stocks = [Stocks()];
    }
    _localStocks = stocks;
    state = state.copyWith(quantityControllers: tempQuantity, priceControllers: tempPrice, skuControllers: tempSku);

  }

  Future<void> fetchGroupExtras(
      BuildContext context, {
        required int groupIndex,
        VoidCallback? onSuccess,
      }) async {
    if (state.groups[groupIndex].fetchedExtras?.isNotEmpty ?? false) {
      state = state.copyWith(
        activeGroupExtras: state.groups[groupIndex].fetchedExtras ?? [],
      );
      return;
    }
    state = state.copyWith(isLoading: true);
    final response = await _productsRepository.getExtras(
      groupId: state.groups[groupIndex].id,
    );
    response.when(
      success: (data) {
        final List<Extras> fetchedExtras = data.data?.extraValues ?? <Extras>[];
        List<Group> activeGroups = List.from(state.groups);
        activeGroups[groupIndex] =
            activeGroups[groupIndex].copyWith(fetchedExtras: fetchedExtras);

        /// save fetched extras to groups
        List<Group> groups = List.from(state.groups);
        int mainGroupIndex = 0;
        for (int i = 0; i < groups.length; i++) {
          if (groups[i].id == activeGroups[groupIndex].id) {
            mainGroupIndex = i;
          }
        }
        groups[mainGroupIndex] =
            groups[mainGroupIndex].copyWith(fetchedExtras: fetchedExtras);
        state = state.copyWith(
          isLoading: false,
          activeGroupExtras: fetchedExtras,
          groups: groups,
          stocks: _localStocks,
        );
      },
      failure: (failure, status) {
        state = state.copyWith(isLoading: false);
        AppHelpers.showSnackBar(context, failure);
        debugPrint('===> group extras fetching failed $failure');
      },
    );
  }

  void deleteStock(int index) {
    List<TextEditingController> quantity = List.from(state.quantityControllers);
    List<TextEditingController> price = List.from(state.priceControllers);
    List<TextEditingController> sku = List.from(state.skuControllers);
    quantity.removeAt(index);
    price.removeAt(index);
    sku.removeAt(index);
    _localStocks.removeAt(index);
    state = state.copyWith(
        stocks: _localStocks,
        // priceControllers: price,
        // skuControllers: sku,
        // quantityControllers: quantity
    );
  }

  void addEmptyStock() {
    List<Extras>? extras = _localStocks.last.extras;
    List<TextEditingController> tempQuantity = List.from(state.quantityControllers);
    tempQuantity.add(TextEditingController());
    List<TextEditingController> tempPrice = List.from(state.priceControllers);
    tempPrice.add(TextEditingController());
    List<TextEditingController> tempSku = List.from(state.skuControllers);
    tempSku.add(TextEditingController());
    extras = extras?.map((e) => e.copyWith(value: null)).toList();
    _localStocks
        .add(_localStocks.last.copyWith(isInitial: true, extras: extras));
    state = state.copyWith(stocks: _localStocks);

    state = state.copyWith(stocks: _localStocks, quantityControllers: tempQuantity, priceControllers: tempPrice, skuControllers: tempSku);
  }

  List<Group> _checkGroupsChecked(List<Group> groups) {
    for (int i = 0; i < groups.length; i++) {
      groups[i] = groups[i].copyWith(isChecked: false);
    }
    if (state.stocks.isNotEmpty) {
      final List<Extras> stockExtras = state.stocks.first.extras ?? [];
      for (int i = 0; i < groups.length; i++) {
        for (final extras in stockExtras) {
          if (extras.extraGroupId == groups[i].id) {
            groups[i] = groups[i].copyWith(isChecked: true);
          }
        }
      }
    }
    return groups;
  }

  Future<void> fetchGroups() async {
    if (state.groups.isNotEmpty) {
      List<Group> groups = List.from(state.groups);
      groups = _checkGroupsChecked(groups);
      state = state.copyWith(groups: groups);
      return;
    }
    state = state.copyWith(isFetchingGroups: true);
    final response = await _productsRepository.getExtrasGroups();
    response.when(
      success: (data) {
        List<Group> groups = data.data ?? [];
        state = state.copyWith(
          groups: _checkGroupsChecked(groups),
          isFetchingGroups: false,
        );
      },
      failure: (fail, status) {
        state = state.copyWith(isFetchingGroups: false);
      },
    );
  }

  void setAllQuantity({required String value}) {
    int newQuantity = int.tryParse(value.trim()) ?? 0;
    List<TextEditingController> tempQuantityControllers = List.from(state.quantityControllers);
    for (int index = 0; index < _localStocks.length; index++) {
      _localStocks[index] = _localStocks[index].copyWith(quantity: newQuantity);
      tempQuantityControllers[index].text = value;
    }
    state = state.copyWith(quantityControllers: tempQuantityControllers);
  }

  void setAllSku({required String value}) {
    String newSku = value;
    List<TextEditingController> tempSkuControllers = List.from(state.skuControllers);
    for (int index = 0; index < _localStocks.length; index++) {
      _localStocks[index] = _localStocks[index].copyWith(sku: newSku);
      tempSkuControllers[index].text = value;

    }
    state = state.copyWith(skuControllers: tempSkuControllers);

  }

  void setAllPrice({required String value}) {
    int newPrice = int.tryParse(value.trim()) ?? 0;
    List<TextEditingController> tempPriceControllers = List.from(state.priceControllers);
    for (int index = 0; index < _localStocks.length; index++) {
      _localStocks[index] = _localStocks[index].copyWith(price: newPrice);
      tempPriceControllers[index].text = value;
    }
    state = state.copyWith(priceControllers: tempPriceControllers);

  }

  void setSku({required String value, required int index}) {
    _localStocks[index] = _localStocks[index].copyWith(sku: value.trim());
  }

  void setQuantity({required String value, required int index}) {
    _localStocks[index] =
        _localStocks[index].copyWith(quantity: int.tryParse(value.trim()));
  }

  void setPrice({required String value, required int index}) {
    _localStocks[index] =
        _localStocks[index].copyWith(price: num.tryParse(value.trim()));
  }

  Future<void> updateStocks(

      BuildContext context, {
        //String? uuid,
        ValueChanged<ProductData?>? updated,
        VoidCallback? failed,
      }) async {
    state = state.copyWith(isSaving: true);
    final response = await _productsRepository.updateStocks(
      deletedStocks: [],
      stocks: _localStocks,
      uuid: state.uuid,
      isWholeSalesPrice: false
    );
    response.when(
      success: (data) {
        List<Stocks> tempStocks = List.from(state.updatedStocks);
        tempStocks.addAll(data.data?.stocks ?? []);
        state = state.copyWith(
          isSaving: false,
          updatedStocks: tempStocks,
          stocks: data.data?.stocks ?? [],
        );
        updated?.call(data.data);
      },
      failure: (failure, status) {
        state = state.copyWith(isSaving: false);
        AppHelpers.showSnackBar(context, failure);
        failed?.call();
      },
    );
  }

  void setInitialStocks() {
    List<TextEditingController> tempQuantity = List.from(state.quantityControllers);
    tempQuantity.add(TextEditingController());
    List<TextEditingController> tempPrice = List.from(state.priceControllers);
    tempPrice.add(TextEditingController());
    List<TextEditingController> tempSku = List.from(state.skuControllers);
    tempSku.add(TextEditingController());
    final List<Stocks> stocks = [Stocks()];
    state = state.copyWith(stocks: stocks, selectGroups: {}, quantityControllers: tempQuantity, priceControllers: tempPrice, skuControllers: tempSku);
    _localStocks = stocks;
    fetchGroups();
  }
}
