import 'package:admin_desktop/domain/models/models.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'address_state.freezed.dart';

@freezed
class AddressState with _$AddressState {
  const factory AddressState({
    @Default([]) List<CountryData> countries,
    @Default([]) List<CityData> cities,
    @Default(false) bool isLoading,
    @Default(false) bool isCountryLoading,
    @Default(false) bool isCityLoading,
    @Default(0) int countryId,
    @Default(true) bool hasMore,
    @Default(true) bool hasMoreCountry,

  }) = _AddressState;
}
