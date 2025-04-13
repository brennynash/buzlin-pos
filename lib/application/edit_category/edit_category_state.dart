import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/models/models.dart';
part 'edit_category_state.freezed.dart';


@freezed
class EditCategoryState with _$EditCategoryState {
  const factory EditCategoryState({
    @Default(false) bool isLoading,
    @Default(false) bool isUpdate,
    @Default(false) bool active,
    @Default('') String title,
    @Default('') String description,
    @Default([]) List<String> images,
    String? imageFile,
    @Default([]) List<Galleries> listOfUrls,
    CategoryData? category,
    @Default({}) Map<String, List<String>>mapOfDesc,
    LanguageData? language,
    TextEditingController? titleController,
    TextEditingController? descriptionController,
  }) = _EditCategoryState;

  const EditCategoryState._();
}
