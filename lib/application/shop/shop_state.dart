import 'package:admin_desktop/domain/models/models.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'shop_state.freezed.dart';

@freezed
class ShopState with _$ShopState {
  const factory ShopState({
    @Default(true) bool isEditShopData,
    @Default(false) bool isSave,
    @Default(true) bool isUpdate,
    @Default(false) bool isButtonLoading,
    @Default(false) bool isActive,
    @Default(false) bool isLogoImageLoading,
    @Default(false) bool isBackImageLoading,
    @Default(false) bool isShopLocationsLoading,
    @Default([]) List<UserData> users,
    @Default([]) List<AddressData> userAddresses,
    @Default(-1) int selectedCloseDay,
    @Default(0) double shopTax,
    @Default('') String usersQuery,
    @Default('') String tableQuery,
    @Default('') String sectionQuery,
    @Default('') String orderType,
    @Default('') String calculate,
    @Default('') String comment,
    @Default('') String logoImagePath,
    @Default('') String logoImageUrl,
    @Default('') String backImagePath,
    @Default('') String backImageUrl,
    @Default(null) CategoriesPaginateResponse? categories,
    @Default(null) CategoriesPaginateResponse? tag,
    ShopData? editShopData,
    AddressData? selectedAddress,
    int? regionId,
    int? countryId,
    int? cityId,
  }) = _ShopState;

  const ShopState._();
}
