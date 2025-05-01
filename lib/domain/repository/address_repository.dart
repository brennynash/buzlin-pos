import 'package:admin_desktop/domain/models/models.dart';

import '../../domain/handlers/handlers.dart';

abstract class AddressRepository {
  Future<ApiResult<CountryPaginationResponse>> getCountry({required int page});

  Future<ApiResult<CountryPaginationResponse>> searchCountry(
      {required String search});

  Future<ApiResult<CityResponseModel>> getCity(
      {required int page, required int countyId});

  Future<ApiResult<CityResponseModel>> searchCity(
      {required String search, required int countyId});

  Future<ApiResult<DeliveryPointsResponse>> getDeliveryPoints(
      {required int page, required int countryId, int? cityId});

  Future<ApiResult<DeliveryPointsResponse>> getDeliveryPrice(
      {required int countryId, required int cityId});
}
