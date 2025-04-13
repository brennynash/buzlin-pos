import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin_desktop/domain/di/dependency_manager.dart';
import 'cancelled_masters_notifier.dart';
import 'cancelled_masters_state.dart';

final cancelledMastersProvider =
    StateNotifierProvider<CancelledMastersNotifier, CancelledMastersState>(
  (ref) => CancelledMastersNotifier(usersRepository),
);
