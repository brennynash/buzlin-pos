import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../../../../../../../domain/di/dependency_manager.dart';
import 'edit_service_notifier.dart';
import 'edit_service_state.dart';

final editServiceProvider =
    StateNotifierProvider<EditServiceNotifier, EditServiceState>(
  (ref) => EditServiceNotifier(serviceRepository, settingsRepository),
);
