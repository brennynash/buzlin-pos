import 'package:admin_desktop/domain/models/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_food_details_state.freezed.dart';

@freezed
class CreateFoodDetailsState with _$CreateFoodDetailsState {
  const factory CreateFoodDetailsState({
    @Default('') String title,
    @Default('') String description,
    @Default('') String tax,
    @Default('') String minQty,
    @Default('') String maxQty,
    @Default('') String qrcode,
    @Default(true) bool active,
    @Default('') String interval,
    @Default(false) bool digital,
    @Default('') String ageLimit,
    @Default([]) List<String> images,
    @Default(false) bool isCreating,
    @Default(false) bool showFilter,
    @Default(0) int stateIndex,
    @Default([]) List<Galleries> listOfUrls,
    @Default({}) Map<String, List<String>>mapOfDesc,
    ProductData? createdProduct,
    LanguageData? language,
    TextEditingController? titleController,
    TextEditingController? descriptionController,
  }) = _CreateFoodDetailsState;

  const CreateFoodDetailsState._();
}
