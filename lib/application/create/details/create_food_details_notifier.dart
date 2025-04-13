import 'package:admin_desktop/domain/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:admin_desktop/domain/repository/repository.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'create_food_details_state.dart';

class CreateFoodDetailsNotifier extends StateNotifier<CreateFoodDetailsState> {
  final ProductsRepository _productsRepository;
  final GalleryRepositoryFacade _galleryRepository;

  CreateFoodDetailsNotifier(
    this._productsRepository,
    this._galleryRepository,
  ) : super(CreateFoodDetailsState(titleController: TextEditingController(), descriptionController: TextEditingController()));

  void updateAddFoodInfo() {
    state = state.copyWith(
      images: [],
      title: '',
      description: '',
      minQty: '',
      maxQty: '',
      tax: '',
      qrcode: '',
      interval: '',
      active: false,
      createdProduct: null,
    );
  }

  changeFilter() {
    state = state.copyWith(showFilter: !state.showFilter);
  }
  void changeState(int index) {
    state = state.copyWith(stateIndex: index);
  }
  void setLanguage(LanguageData? languageData) {
    state = state.copyWith(language: languageData);
  }

 void setDesc(){
    Map<String, List<String>> temp = Map.from(state.mapOfDesc);
    if(temp.containsKey(state.language?.locale)){
      List<String> list = [state.title, state.description];
      temp.update(state.language?.locale ?? "en", (value) => list);
    }else{
      List<String> list = [state.title, state.description];
      temp[state.language?.locale ?? "en"] = list;
    }
     state = state.copyWith(mapOfDesc: temp,);
 }

 void setTitleAndDescState(String key){
    state = state.copyWith(title: state.mapOfDesc[key]?.first ?? "", description: state.mapOfDesc[key]?.last ?? "");
    state.titleController?.text = state.mapOfDesc[key]?.first ?? "";
    state.descriptionController?.text = state.mapOfDesc[key]?.last ?? "";
 }

  Future<void> createProduct(
    BuildContext context, {
    int? categoryId,
    int? unitId,
    int? brandId,
    ValueChanged<String?>? created,
    VoidCallback? onError,
  }) async {
    state = state.copyWith(isCreating: true);
    List<String> imageUrl = List.from(state.listOfUrls.map((e) => e.path));
    if (state.images.isNotEmpty) {
      final imageResponse = await _galleryRepository.uploadMultiImage(
        state.images,
        UploadType.products,
      );
      imageResponse.when(
        success: (data) {
          imageUrl = data.data?.title ?? [];
        },
        failure: (failure, status) {
          debugPrint('==> upload product image fail: $failure');
          AppHelpers.showSnackBar(context, failure);
        },
      );
    }

    List<Galleries> tempList = List.from(List.from(state.listOfUrls)
        .where((element) => element.preview != null));
    List<String> previews = [];
    for (var element in tempList) {
      if (element.preview?.isNotEmpty ?? false) {
        previews.add(element.preview!);
      }
    }

    final response = await _productsRepository.createProduct(
      titlesAndDescriptions: state.mapOfDesc,
      tax: state.tax,
      minQty: state.minQty,
      maxQty: state.maxQty,
      active: state.active,
      categoryId: categoryId,
      unitId: unitId,
      brandId: brandId,
      image: imageUrl,
      interval: state.interval,
      ageLimit: state.ageLimit,
      previews: previews,
    );
    response.when(
      success: (data) {
        state = state.copyWith(isCreating: false, createdProduct: data.data);
        created?.call(data.data?.uuid);
        clearAll();
      },
      failure: (fail, status) {
        debugPrint('===> create product fail $fail');
        state = state.copyWith(isCreating: false);
         AppHelpers.showSnackBar(context, fail);
        onError?.call();
        // clearAll();
      },
    );
  }

  void setInterval(String value) {
    state = state.copyWith(interval: value.trim());
  }

  void setActive(bool? value) {
    state = state.copyWith(active: !state.active);
  }

  void setDigital(bool? value) {
    state = state.copyWith(digital: !state.digital);
  }

  void setMaxQty(String value) {
    state = state.copyWith(maxQty: value.trim());
  }

  void setMinQty(String value) {
    state = state.copyWith(minQty: value.trim());
  }

  void setTax(String value) {
    state = state.copyWith(tax: value.trim());
  }

  void setDescription(String value) {
    state = state.copyWith(description: value.trim());
  }

  void setTitle(String value) {
    state = state.copyWith(title: value.trim());
  }

  void setUploadImage(Galleries gallery) {
    List<Galleries> list = List.from(state.listOfUrls);
    list.insert(0, gallery);
    state = state.copyWith(listOfUrls: list);
  }

  void setAgeLimit(String value) {
    state = state.copyWith(ageLimit: value);
  }

  void setImageFile(String file) {
    List<String> list = List.from(state.images);
    list.add(file);
    state = state.copyWith(images: list);
  }

  void deleteImage(String value) {
    List<String> list = List.from(state.images);
    list.remove(value);
    state = state.copyWith(images: list);
  }

  void clearAll() {
    state = state.copyWith(
      descriptionController: TextEditingController(),
      titleController: TextEditingController(),
      images: [],
      title: '',
      ageLimit: '',
      description: '',
      //digital: false,
      active: true,
      interval: '',
      tax: '',
      maxQty: '',
      minQty: '',
      qrcode: '',
    );
    setLanguage(LocalStorage.getLanguage());
  }
}
