import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin_desktop/domain/di/dependency_manager.dart';
import 'edit_masters_notifier.dart';
import 'edit_masters_state.dart';

final editMastersProvider =
    StateNotifierProvider<EditMastersNotifier, EditMastersState>(
  (ref) => EditMastersNotifier(mastersRepository, settingsRepository),
);
