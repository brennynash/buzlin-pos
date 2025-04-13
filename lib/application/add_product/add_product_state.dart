import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/models/models.dart';
part 'add_product_state.freezed.dart';

@freezed
class AddProductState with _$AddProductState {
  const factory AddProductState({
    @Default(false) bool isLoading,
    @Default(false) bool isReviewing,
    @Default(false) bool isColorExtrasOpened,
    @Default(false) bool isTextExtrasOpened,
    @Default(false) bool isImageExtrasOpened,
    @Default([]) List<TypedExtra> typedExtras,
    @Default([]) List<Stocks> initialStocks,
    @Default([]) List<int> selectedIndexes,
    @Default(0) int stockCount,
    LanguageData? language,
    UiExtra? colorExtra,
    UiExtra? textExtra,
    UiExtra? imageExtra,
    ProductData? product,
    Stocks? selectedStock,
  }) = _AddProductState;

  const AddProductState._();
}