import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin_desktop/domain/di/dependency_manager.dart';
import 'rejected_masters_notifier.dart';
import 'rejected_masters_state.dart';

final rejectedMastersProvider =
    StateNotifierProvider<RejectedMastersNotifier, RejectedMastersState>(
  (ref) => RejectedMastersNotifier(usersRepository),
);
