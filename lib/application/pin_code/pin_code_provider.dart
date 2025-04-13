import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'pin_code_notifier.dart';
import 'pin_code_state.dart';

final pinCodeProvider =
    StateNotifierProvider.autoDispose<PinCodeNotifier, PinCodeState>(
  (ref) => PinCodeNotifier(),
);
