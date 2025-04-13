import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/models/models.dart';
part 'comments_state.freezed.dart';

@freezed
class CommentsState with _$CommentsState {
  const factory CommentsState({
    @Default(false) bool isLoading,
    @Default([]) List<CommentsData> productComments,
    @Default([]) List<ShopCommentsData> shopComments,
    @Default(1) int activeIndex,
    @Default(0) int stateIndex,
    @Default(-1) int selectedProductComment,
    @Default(-1) int selectedShopComment,
    @Default(true) bool hasMore,
    @Default(true) bool hasMoreProductComment,
  }) = _CommentsState;

  const CommentsState._();
}
