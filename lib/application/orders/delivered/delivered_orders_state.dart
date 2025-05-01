import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:admin_desktop/domain/models/models.dart';
part 'delivered_orders_state.freezed.dart';

@freezed
class DeliveredOrdersState with _$DeliveredOrdersState {
  const factory DeliveredOrdersState({
    @Default(false) bool isLoading,
    @Default(true) bool hasMore,
    @Default([]) List<OrderData> orders,
    @Default(0) int totalCount,
    @Default('') String query,
  }) = _DeliveredOrdersState;

  const DeliveredOrdersState._();
}
