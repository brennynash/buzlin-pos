import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/models/models.dart';
part 'main_state.freezed.dart';

@freezed
class MainState with _$MainState {
  const factory MainState({
    @Default(false) bool isProductsLoading,
    @Default(false) bool isMoreProductsLoading,
    @Default(false) bool isShopsLoading,
    @Default(false) bool isBrandsLoading,
    @Default(false) bool isCategoriesLoading,
    @Default(true) bool hasMore,
    @Default(true) bool active,
    @Default(0) int selectIndex,
    @Default([]) List<ProductData> products,
    @Default([]) List<ShopData> shops,
    @Default([]) List<CategoryData> categories,
    @Default([]) List<Brand> brands,
    @Default([]) List<DropDownItemData> dropDownShops,
    @Default([]) List<DropDownItemData> dropDownCategories,
    @Default([]) List<DropDownItemData> dropDownBrands,
    @Default('') String query,
    @Default('') String shopQuery,
    @Default('') String categoryQuery,
    @Default('') String brandQuery,
    ShopData? selectedShop,
    CategoryData? selectedCategory,
    Brand? selectedBrand,
    OrderData? selectedOrder,
    PriceData? priceDate,
    ShopData? shop,
  }) = _MainState;

  const MainState._();
}
