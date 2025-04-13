import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin_desktop/domain/di/dependency_manager.dart';
import 'user_membership_state.dart';
import 'user_membership_notifier.dart';

final userMembershipProvider =
    StateNotifierProvider<UserMembershipNotifier, UserMembershipState>(
  (ref) => UserMembershipNotifier(membershipRepository),
);
