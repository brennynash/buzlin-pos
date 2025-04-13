import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin_desktop/domain/di/dependency_manager.dart';
import 'new_masters_notifier.dart';
import 'new_masters_state.dart';

final newMastersProvider =
    StateNotifierProvider<NewMastersNotifier, NewMastersState>(
  (ref) => NewMastersNotifier(usersRepository),
);
