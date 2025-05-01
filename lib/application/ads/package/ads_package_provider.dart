import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin_desktop/domain/di/dependency_manager.dart';
import 'ads_package_state.dart';
import 'ads_package_notifier.dart';

final adsPackageProvider = StateNotifierProvider<AdsPackageNotifier, AdsPackageState>(
  (ref) => AdsPackageNotifier(adsRepository),
);
