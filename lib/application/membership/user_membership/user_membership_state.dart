import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_desktop/domain/models/models.dart';
part 'user_membership_state.freezed.dart';

@freezed
class UserMembershipState with _$UserMembershipState {
  const factory UserMembershipState({
    @Default(false) bool isLoading,
    @Default([]) List<UserMembershipData> list,
  }) = _UserMembershipState;

  const UserMembershipState._();
}
