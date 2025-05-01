import '../../domain/handlers/handlers.dart';
import '../../domain/models/response/comments_paginate_response.dart';
import '../../domain/models/response/shop_comments_paginate_response.dart';


abstract class CommentsRepository {
  Future<ApiResult<CommentsPaginateResponse>> getProductComments({
    int? page,
  });

  Future<ApiResult<ShopCommentsPaginateResponse>> getShopComments({
    int? page,
  });
}
