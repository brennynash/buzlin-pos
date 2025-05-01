import 'package:admin_desktop/domain/models/models.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'brand_state.freezed.dart';

@freezed
class BrandState with _$BrandState {
  const factory BrandState({
    @Default(false) bool isLoading,
    @Default(false) bool hasMore,
    @Default(false) bool showFilter,
    @Default([]) List<Brand> brands,
    @Default([]) List<Brand> allBrands,
    @Default(false) bool isAllSelect,
    @Default([]) List selectBrands,
    @Default('') String query,
  }) = _BrandState;

  const BrandState._();
}
