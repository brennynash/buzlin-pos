import '../../domain/handlers/handlers.dart';
import '../../domain/models/response/ads_package_response.dart';
import '../../domain/models/response/ads_response.dart';


abstract class AdsRepository {
  Future<ApiResult<AdsResponse>> getAds({required int page});

  Future<ApiResult> purchaseAds({required int id});

  Future<ApiResult<AdsPackageResponse>> getAdsPackages({required int page});

  Future<ApiResult> addAdsPackages(
      {required int? id, required List productIds});
}
