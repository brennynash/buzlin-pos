import 'package:admin_desktop/domain/models/models.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'order_details_state.freezed.dart';

@freezed
class OrderDetailsState with _$OrderDetailsState {
  const factory OrderDetailsState({
    @Default(false) bool isLoading,
    @Default("") String status,
    @Default('') String usersQuery,
    @Default(false) bool isUsersLoading,
    @Default([]) List<UserData> users,
    UserData? selectedUser,
    @Default(false) bool isUpdating,
    @Default([]) List<DropDownItemData> dropdownUsers,
    OrderData? order,
    Stocks? oldStock,
    Stocks? changedStock,
    @Default(0) int changedQuantity,
    ProductData? productData,
    @Default([]) List<Stocks> initialStocks,
    @Default(0) int stockCount,
    UiExtra? colorExtra,
    UiExtra? textExtra,
    UiExtra? imageExtra,
    Stocks? selectedStock,
    @Default([]) List<int> selectedIndexes,
    @Default([]) List<TypedExtra> typedExtras,
  }) = _OrderDetailsState;

  const OrderDetailsState._();
}
