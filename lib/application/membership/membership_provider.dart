import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/di/dependency_manager.dart';
import 'membership_state.dart';
import 'membership_notifier.dart';

final membershipProvider =
    StateNotifierProvider<MembershipNotifier, MembershipState>(
  (ref) => MembershipNotifier(membershipRepository),
);
