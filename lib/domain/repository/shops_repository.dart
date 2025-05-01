import 'package:multi_dropdown/models/value_item.dart';
import '../../domain/handlers/handlers.dart';
import '../../domain/models/models.dart';
import '../../domain/models/response/shop_galleries_response.dart';
import '../../domain/models/response/single_shop_response.dart';
import '../../domain/models/response/social_response.dart';


abstract class ShopsRepository {
  Future<ApiResult<ShopsPaginateResponse>> searchShops(String? query);

  Future<ApiResult<ShopsPaginateResponse>> getShopsByIds(
      List<int> shopIds,
      );

  Future<ApiResult<ShopData>> getShopData();

  Future<ApiResult<CategoriesPaginateResponse>> getShopCategory();

  Future<ApiResult<CategoriesPaginateResponse>> getShopTag();

  Future<ApiResult<SingleShopResponse>> getMyShop();


  Future<ApiResult<ShopData>> updateShopData({
    required ShopData editShopData,
    required String logoImg,
    required String backImg,
    List<ValueItem>? category,
    List<ValueItem>? tag,
    List<ValueItem>? type,
    String? displayName
  });

  Future<ApiResult<void>> updateShopWorkingDays({
    required List<ShopWorkingDay> workingDays,
    String? uuid,
  });
  Future<ApiResult> addShopLocations({
    int? cityId,
    required int regionId,
    required int countryId,
  });
  Future<ApiResult> deleteShopLocation({
    required int countryId,
  });
  Future<ApiResult> addShopSocials({
    required List socialTypes,
    required List socialContents,
  });
  Future<ApiResult<ShopDeliveriesResponse>> getOnlyDeliveries();

  Future<ApiResult<SocialsResponse>> getShopSocials();

  Future<ApiResult> deleteShopSocial({
    required int socialId,
  });

  Future<ApiResult<ShopGalleriesResponse>> getGalleries();


  Future<ApiResult> setGalleries({
    required List<String> images,
    List<String>? previews,
  });


}
