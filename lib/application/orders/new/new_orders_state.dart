import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:admin_desktop/domain/models/models.dart';
part 'new_orders_state.freezed.dart';

@freezed
class NewOrdersState with _$NewOrdersState {
  const factory NewOrdersState({
    @Default(false) bool isLoading,
    @Default(true) bool hasMore,
    @Default([]) List<OrderData> orders,
    @Default(0) int totalCount,
    @Default('') String query,
  }) = _NewOrdersState;

  const NewOrdersState._();
}
