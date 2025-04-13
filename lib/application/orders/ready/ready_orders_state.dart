import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:admin_desktop/domain/models/models.dart';
part 'ready_orders_state.freezed.dart';

@freezed
class ReadyOrdersState with _$ReadyOrdersState {
  const factory ReadyOrdersState({
    @Default(false) bool isLoading,
    @Default(true) bool hasMore,
    @Default([]) List<OrderData> orders,
    @Default(0) int totalCount,
    @Default('') String query,
  }) = _ReadyOrdersState;

  const ReadyOrdersState._();
}
