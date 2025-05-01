import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_desktop/domain/models/models.dart';
part 'ads_package_state.freezed.dart';

@freezed
class AdsPackageState with _$AdsPackageState {
  const factory AdsPackageState({
    @Default(false) bool isLoading,
    @Default([]) List<AdsPackage> list,
  }) = _AdsPackage;

  const AdsPackageState._();
}
