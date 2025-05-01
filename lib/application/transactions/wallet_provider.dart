import 'package:admin_desktop/domain/di/dependency_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'wallet_state.dart';
import 'wallet_notifier.dart';

final walletProvider = StateNotifierProvider<WalletNotifier, WalletState>(
  (ref) => WalletNotifier(usersRepository,walletRepository),
);
