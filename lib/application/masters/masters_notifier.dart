import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'masters_state.dart';

class MastersNotifier extends StateNotifier<MastersState> {

  MastersNotifier() : super(const MastersState());

  void setAppbarDetails(int? index) {
    state = state.copyWith(index: index ?? 0);
  }

  void setStatusIndex(int? index) {
    state = state.copyWith(statusIndex: index ?? 0);
  }

  // Future<void> updateMasterStatus({
  //   required int? id,
  //   required String status,
  //   ValueChanged<int>? onSuccess,
  // }) async {
  //   state=state.copyWith(isUpdate:true);
  //   final response = await _usersRepository.updateMasterStatus(
  //     id: id,
  //     status: status,
  //   );
  //   response.when(
  //     success: (data) {
  //       state = state.copyWith(statusIndex: -1,isUpdate:false);
  //       final List statuses = [
  //         TrKeys.newKey,
  //         TrKeys.accepted,
  //         TrKeys.canceled,
  //         TrKeys.rejected
  //       ];
  //       onSuccess?.call(statuses.indexOf(status));
  //     },
  //     failure: (failure, status) {
  //       state=state.copyWith(isUpdate:false);
  //       debugPrint('===> update master status fail $failure');
  //     },
  //   );
  // }
}
