import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:admin_desktop/domain/di/dependency_manager.dart';
import 'package:admin_desktop/domain/handlers/handlers.dart';
import 'package:admin_desktop/domain/models/data/customer_data.dart';
import 'package:admin_desktop/domain/models/models.dart';
import 'package:admin_desktop/domain/models/response/delivery_zone_paginate.dart';
import 'package:admin_desktop/domain/models/response/edit_profile.dart';
import 'package:admin_desktop/domain/models/response/profile_response.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import '../repository.dart';

class UsersRepositoryImpl extends UsersFacade {
  @override
  Future<ApiResult<UsersPaginateResponse>> searchUsers({
    String? query,
    String? role,
    String? inviteStatus,
    int? page,
    int? serviceId,
  }) async {
    final data = {
      if (query?.isNotEmpty ?? false) 'search': query,
      'perPage': 14,
      if (page != null) 'page': page,
      'sort': 'desc',
      'column': 'created_at',
      if (inviteStatus != null) 'invite_status': inviteStatus,
      if (role != null) 'role': role,
      if (serviceId != null) 'service_id': serviceId,
    };
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.get(
        serviceId != null
            ? '/api/v1/rest/masters'
            : role == TrKeys.deliveryman
                ? '/api/v1/dashboard/seller/shop/users/role/$role'
                : role != null
                    ? '/api/v1/dashboard/seller/shop/users/paginate'
                    : '/api/v1/dashboard/seller/users/paginate',
        queryParameters: data,
      );
      return ApiResult.success(
        data: UsersPaginateResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> search users failure: $e');
      return ApiResult.failure(
          error: AppHelpers.errorHandler(e),
          status: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<UsersPaginateResponse>> searchDeliveryman(
      String? query) async {
    final data = {
      if (query != null) 'search': query,
      'lang': LocalStorage.getLanguage()?.locale ?? 'en',
    };
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.get(
        '/api/v1/dashboard/seller/shop/users/role/deliveryman',
        queryParameters: data,
      );
      return ApiResult.success(
        data: UsersPaginateResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> search users failure: $e');
      return ApiResult.failure(error: AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<ApiResult<SingleUserResponse>> getUserDetails(String uuid) async {
    final data = {'lang': LocalStorage.getLanguage()?.locale ?? 'en'};
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.get(
        '/api/v1/dashboard/seller/users/$uuid',
        queryParameters: data,
      );
      return ApiResult.success(
        data: SingleUserResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get user details failure: $e');
      return ApiResult.failure(error: AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<ApiResult<void>> updateDeliveryZones({
    required List<LatLng> points,
  }) async {
    List<Map<String, dynamic>> tapped = [];
    for (final point in points) {
      final location = {'0': point.latitude, '1': point.longitude};
      tapped.add(location);
    }
    final data = {
      'shop_id': LocalStorage.getUser()?.shop?.id,
      'address': tapped,
    };
    debugPrint('====> update delivery zone ${jsonEncode(data)}');
    try {
      final client = dioHttp.client(requireAuth: true);
      await client.post(
        '/api/v1/dashboard/seller/delivery-zones',
        data: data,
      );
      return const ApiResult.success(data: null);
    } catch (e) {
      debugPrint('==> update delivery zones failure: $e');
      return ApiResult.failure(error: AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<ApiResult<DeliveryZonePaginate>> getDeliveryZone() async {
    final int? shopID = LocalStorage.getUser()?.shop?.id;
    final data = {
      'lang': LocalStorage.getLanguage()?.locale ?? 'en',
    };
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.get(
        '/api/v1/rest/shop/delivery-zone/$shopID',
        queryParameters: data,
      );
      return ApiResult.success(
        data: DeliveryZonePaginate.fromJson(response.data),
      );
    } catch (e, s) {
      debugPrint('===> error get delivery zone $e');
      debugPrint('===> error get delivery zone $s');
      return ApiResult.failure(error: AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<ApiResult<ProfileResponse>> getProfileDetails() async {
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.get(
        '/api/v1/dashboard/user/profile/show',
      );
      debugPrint(
          '===> update general info data ${ProfileResponse.fromJson(response.data)}');
      return ApiResult.success(
        data: ProfileResponse.fromJson(response.data),
      );
    } catch (e) {
      return ApiResult.failure(
        error: AppHelpers.errorHandler(e),
        status: NetworkExceptions.getDioStatus(e),
      );
    }
  }

  @override
  Future<ApiResult<bool>> checkDriverZone(LatLng location, int? shopId) async {
    try {
      final client = dioHttp.client(requireAuth: false);
      final data = <String, dynamic>{
        'address[latitude]': location.latitude,
        'address[longitude]': location.longitude,
      };

      final response = await client.get(
          '/api/v1/rest/shop/$shopId/delivery-zone/check/distance',
          queryParameters: data);

      return ApiResult.success(
        data: response.data["status"],
      );
    } catch (e) {
      debugPrint('==> get delivery zone failure: $e');
      return ApiResult.failure(
        error: AppHelpers.errorHandler(e),
      );
    }
  }

  @override
  Future<ApiResult<CouponData>> checkCoupon({
    required String coupon,
  }) async {
    final data = {
      'coupon': coupon,
      'shop_id': LocalStorage.getUser()?.shop?.id,
    };
    try {
      final client = dioHttp.client(requireAuth: true);
      final res = await client.post(
        '/api/v1/rest/coupons/check',
        data: data,
      );
      return ApiResult.success(data: CouponData.fromJson(res.data['data']));
    } catch (e) {
      return ApiResult.failure(
        error: AppHelpers.errorHandler(e),
      );
    }
  }

  @override
  Future<ApiResult<ProfileResponse>> updatePassword(
      {required String password, required String passwordConfirmation}) async {
    final data = {
      'password': password,
      'password_confirmation': passwordConfirmation,
    };
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.post(
        '/api/v1/dashboard/user/profile/password/update',
        data: data,
      );
      return ApiResult.success(
        data: ProfileResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> update password failure: $e');
      return ApiResult.failure(
        error: AppHelpers.errorHandler(e),
      );
    }
  }

  @override
  Future<ApiResult<ProfileResponse>> updateProfileImage(
      {required String firstName, required String imageUrl}) async {
    final data = {
      'firstname': firstName,
      'images': [imageUrl],
    };
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.put(
        '/api/v1/dashboard/user/profile/update',
        data: data,
      );
      return ApiResult.success(
        data: ProfileResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> update profile image failure: $e');
      return ApiResult.failure(
        error: AppHelpers.errorHandler(e),
      );
    }
  }

  @override
  Future<ApiResult<ProfileResponse>> editProfile(
      {required EditProfile? user}) async {
    final data = user?.toJson();
    debugPrint('===> update general info data ${jsonEncode(data)}');
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.put(
        '/api/v1/dashboard/user/profile/update',
        data: data,
      );
      return ApiResult.success(
        data: ProfileResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> update profile details failure: $e');
      return ApiResult.failure(
        error: AppHelpers.errorHandler(e),
      );
    }
  }

  @override
  Future<ApiResult<ProfileResponse>> createUser(
      {required CustomerData query}) async {
    final data = query.toJson();
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.post(
        '/api/v1/dashboard/seller/users',
        data: data,
      );
      return ApiResult.success(
        data: ProfileResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> create user failure: $e');
      return ApiResult.failure(
        error: AppHelpers.errorHandler(e),
      );
    }
  }

  @override
  Future<ApiResult<UsersPaginateResponse>> getUsers({int? page}) async {
    final data = {
      'perPage': 6,
    };
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.get(
          '/api/v1/dashboard/seller/users/paginate',
          queryParameters: data);
      return ApiResult.success(
        data: UsersPaginateResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get users failure: $e');
      return ApiResult.failure(error: AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<ApiResult<TransactionPaginationResponse>> getTransactions(
      int page) async {
    final data = {
      'page': page,
      'perPage': 10,
      if (LocalStorage.getSelectedCurrency()?.id != null)
        'currency_id': LocalStorage.getSelectedCurrency()?.id,
      "lang": LocalStorage.getLanguage()?.locale ?? 'en'
    };
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.get(
        '/api/v1/dashboard/user/wallet/histories',
        queryParameters: data,
      );
      return ApiResult.success(
        data: TransactionPaginationResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get wallet histories failure: $e');
      return ApiResult.failure(
        error: AppHelpers.errorHandler(e),
      );
    }
  }

  @override
  Future<ApiResult> updateMasterStatus({
    required int? id,
    required MasterStatus status,
  }) async {
    String? statusText;
    switch (status) {
      case MasterStatus.newMaster:
        statusText = 'new';
        break;
      case MasterStatus.acceptedMaster:
        statusText = 'accepted';
        break;
      case MasterStatus.cancelledMaster:
        statusText = 'canceled';
        break;
      case MasterStatus.rejectedMaster:
        statusText = 'rejected';
        break;
    }
    final data = {'status': statusText};
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.post(
        '/api/v1/dashboard/seller/shops/invites/$id/status/change',
        data: data,
      );
      return ApiResult.success(
        data: response.data,
      );
    } catch (e) {
      debugPrint('==> update master status failure: $e');
      return ApiResult.failure(
        error: AppHelpers.errorHandler(e),
        //statusCode: NetworkExceptions.getDioStatus(e),
      );
    }
  }

  @override
  Future<ApiResult> updateStatus({
    required int? id,
    required String status,
  }) async {
    List list = [
      TrKeys.newKey,
      TrKeys.viewed,
      TrKeys.accepted,
      TrKeys.rejected
    ];
    final data = {'status': list.indexOf(status) + 1};
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.post(
        '/api/v1/dashboard/seller/shops/invites/$id/status/change',
        data: data,
      );
      return ApiResult.success(data: response.data);
    } catch (e) {
      debugPrint('==> update master status failure: $e');
      return ApiResult.failure(
        error: AppHelpers.errorHandler(e),
        status: NetworkExceptions.getDioStatus(e),
      );
    }
  }
}
