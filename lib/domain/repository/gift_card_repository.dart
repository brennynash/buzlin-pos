import '../handlers/api_result.dart';
import '../models/models.dart';

abstract class GiftCardRepository {

  Future<ApiResult<SingleGiftCardResponse>> getGiftCardDetails(int? id);

  Future<ApiResult<GiftCardResponse>> getGiftCarts({int? page});

  Future<ApiResult<void>> deleteGiftCard(int? id);

  Future<ApiResult> addGiftCards({
    required String title,
    required String description,
    required String? time,
    required num price,
    required bool active
  });

  Future<ApiResult> updateGiftCard({
    required String title,
    required String description,
    required String? time,
    required num price,
    required int? id,
    required bool active
  });

  Future<ApiResult<UserGiftCardResponse>> getUserGiftCards({
    int? page,
    String? search,
  });
}
