import 'package:admin_desktop/infrastructure/services/utils.dart';

import '../../domain/handlers/handlers.dart';
import '../../domain/models/response/stock_paginate_response.dart';

abstract class StockRepository {
  Future<ApiResult<StockPaginateResponse>> getStocks({
    required int page,
    int? categoryId,
    String? query,
    ProductStatus? status,
    int? brandId,
    bool? isNew,
    List<int>? brandIds,
    List<int>? categoryIds,
    List<int>? extrasId,
    num? priceTo,
    num? priceFrom,
  });
}
