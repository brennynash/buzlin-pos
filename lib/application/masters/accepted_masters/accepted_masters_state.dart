import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_desktop/domain/models/models.dart';
part 'accepted_masters_state.freezed.dart';

@freezed
class AcceptedMastersState with _$AcceptedMastersState {
  const factory AcceptedMastersState({
    @Default(false) bool isLoading,
    @Default([]) List<UserData> users,
    @Default(0) int totalCount,
    @Default(true) bool hasMore,
    @Default('') String acceptedMastersQuery,
    @Default([]) List<DropDownItemData> dropdownUsers,
  }) = _AcceptedMastersState;

  const AcceptedMastersState._();
}
