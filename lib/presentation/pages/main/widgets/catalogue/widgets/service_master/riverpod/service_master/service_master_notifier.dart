import 'dart:async';
import '../../../../../../../../../../domain/models/models.dart';
import '../../../../../../../../../domain/repository/service_master_repository.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'service_master_state.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ServiceMasterNotifier extends StateNotifier<ServiceMasterState> {
  final ServiceMasterFacade _serviceMasterRepository;
  int _page = 0;

  ServiceMasterNotifier(this._serviceMasterRepository)
      : super(const ServiceMasterState());

  Future<void> fetchServices({
    required BuildContext context,
    bool? isRefresh,
    RefreshController? controller,
  }) async {
    if (isRefresh ?? false) {
      controller?.resetNoData();
      _page = 0;
      state = state.copyWith(services: [], isLoading: true, hasMore: true);
    }
    final res = await _serviceMasterRepository.getServices(page: ++_page);
    res.when(success: (data) {
      List<ServiceData> list = List.from(state.services);
      list.addAll(data.data ?? []);
      state = state.copyWith(
          isLoading: false,
          services: list,
          hasMore: list.length < (data.meta?.total ?? 0));
      if (isRefresh ?? false) {
        controller?.refreshCompleted();
        return;
      } else if (data.data?.isEmpty ?? true) {
        controller?.loadNoData();
        return;
      }
      controller?.loadComplete();
      return;
    }, failure: (failure, status) {
      state = state.copyWith(isLoading: false);
      AppHelpers.errorSnackBar(context, text: failure);
    });
  }

  Future<void> deleteService(BuildContext context, int? id) async {
    state = state.copyWith(isLoading: true);
    final response = await _serviceMasterRepository.deleteService(id);
    response.when(
      success: (success) {
        List<ServiceData> list = List.from(state.services);
        list.removeWhere((element) => element.id == id);
        state = state.copyWith(services: list, isLoading: false);
      },
      failure: (failure, status) {
        state = state.copyWith(isLoading: false);
        AppHelpers.errorSnackBar(
          context,
          text: failure,
        );
      },
    );
  }

  Future<void> addService(
    ServiceData? service,
  ) async {
    if (service == null) return;
    List<ServiceData> list = List.from(state.services);
    int? index;
    for (int i = 0; i < list.length; i++) {
      if (service.id == list[i].id) {
        index = i;
      }
    }
    if (index != null) {
      list[index] = service.copyWith(translation: list[index].translation);
    } else {
      list.add(service);
    }
    state = state.copyWith(services: list);
  }
}
