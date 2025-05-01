import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:admin_desktop/domain/models/models.dart';
part 'rejected_masters_state.freezed.dart';

@freezed
class RejectedMastersState with _$RejectedMastersState {
  const factory RejectedMastersState({
    @Default(false) bool isLoading,
    @Default([]) List<UserData> users,
    @Default(0) int totalCount,
    @Default(true) bool hasMore,
  }) = _RejectedMastersState;

  const RejectedMastersState._();
}
