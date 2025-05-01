import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin_desktop/domain/di/dependency_manager.dart';
import 'disable_times_state.dart';
import 'disable_times_notifier.dart';

final masterDisableTimesProvider =
    StateNotifierProvider<MasterDisableTimesNotifier,MasterDisableTimesState>(
  (ref) => MasterDisableTimesNotifier(mastersRepository),
);
