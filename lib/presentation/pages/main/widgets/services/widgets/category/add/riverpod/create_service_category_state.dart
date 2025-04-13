import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../../../../../../domain/models/models.dart';

part 'create_service_category_state.freezed.dart';

@freezed
class CreateServiceCategoryState with _$CreateServiceCategoryState {
  const factory CreateServiceCategoryState({
    @Default('') String title,
    @Default('') String description,
    @Default(true) bool active,
    @Default(false) bool isLoading,
    @Default(false) bool isInitial,
    String? imageFile,
    CategoryData? category,
    @Default({}) Map<String, List<String>> mapOfDesc,
    LanguageData? language,
    TextEditingController? titleController,
    TextEditingController? descriptionController,
  }) = _CreateServiceCategoryState;

  const CreateServiceCategoryState._();
}
