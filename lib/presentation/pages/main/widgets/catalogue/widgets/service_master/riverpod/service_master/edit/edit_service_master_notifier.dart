import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../../../../../../../domain/models/models.dart';
import '../../../../../../../../../../domain/repository/service_master_repository.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'edit_service_master_state.dart';

class EditServiceMasterNotifier extends StateNotifier<EditServiceMasterState> {
  final ServiceMasterFacade _serviceRepository;

  EditServiceMasterNotifier(this._serviceRepository)
      : super(const EditServiceMasterState());

  void changeActive(bool? active) {
    state = state.copyWith(active: !state.active);
  }

  Future<void> fetchServiceDetails({
    required BuildContext context,
    required int? id,
    required ValueChanged<ServiceData?>? onSuccess,
  }) async {
    state = state.copyWith(isLoading: true);
    final res = await _serviceRepository.fetchSingleService(id);
    res.when(success: (data) {
      state = state.copyWith(
        isLoading: false,
        serviceData: data.data,
      );
      onSuccess?.call(data.data);
    }, failure: (failure, status) {
      state = state.copyWith(isLoading: false);
      AppHelpers.errorSnackBar(context, text: failure);
    });
  }

  void setGender(String value) {
    state = state.copyWith(
      serviceData: state.serviceData?.copyWith(gender: value),
    );
  }

  Future<void> updateService(
    BuildContext context, {
    required String price,
    required String commissionFee,
    required String pause,
    required String interval,
    required int serviceId,
    required int masterId,
    ValueChanged<ServiceData?>? updated,
    VoidCallback? failed,
  }) async {
    if (state.serviceData?.gender?.isEmpty ?? true) {
      AppHelpers.errorSnackBar(context,
          text: AppHelpers.getTranslation(TrKeys.genderIsNotEmpty));
      return;
    }
    final response = await _serviceRepository.updateService(
        price: num.tryParse(price) ?? 0,
        pause: int.tryParse(pause) ?? 0,
        interval: int.tryParse(interval) ?? 0,
        serviceId: serviceId,
        masterId: masterId,
        id: state.serviceData?.id,
        commissionFee: num.tryParse(commissionFee) ?? 0,
        gender: state.serviceData?.gender ?? '');
    response.when(
      success: (data) {
        state = state.copyWith(isUpdating: false);
        updated?.call(data.data);
      },
      failure: (fail, status) {
        AppHelpers.errorSnackBar(
          context,
          text: fail,
        );
        state = state.copyWith(isUpdating: false);
        debugPrint('===> service update fail $fail');
        failed?.call();
      },
    );
  }

  Future<void> setDetails(ServiceData? serviceData) async {
    state = state.copyWith(serviceData: serviceData);
  }
}
