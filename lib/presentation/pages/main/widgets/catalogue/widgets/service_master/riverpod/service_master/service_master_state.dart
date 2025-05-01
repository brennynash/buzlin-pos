import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../../../../../../../domain/models/models.dart';

part 'service_master_state.freezed.dart';

@freezed
class ServiceMasterState with _$ServiceMasterState {
  const factory ServiceMasterState({
    @Default(false) bool isLoading,
    @Default(true) bool hasMore,
    @Default([]) List<ServiceData> services,
  }) = _ServiceMasterState;

  const ServiceMasterState._();
}
