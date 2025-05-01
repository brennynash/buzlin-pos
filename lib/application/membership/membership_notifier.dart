import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/models.dart';
import '../../domain/repository/membership_repository.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'membership_state.dart';

class MembershipNotifier extends StateNotifier<MembershipState> {
  final MembershipRepository _membershipRepository;

  int _page = 0;

  MembershipNotifier(this._membershipRepository)
      : super(const MembershipState());

  fetchMemberships({
    BuildContext? context,
    bool? isRefresh,
  }) async {
    if (isRefresh ?? false) {
      _page = 0;
      state = state.copyWith(list: [], isLoading: true, hasMore: true);
    }
    final res = await _membershipRepository.getMemberships(
      page: ++_page,
    );
    res.when(success: (data) {
      List<MembershipData> list = List.from(state.list);
      list.addAll(data.data ?? []);
      state = state.copyWith(
          isLoading: false,
          list: list,
          hasMore: list.length < (data.meta?.total ?? 0)
      );
      if (isRefresh ?? false) {
        return;
      } else if (data.data?.isEmpty ?? true) {
        return;
      }
      return;
    }, failure: (failure, status) {
      state = state.copyWith(isLoading: false);
      debugPrint(" ==> fetch ads fail: $failure");
      if (context != null) {
        AppHelpers.errorSnackBar(context, text: failure);
      }
    });
  }

  Future<void> deleteMembership(BuildContext context, int? id) async {
    state = state.copyWith(isLoading: true);
    final response = await _membershipRepository.deleteMembership(id);
    response.when(
      success: (success) {
        List<MembershipData> list = List.from(state.list);
        list.removeWhere((element) => element.id == id);
        state = state.copyWith(list: list);
      },
      failure: (failure, status) {
        AppHelpers.errorSnackBar(context, text: failure,);
      },
    );
    state = state.copyWith(isLoading: false);
  }
}
