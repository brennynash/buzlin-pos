import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin_desktop/domain/di/dependency_manager.dart';
import 'add_forms_notifier.dart';
import 'add_forms_state.dart';

final addFormProvider =
    StateNotifierProvider<AddFormNotifier, AddFormOptionState>(
  (ref) => AddFormNotifier(formRepository),
);
