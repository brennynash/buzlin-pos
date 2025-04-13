import 'package:admin_desktop/domain/models/models.dart';
import 'package:flutter/material.dart';
import 'package:admin_desktop/domain/di/dependency_manager.dart';
import 'package:admin_desktop/domain/handlers/handlers.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import '../address_repository.dart';

class AddressRepositoryImpl implements AddressRepository {
  @override
  Future<ApiResult<CountryPaginationResponse>> getCountry(
      {required int page}) async {
    final data = {
      'perPage': 40,
      'page': page,
      'lang': LocalStorage.getLanguage()?.locale ?? 'en',
      'has_price': 1
    };
    try {
      final client = dioHttp.client(requireAuth: false);
      final response = await client.get(
        '/api/v1/rest/countries',
        queryParameters: data,
      );
      return ApiResult.success(
          data: CountryPaginationResponse.fromJson(response.data));
    } catch (e) {
      debugPrint('==> get country paginate failure: $e');
      return ApiResult.failure(error: AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<ApiResult<CountryPaginationResponse>> searchCountry(
      {required String search}) async {
    final data = {
      'perPage': 40,
      "search": search,
      'lang': LocalStorage.getLanguage()?.locale ?? 'en',
      'has_price': 1
    };
    try {
      final client = dioHttp.client(requireAuth: false);
      final response = await client.get(
        '/api/v1/rest/countries',
        queryParameters: data,
      );
      return ApiResult.success(
          data: CountryPaginationResponse.fromJson(response.data));
    } catch (e) {
      debugPrint('==> search country paginate failure: $e');
      return ApiResult.failure(error: AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<ApiResult<CityResponseModel>> getCity(
      {required int page, required int countyId}) async {
    final data = {
      'perPage': 40,
      'page': page,
      'lang': LocalStorage.getLanguage()?.locale ?? 'en',
      'country_id': countyId,
      'has_price': 1

    };
    try {
      final client = dioHttp.client(requireAuth: false);
      final response = await client.get(
        '/api/v1/rest/cities',
        queryParameters: data,
      );
      return ApiResult.success(data: CityResponseModel.fromJson(response.data));
    } catch (e) {
      debugPrint('==> get city paginate failure: $e');
      return ApiResult.failure(error: AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<ApiResult<CityResponseModel>> searchCity(
      {required String search, required int countyId}) async {
    final data = {
      'perPage': 40,
      "search": search,
      'lang': LocalStorage.getLanguage()?.locale ?? 'en',
      'country_id': countyId,
      'has_price': 1
    };
    try {
      final client = dioHttp.client(requireAuth: false);
      final response = await client.get(
        '/api/v1/rest/cities',
        queryParameters: data,
      );
      return ApiResult.success(data: CityResponseModel.fromJson(response.data));
    } catch (e) {
      debugPrint('==> search city paginate failure: $e');
 return ApiResult.failure(error: AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<ApiResult<DeliveryPointsResponse>> getDeliveryPoints({
    required int page,
    required int countryId,
    int? cityId,
  }) async {
    final data = {
      'perPage': 40,
      'page': page,
      if (cityId == null) 'country_id': countryId,
      if (cityId != null) 'city_id': cityId,
    };
    debugPrint("request delivery point => $data");

    try {
      final client = dioHttp.client(requireAuth: false);
      final response = await client.get(
        '/api/v1/rest/delivery-points',
        queryParameters: data,
      );
      return ApiResult.success(
          data: DeliveryPointsResponse.fromJson(response.data));
    } catch (e) {
      debugPrint('==> delivery points failure: $e');
      return ApiResult.failure(error: AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<ApiResult<DeliveryPointsResponse>> getDeliveryPrice(
      {required int countryId, required int cityId}) async {
    final data = {
      'perPage': 1,
      'lang': LocalStorage.getLanguage()?.locale,
      'country_id': countryId,
      'city_id': cityId,
    };
    try {
      final client = dioHttp.client(requireAuth: false);
      final response = await client.get(
        '/api/v1/rest/delivery-prices',
        queryParameters: data,
      );
      return ApiResult.success(
          data: DeliveryPointsResponse.fromJson(response.data));
    } catch (e) {
      debugPrint('==> get country paginate failure: $e');
      return ApiResult.failure(
        error: AppHelpers.errorHandler(e),
      );
    }
  }
}
