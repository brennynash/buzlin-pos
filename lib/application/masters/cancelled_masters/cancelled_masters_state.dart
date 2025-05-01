import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:admin_desktop/domain/models/models.dart';
part 'cancelled_masters_state.freezed.dart';

@freezed
class CancelledMastersState with _$CancelledMastersState {
  const factory CancelledMastersState({
    @Default(false) bool isLoading,
    @Default([]) List<UserData> users,
    @Default(0) int totalCount,
    @Default(true) bool hasMore,
  }) = _CancelledMastersState;

  const CancelledMastersState._();
}
