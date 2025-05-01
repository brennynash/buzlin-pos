import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:admin_desktop/domain/models/models.dart';
part 'edit_food_details_state.freezed.dart';

@freezed
class EditFoodDetailsState with _$EditFoodDetailsState {
  const factory EditFoodDetailsState({
    @Default(false) bool isLoading,
    @Default(false) bool active,
    @Default("New") String featureType,
    @Default('') String title,
    @Default('') String description,
    @Default('') String minQty,
    @Default('') String maxQty,
    @Default(0) int stateIndex,
    @Default('') String quantity,
    @Default(false) bool digital,
    @Default(0) int ageLimit,
    @Default('') String tax,
    @Default('') String barcode,
    @Default('') String interval,
    @Default([]) List<String> images,
    @Default([]) List<Galleries> listOfUrls,
    ProductData? product,
    LanguageData? language,
    TextEditingController? titleController,
    TextEditingController? descriptionController,
    @Default({}) Map<String, List<String>>mapOfDesc,
  }) = _EditFoodDetailsState;

  const EditFoodDetailsState._();
}
