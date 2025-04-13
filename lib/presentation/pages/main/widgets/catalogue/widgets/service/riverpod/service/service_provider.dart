import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../../../../domain/di/dependency_manager.dart';
import 'service_notifier.dart';
import 'service_state.dart';

final serviceProvider = StateNotifierProvider<ServiceNotifier, ServiceState>(
  (ref) => ServiceNotifier(serviceRepository),
);
