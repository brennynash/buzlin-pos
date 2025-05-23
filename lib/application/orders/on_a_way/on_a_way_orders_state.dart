import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:admin_desktop/domain/models/models.dart';
part 'on_a_way_orders_state.freezed.dart';

@freezed
class OnAWayOrdersState with _$OnAWayOrdersState {
  const factory OnAWayOrdersState({
    @Default(false) bool isLoading,
    @Default(true) bool hasMore,
    @Default([]) List<OrderData> orders,
    @Default(0) int totalCount,
    @Default('') String query,

  }) = _OnAWayOrdersState;

  const OnAWayOrdersState._();
}
