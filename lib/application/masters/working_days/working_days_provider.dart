import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin_desktop/domain/di/dependency_manager.dart';
import 'working_days_state.dart';
import 'working_days_notifier.dart';

final masterWorkingDaysProvider =
    StateNotifierProvider<MasterWorkingDaysNotifier,MasterWorkingDaysState>(
  (ref) => MasterWorkingDaysNotifier(mastersRepository),
);
