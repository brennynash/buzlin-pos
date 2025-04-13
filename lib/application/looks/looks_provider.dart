import 'package:admin_desktop/domain/di/dependency_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'looks_notifier.dart';
import 'looks_state.dart';

final looksProvider = StateNotifierProvider<LooksNotifier, LooksState>(
  (ref) => LooksNotifier(looksRepository),
);
