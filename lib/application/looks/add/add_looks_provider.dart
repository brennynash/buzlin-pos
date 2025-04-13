import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin_desktop/domain/di/dependency_manager.dart';
import 'add_looks_notifier.dart';
import 'add_looks_state.dart';

final addLooksProvider =
    StateNotifierProvider<AddLooksNotifier, AddLooksState>(
  (ref) => AddLooksNotifier(looksRepository, settingsRepository),
);
