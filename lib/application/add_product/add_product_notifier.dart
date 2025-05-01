import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/models.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'add_product_state.dart';

class AddProductNotifier extends StateNotifier<AddProductState> {
  AddProductNotifier() : super(const AddProductState());

  void setProduct(ProductData? product, int bagIndex) {
    final List<Stocks> stocks = product?.stocks ?? <Stocks>[];
    state = state.copyWith(
      isLoading: false,
      product: product,
      initialStocks: stocks,
      stockCount: product?.minQty ?? 0,
    );
    if (stocks.isNotEmpty) {
      final int groupsCount = stocks.first.extras?.length ?? 0;
      final List<int> selectedIndexes = List.filled(groupsCount, 0);
      initialSetSelectedIndexes(selectedIndexes, bagIndex);
    }
  }

  void setColorExtraOpened(){
    state= state.copyWith(isColorExtrasOpened: !state.isColorExtrasOpened);
  }
  void setTextExtraOpened(){
    state= state.copyWith(isTextExtrasOpened: !state.isTextExtrasOpened);
  }
  void setImageExtraOpened(){
    state= state.copyWith(isImageExtrasOpened: !state.isImageExtrasOpened);
  }
  void clearSelectedExtra(){
    state = state.copyWith(colorExtra: null, imageExtra: null, textExtra: null);
  }
  void updateSelectedIndexes({
    TypedExtra? typedExtra,
    required int index,
    required int value,
    required int bagIndex,
    UiExtra? uiExtra,
  }) {
    final newList = state.selectedIndexes.sublist(0, index);
    newList.add(value);
    final postList =
        List.filled(state.selectedIndexes.length - newList.length, 0);
    newList.addAll(postList);
    initialSetSelectedIndexes(newList, bagIndex);
    if(typedExtra != null){
      if(typedExtra.type == ExtrasType.color){
        state = state.copyWith(colorExtra: uiExtra);
      }
      if(typedExtra.type == ExtrasType.text){
        state = state.copyWith(textExtra: uiExtra);
      }
      if(typedExtra.type == ExtrasType.image){
        state = state.copyWith(imageExtra: uiExtra);
      }
    }
  }

  void initialSetSelectedIndexes(List<int> indexes, int bagIndex) {
    state = state.copyWith(selectedIndexes: indexes);
    updateExtras(bagIndex);
  }

  void updateExtras(int bagIndex) {
    final int groupsCount = state.initialStocks[0].extras?.length ?? 0;
    final List<TypedExtra> groupExtras = [];
    for (int i = 0; i < groupsCount; i++) {
      if (i == 0) {
        final TypedExtra extras = StockFormat.getFirstExtras(
            state.selectedIndexes[0], state.initialStocks);
        groupExtras.add(extras);
      } else {
        final TypedExtra extras = StockFormat.getUniqueExtras(
          groupExtras,
          state.selectedIndexes,
          i,
          state.initialStocks,
        );
        groupExtras.add(extras);
      }
    }
    Stocks? selectedStock = StockFormat.getSelectedStock(
        groupExtras, state.initialStocks, state.selectedIndexes);
    final bag = LocalStorage.getBags()[bagIndex].bagProducts ?? [];
    for (int i = 0; i < bag.length; i++) {
      if (bag[i].stockId == selectedStock?.id) {
        selectedStock = selectedStock?.copyWith(cartCount: bag[i].quantity);
      }
    }
    state =
        state.copyWith(typedExtras: groupExtras, selectedStock: selectedStock);
  }



  Stocks? getSelectedStock(List<TypedExtra> groupExtras) {
    List<Stocks> stocks = List.from(state.initialStocks);
    for (int i = 0; i < groupExtras.length; i++) {
      String selectedExtrasValue =
          groupExtras[i].uiExtras[state.selectedIndexes[i]].value;
      stocks = getSelectedStocks(stocks, selectedExtrasValue, i);
    }
    return stocks[0];
  }

  List<Stocks> getSelectedStocks(List<Stocks> stocks, String value, int index) {
    List<Stocks> included = [];
    for (int i = 0; i < stocks.length; i++) {
      if (stocks[i].extras?[index].value == value) {
        included.add(stocks[i]);
      }
    }
    return included;
  }

  TypedExtra getFirstExtras(int selectedIndex) {
    ExtrasType type = ExtrasType.text;
    String title = '';
    final List<String> uniques = [];
    for (int i = 0; i < state.initialStocks.length; i++) {
      uniques.add(state.initialStocks[i].extras?[0].value ?? '');
      title = state.initialStocks[i].extras?[0].group?.translation?.title ?? '';
      type = AppHelpers.getExtraTypeByValue(
          state.initialStocks[i].extras?[0].group?.type);
    }
    final setOfUniques = uniques.toSet().toList();
    final List<UiExtra> extras = [];
    for (int i = 0; i < setOfUniques.length; i++) {
      if (selectedIndex == i) {
        extras.add(UiExtra(setOfUniques[i], true, i));
      } else {
        extras.add(UiExtra(setOfUniques[i], false, i));
      }
    }
    return TypedExtra(type, extras, title, 0);
  }



  List<Stocks> getIncludedStocks(
    List<Stocks> includedStocks,
    int index,
    String includedValue,
  ) {
    List<Stocks> stocks = [];
    for (int i = 0; i < includedStocks.length; i++) {
      if (includedStocks[i].extras?[index].value == includedValue) {
        stocks.add(includedStocks[i]);
      }
    }
    return stocks;
  }

  void increaseStockCount(int bagIndex) {
    if ((state.selectedStock?.quantity ?? 0) < (state.product?.minQty ?? 0)) {
      return;
    }
    int newCount = state.stockCount;
    if (newCount >= (state.product?.maxQty ?? 100000) ||
        newCount >= (state.selectedStock?.quantity ?? 100000)) {
      return;
    } else if (newCount < (state.product?.minQty ?? 0)) {
      newCount = state.product?.minQty ?? 1;
      state = state.copyWith(stockCount: newCount);
    } else {
      newCount = newCount + 1;
      state = state.copyWith(stockCount: newCount);
    }
  }

  void decreaseStockCount(int bagIndex) {
    int newCount = state.stockCount;
    if (newCount <= 1) {
      return;
    } else if (newCount <= (state.product?.minQty ?? 0)) {
      newCount = 0;
      state = state.copyWith(stockCount: newCount);
      // deleteProductFromCart(state.product?.minQty ?? 0, bagIndex);
    } else {
      newCount = newCount - 1;
      state = state.copyWith(stockCount: newCount);
      // deleteProductFromCart(1, bagIndex);
    }
  }

  Future<void> addProductToBag(
      BuildContext context,
      int bagIndex,
      Function(List<BagProductData>) updateProducts,
      ) async {
    final List<BagProductData> bagProducts =
        LocalStorage.getBags()[bagIndex].bagProducts ?? [];

    int newStockIndex = -1;
    List<BagProductData> list = [];

    if (newStockIndex == -1) {
      bagProducts.insert(
        0,
        BagProductData(
            stockId: state.selectedStock?.id,
            quantity: (state.stockCount != 0 ? state.stockCount : 1),
            carts: list),
      );
    } else {
      bagProducts.removeAt(newStockIndex);
      bagProducts.insert(
        newStockIndex,
        BagProductData(
            stockId: state.selectedStock?.id,
            quantity: state.stockCount,
            carts: list),
      );
    }

    List<BagData> bags = List.from(LocalStorage.getBags());
    bags[bagIndex] = bags[bagIndex].copyWith(bagProducts: bagProducts);
    await LocalStorage.setBags(bags);
    updateProducts(bagProducts);
  }
}
