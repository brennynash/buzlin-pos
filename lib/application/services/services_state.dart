import 'package:freezed_annotation/freezed_annotation.dart';
part 'services_state.freezed.dart';

@freezed
class ServicesState with _$ServicesState {
  const factory ServicesState({
    @Default(true) bool isServicesOpen,
    @Default(0) int stateIndex,
  }) = _ServicesState;

  const ServicesState._();
}