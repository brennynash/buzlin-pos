import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/di/dependency_manager.dart';
import 'comments_notifier.dart';
import 'comments_state.dart';


final commentsProvider = StateNotifierProvider<CommentsNotifier, CommentsState>(
  (ref) => CommentsNotifier(commentsRepository),
);
