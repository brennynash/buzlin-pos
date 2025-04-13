import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:admin_desktop/domain/models/models.dart';
part 'new_masters_state.freezed.dart';

@freezed
class NewMastersState with _$NewMastersState {
  const factory NewMastersState({
    @Default(false) bool isLoading,
    @Default([]) List<UserData> users,
    @Default(0) int totalCount,
    @Default(true) bool hasMore,
  }) = _NewMastersState;

  const NewMastersState._();
}
