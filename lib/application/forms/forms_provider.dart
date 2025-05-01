import 'package:admin_desktop/domain/di/dependency_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'forms_state.dart';
import 'forms_notifier.dart';

final formProvider = StateNotifierProvider<FormNotifier, FormOptionState>(
  (ref) => FormNotifier(formRepository),
);
