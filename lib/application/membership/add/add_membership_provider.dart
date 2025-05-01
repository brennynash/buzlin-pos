import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin_desktop/domain/di/dependency_manager.dart';
import 'add_membership_notifier.dart';
import 'add_membership_state.dart';

final addMembershipProvider =
    StateNotifierProvider<AddMembershipNotifier, AddMembershipState>(
  (ref) => AddMembershipNotifier(membershipRepository),
);
