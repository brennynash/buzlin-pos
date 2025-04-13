import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../domain/handlers/handlers.dart';
import '../../domain/models/data/customer_data.dart';
import '../../domain/models/models.dart';
import '../../domain/models/response/delivery_zone_paginate.dart';
import '../../domain/models/response/edit_profile.dart';
import '../../domain/models/response/profile_response.dart';

abstract class UsersFacade {
  Future<ApiResult<UsersPaginateResponse>> searchUsers({
    String? query,
    String? role,
    String? inviteStatus,
    int? page,
    int? serviceId,
  });

  Future<ApiResult<UsersPaginateResponse>> searchDeliveryman(String? query);

  Future<ApiResult<SingleUserResponse>> getUserDetails(String uuid);

  Future<ApiResult<DeliveryZonePaginate>> getDeliveryZone();

  Future<ApiResult<void>> updateDeliveryZones({
    required List<LatLng> points,
  });
  Future<ApiResult<ProfileResponse>> getProfileDetails();

  Future<ApiResult<bool>> checkDriverZone(LatLng location, int? shopId);

  Future<ApiResult<CouponData>> checkCoupon({
    required String coupon,
  });

  Future<ApiResult<ProfileResponse>> editProfile({required EditProfile? user});

  Future<ApiResult<ProfileResponse>> updateProfileImage({
    required String firstName,
    required String imageUrl,
  });

  Future<ApiResult<ProfileResponse>> updatePassword({
    required String password,
    required String passwordConfirmation,
  });

  Future<ApiResult<UsersPaginateResponse>> getUsers({int? page});

  Future<ApiResult<ProfileResponse>> createUser({required CustomerData query});
  Future<ApiResult<TransactionPaginationResponse>> getTransactions(
      int page);

  Future<ApiResult> updateMasterStatus({
    required int? id,
    required MasterStatus status,
  });

  Future<ApiResult> updateStatus({
    required int? id,
    required String status,
  });
}
