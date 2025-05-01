import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:admin_desktop/domain/models/models.dart';
part 'accepted_orders_state.freezed.dart';

@freezed
class AcceptedOrdersState with _$AcceptedOrdersState {
  const factory AcceptedOrdersState({
    @Default(false) bool isLoading,
    @Default(true) bool hasMore,
    @Default([]) List<OrderData> orders,
    @Default(0) int totalCount,
    @Default('') String query,
  }) = _AcceptedOrdersState;

  const AcceptedOrdersState._();
}
