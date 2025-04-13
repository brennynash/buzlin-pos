import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/di/dependency_manager.dart';
import 'ads_state.dart';
import 'ads_notifier.dart';

final adsProvider = StateNotifierProvider<AdsNotifier, AdsState>(
  (ref) => AdsNotifier(adsRepository),
);
