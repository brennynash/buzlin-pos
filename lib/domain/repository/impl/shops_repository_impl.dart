import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:multi_dropdown/models/value_item.dart';
import 'package:admin_desktop/domain/di/dependency_manager.dart';
import 'package:admin_desktop/domain/handlers/handlers.dart';
import 'package:admin_desktop/domain/models/models.dart';
import 'package:admin_desktop/domain/models/response/shop_galleries_response.dart';
import 'package:admin_desktop/domain/models/response/single_shop_response.dart';
import 'package:admin_desktop/domain/models/response/social_response.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import '../repository.dart';

class ShopsRepositoryImpl extends ShopsRepository {
  @override
  Future<ApiResult<ShopsPaginateResponse>> searchShops(String? query) async {
    final data = {
      if (query != null) 'search': query,
      'lang': LocalStorage.getLanguage()?.locale ?? 'en',
      'status': 'approved',
    };
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.get(
        '/api/v1/dashboard/${LocalStorage.getUser()?.role}/shops/search',
        queryParameters: data,
      );
      return ApiResult.success(
        data: ShopsPaginateResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> search shops failure: $e');
      return ApiResult.failure(error: AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<ApiResult<ShopsPaginateResponse>> getShopsByIds(
    List<int> shopIds,
  ) async {
    final data = <String, dynamic>{
      'lang': LocalStorage.getLanguage()?.locale ?? 'en',
    };
    for (int i = 0; i < shopIds.length; i++) {
      data['shops[$i]'] = shopIds[i];
    }
    try {
      final client = dioHttp.client(requireAuth: false);
      final response = await client.get(
        '/api/v1/rest/shops',
        queryParameters: data,
      );
      return ApiResult.success(
        data: ShopsPaginateResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get shops by ids failure: $e');
      return ApiResult.failure(error: AppHelpers.errorHandler(e));
    }
  }
  @override
  Future<ApiResult<ShopData>> getShopData() async {
    final data = <String, dynamic>{
      'lang': LocalStorage.getLanguage()?.locale ?? 'en',
    };
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.get(
        '/api/v1/dashboard/seller/shops',
        queryParameters: data,
      );
      return ApiResult.success(
        data: ShopData.fromJson(response.data['data']),
      );
    } catch (e, s) {
      debugPrint('==> get shops data failure: $e, $s');
      return ApiResult.failure(error: AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<ApiResult<SocialsResponse>> getShopSocials() async {
    final data = <String, dynamic>{
      'lang': LocalStorage.getLanguage()?.locale ?? 'en',
      'shop_id': LocalStorage.getUser()?.shop?.id
    };
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.get(
        '/api/v1/dashboard/seller/shop-socials',
        queryParameters: data,
      );
      return ApiResult.success(
        data: SocialsResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get shop socials failure: $e');
      return ApiResult.failure(error: AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<ApiResult<CategoriesPaginateResponse>> getShopCategory() async {
    final data = <String, dynamic>{
      'lang': LocalStorage.getLanguage()?.locale ?? 'en',
      'type': 'shop'
    };
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.get(
        '/api/v1/dashboard/seller/categories',
        queryParameters: data,
      );
      return ApiResult.success(
        data: CategoriesPaginateResponse.fromJson(response.data),
      );
    } catch (e, s) {
      debugPrint('==> get shops category failure: $e');
      debugPrint('==> get shops category failure: $s');
      return ApiResult.failure(error: AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<ApiResult<CategoriesPaginateResponse>> getShopTag() async {
    final data = <String, dynamic>{
      'lang': LocalStorage.getLanguage()?.locale ?? 'en',
    };
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.get(
        '/api/v1/dashboard/seller/shop-tags/paginate',
        queryParameters: data,
      );
      return ApiResult.success(
        data: CategoriesPaginateResponse.fromJson(response.data),
      );
    } catch (e, s) {
      debugPrint('==> get shops category failure: $e');
      debugPrint('==> get shops category failure: $s');
      return ApiResult.failure(error: AppHelpers.errorHandler(e));
    }
  }
  @override
  Future<ApiResult<SingleShopResponse>> getMyShop() async {
    final data = {
      'lang': LocalStorage.getLanguage()?.locale,
      //'currency_id': LocalStorage.getSelectedCurrency()?.id,
    };
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.get(
        '/api/v1/dashboard/seller/shops',
        queryParameters: data,
      );
      return ApiResult.success(
        data: SingleShopResponse.fromJson(response.data),
      );
    } catch (e, s) {
      debugPrint('===> error fetching my shop $e $s');
      return ApiResult.failure(
          error: AppHelpers.errorHandler(e),
      );
    }
  }
  @override
  Future<ApiResult<ShopData>> updateShopData({
    required ShopData editShopData,
    required String? logoImg,
    required String? backImg,
    List<ValueItem>? category,
    List<ValueItem>? tag,
    List<ValueItem>? type,
    String? displayName
  }) async {
    final data = <String, dynamic>{
      for (int i = 0; i < (category?.length ?? 0); i++)
        'categories[]': category?[i].value,
      for (int r = 0; r < (tag?.length ?? 0); r++) 'tags[]': tag?[r].value,
      'lang': LocalStorage.getLanguage()?.locale ?? 'en',
      if (logoImg?.isNotEmpty ?? false) 'images[0]': logoImg,
      if (backImg?.isNotEmpty ?? false) 'images[1]': backImg,
      'title': {
        LocalStorage.getLanguage()?.locale ?? 'en': editShopData.translation?.title
      },
      'description[${LocalStorage.getLanguage()?.locale ?? 'en'}]':
      editShopData.translation?.description,
      if (editShopData.statusNote?.isNotEmpty ?? false)
        'status_note': editShopData.statusNote,
      'status': editShopData.status.toString(),
      'phone': editShopData.phone?.replaceAll("+", "").replaceAll(" ", "").replaceAll("-", ""),
      'delivery_time_from': editShopData.deliveryTime?.from,
      'delivery_time_to': editShopData.deliveryTime?.to,
      'delivery_time_type': type?.isNotEmpty ?? false ? type?.first.value : 'hour',
      // 'min_amount': editShopData.minAmount.toString(),
      'tax': editShopData.tax,
      'lat_long': editShopData.latLong,
      'address': {
        LocalStorage.getLanguage()?.locale ?? 'en': displayName
      },
      'delivery_type': editShopData.deliveryType,
      'type': 'restaurant'
    };
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.put(
        '/api/v1/dashboard/seller/shops',
        data: data,
      );
      return ApiResult.success(
        data: ShopData.fromJson(response.data['data']),
      );
    } catch (e) {
      debugPrint('==> update shops data failure: $e');
      return ApiResult.failure(error: AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<ApiResult<void>> updateShopWorkingDays({
    required List<ShopWorkingDay> workingDays,
    String? uuid,
  }) async {
    List<Map<String, dynamic>> days = [];
    for (final workingDay in workingDays) {
      final data = {
        'day': workingDay.day,
        'from': workingDay.from?.replaceAll('-', ':'),
        'to': workingDay.to?.replaceAll('-', ':'),
        'disabled': workingDay.disabled
      };
      days.add(data);
    }
    final data = {'dates': days};
    debugPrint('====> update working days ${jsonEncode(data)}');
    try {
      final client = dioHttp.client(requireAuth: true);
      await client.put(
        '/api/v1/dashboard/seller/shop-working-days/${uuid ?? LocalStorage.getUser()?.shop?.uuid}',
        data: data,
      );
      return const ApiResult.success(data: null);
    } catch (e) {
      debugPrint('==> update shop working days failure: $e');
      return ApiResult.failure(error: AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<ApiResult> addShopLocations({
    int? cityId,
    required int regionId,
    required int countryId,
  }) async {
    final data = {
      'region_id': regionId,
      'country_id': countryId,
      if (cityId != null) 'city_id': cityId,
    };
    debugPrint('====> add shop locations ${jsonEncode(data)}');
    try {
      final client = dioHttp.client(requireAuth: true);
      await client.post(
        '/api/v1/dashboard/seller/shop-locations',
        data: data,
      );
      return const ApiResult.success(data: null);
    } catch (e) {
      debugPrint('==> add locations failure: $e');
      return ApiResult.failure(error: AppHelpers.errorHandler(e));

    }
  }

  @override
  Future<ApiResult> deleteShopLocation({
    required int countryId,
  }) async {
    final data = {
      'ids': [countryId],
    };
    debugPrint('====> delete shop locations ${jsonEncode(data)}');
    try {
      final client = dioHttp.client(requireAuth: true);
      await client.delete(
        '/api/v1/dashboard/seller/shop-locations/delete',
        data: data,
      );
      return const ApiResult.success(data: null);
    } catch (e) {
      debugPrint('==> add locations failure: $e');
      return ApiResult.failure(
          error: AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<ApiResult<ShopDeliveriesResponse>> getOnlyDeliveries() async {
    final data = {
      'currency_id': LocalStorage.getSelectedCurrency()?.id,
    };
    try {
      final client = dioHttp.client(requireAuth: false);
      final response = await client.get(
        '/api/v1/rest/shops/deliveries',
        queryParameters: data,
      );
      return ApiResult.success(
        data: ShopDeliveriesResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get shops deliveries failure: $e');
      return ApiResult.failure(error: AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<ApiResult> deleteShopSocial({
    required int socialId,
  }) async {
    final data = {
      'ids': [socialId],
    };
    debugPrint('====> delete shop social ${jsonEncode(data)}');
    try {
      final client = dioHttp.client(requireAuth: true);
      await client.delete(
        '/api/v1/dashboard/seller/shop-socials/delete',
        data: data,
      );
      return const ApiResult.success(data: null);
    } catch (e) {
      debugPrint('==> delete shop social: $e');
      return ApiResult.failure(
          error: AppHelpers.errorHandler(e));
    }
  }
  @override
  Future<ApiResult> addShopSocials({
    required List socialTypes,
    required List socialContents,
  }) async {
    List<Map<String, dynamic>> content = [];
    for (int i = 0; i < socialTypes.length; i++) {
      final data = {
        'type':socialTypes[i],
        'content':socialContents[i],
      };
      content.add(data);
    }
    final queryData = {"shop_id": LocalStorage.getUser()?.shop?.id};
    final data = {'data': content};
    debugPrint('====> error shop social adding ${jsonEncode(data)}');
    try {
      final client = dioHttp.client(requireAuth: true);
      await client.post(
        '/api/v1/dashboard/seller/shop-socials',
        data: data,
        queryParameters: queryData,
      );
      return const ApiResult.success(data: null);
    } catch (e) {
      debugPrint('==> add shop socials failure: $e');
      return ApiResult.failure(error: AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<ApiResult<ShopGalleriesResponse>> getGalleries() async {
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.get(
        '/api/v1/dashboard/seller/galleries',
      );
      return ApiResult.success(
        data: ShopGalleriesResponse.fromJson(response.data['data']),
      );
    } catch (e) {
      debugPrint('==> get shop galleries failure: $e');
      return ApiResult.failure(
          error: AppHelpers.errorHandler(e),
      );
    }
  }

  @override
  Future<ApiResult> setGalleries({
    required List<String> images,
    List<String>? previews,
  }) async {
    try {
      final data = {
        "active": 1,
        "images": images,
        if (previews != null) 'previews': previews,
      };
      final client = dioHttp.client(requireAuth: true);
      final response = await client.post(
        '/api/v1/dashboard/seller/galleries',
        data: data,
      );
      return ApiResult.success(data: response.data);
    } catch (e) {
      debugPrint('==> set shop galleries failure: $e');
      return ApiResult.failure(
          error: AppHelpers.errorHandler(e));
    }
  }
}
