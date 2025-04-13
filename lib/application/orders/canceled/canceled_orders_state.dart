import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:admin_desktop/domain/models/models.dart';
part 'canceled_orders_state.freezed.dart';

@freezed
class CanceledOrdersState with _$CanceledOrdersState {
  const factory CanceledOrdersState({
    @Default(false) bool isLoading,
    @Default(true) bool hasMore,
    @Default([]) List<OrderData> orders,
    @Default(0) int totalCount,
    @Default('') String query,

  }) = _CanceledOrdersState;

  const CanceledOrdersState._();
}
